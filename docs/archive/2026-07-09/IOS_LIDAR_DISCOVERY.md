# iOS Build + LiDAR RoomPlan — Phase 0 Discovery

Read-only discovery for the "iOS build pipeline + LiDAR room scanning" task. This
records what exists today across both repos and flags every ambiguity that needs a
decision **before Phase 1**. Nothing in this pass was modified.

> TL;DR of the surprises
> 1. **Not a monorepo.** The Flutter app is its own repo (`andoza_ai_mobile`); the
>    backend + React studio are in `andoza_ai`. The `andoza_ai/ios` dir is a
>    **Capacitor** wrapper for the *web* app, unrelated to the Flutter iOS app.
> 2. **A LiDAR flow already exists** — but it's a *simulated box* on a different
>    MethodChannel (`com.tamir_uy/lidar`) than the task specifies (`andoza/roomscan`),
>    and it produces only width×length×height, not a RoomPlan parametric room.
> 3. **The room representation is already unified** (`RoomPlan` → `RoomCreate` →
>    `POST /apartments/{apt}/rooms`) with `RoomSource.lidar` already a first-class
>    enum value. The builder in the studio is fully source-agnostic.
> 4. **No iOS CI anywhere.** Blender/USDZ tooling absent. Prod has no shared media
>    volume between `api` and `worker`.

---

## 0. Repo topology — where each phase actually lands

| Local path | Git remote | Contents |
|---|---|---|
| `/home/rimefara/projects/tamir_uy_mobile_flutter` | `github.com/Begzod10/andoza_ai_mobile` | **Flutter app** (Dart, iOS `Runner`, Android). Phases 1, 2, 3, 6. |
| `/home/rimefara/projects/tamir_uy` | `github.com/Begzod10/andoza_ai` | **Backend** (`backend/`, FastAPI) + **web studio** (`frontend/`, React/Three.js) + a **Capacitor** iOS/`ios/` wrapper for the *web* app. Phases 4, 5. |

**Implication:** the task brief assumes one monorepo with a "mobile dir". In reality:
- `.github/workflows/ios.yml` and all Swift/Dart work go in **`andoza_ai_mobile`**.
- The workflow trigger should be `push` to that repo's default branch (currently
  **`main`**) — there is **no** mobile subdir to path-filter, so drop the
  `paths: [mobile/**]` filter idea; the whole repo *is* the mobile app.
- Phases 4 (backend) and 5 (studio) are commits in **`andoza_ai`**, whose `master`
  branch **auto-deploys to production** (see §8) — so those must be handled with the
  existing no-unauthorized-master-merge caution.
- `andoza_ai/ios` (Capacitor, appId `uz.uytamir.app`, `webDir: frontend/dist`) is
  **not** in scope and must not be touched.

> **DECISION NEEDED (D1):** confirm this doc + Phases 1/2/3/6 live in
> `andoza_ai_mobile`, and Phases 4/5 in `andoza_ai`. (This doc was written to
> `andoza_ai_mobile/docs/mobile/IOS_LIDAR_DISCOVERY.md`.)

---

## 1. iOS project state (Flutter `Runner`)

Repo: `andoza_ai_mobile`, dir `ios/`.

- **Podfile: absent.** No `ios/Podfile` exists; CocoaPods has never run. It will be
  generated on first `pod install` / `flutter build ios`; its `platform :ios` line
  must be set to match the deployment target.
- **Deployment target: `IPHONEOS_DEPLOYMENT_TARGET = 13.0`** (uniform across Debug/
  Release/Profile in `ios/Runner.xcodeproj/project.pbxproj`).
  - RoomPlan requires **iOS 16**; Object Capture requires **iOS 17**. Per the task,
    **do not raise the app-wide minimum** — gate with `@available(iOS 16/17, *)` and
    weak-link `RoomPlan`. The framework must be marked *Optional* so the app still
    launches on iOS 13–15.
- **`ios/Runner/Info.plist`:** contains the standard Flutter template keys and a
  `UIApplicationSceneManifest` with `UISceneDelegateClassName =
  $(PRODUCT_MODULE_NAME).SceneDelegate` (newer template). **No `NS*UsageDescription`
  keys exist yet.**
- **`ios/Runner/AppDelegate.swift`:** the **new "implicit engine" template** —
  `@main`, conforms to `FlutterImplicitEngineDelegate`, registers plugins in
  `didInitializeImplicitFlutterEngine(_:)` via
  `GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)`. There is
  **no `window.rootViewController` FlutterViewController** available in
  `didFinishLaunchingWithOptions`, and **no existing MethodChannel registration**.
  - **Consequence:** the RoomScan MethodChannel cannot be wired the classic
    `window?.rootViewController as! FlutterViewController` way. It must attach to the
    engine handed to `didInitializeImplicitFlutterEngine` (or via the SceneDelegate).
    Presenting the `RoomCaptureView` VC "over Flutter's root VC" must fetch the root
    VC from the active `UIWindowScene`, not `AppDelegate.window`.
- **Bundle identifiers (differ from Android — intentional, don't "fix"):**
  - iOS Runner: **`com.tamiruy.tamirUyMobileFlutter`** (all three configs).
  - Android: `com.tamir_uy.tamir_uy_mobile_flutter`.
  - `ExportOptions.plist` `__BUNDLE_ID__` and the provisioning profile must use the
    **iOS** id `com.tamiruy.tamirUyMobileFlutter`.

### Permissions to add to `Info.plist`
- **`NSCameraUsageDescription`** — required (ARKit/RoomPlan + the "360° Foto skan"
  camera). Uzbek text, e.g. *"Xonani skanerlash va rasmga olish uchun kamera
  kerak."*
- **`NSPhotoLibraryUsageDescription`** — required (`image_picker` gallery in
  `lib/screens/interior/wallpaper_library_sheet.dart`, `ImageSource.gallery`). Uzbek,
  e.g. *"Oboy rasmini tanlash uchun galereyaga ruxsat kerak."*
- **`NSLocationWhenInUseUsageDescription`** — **NOT needed.** No `geolocator`/
  `location`/`permission_handler` dependency; `flutter_map` is used without a
  device-location layer (grep for location APIs is empty). Do **not** add it.
- `UIFileSharingEnabled` / `LSSupportsOpeningDocumentsInPlace` — not present; add as
  `false` per the task.
- **Impeller:** leave iOS default (on). Do not copy Android's `EnableImpeller=false`.

---

## 2. The "Yangi loyiha" sheet, the LiDAR entry point, and the *existing* LiDAR flow

- **Sheet:** `lib/screens/room_setup/new_project_sheet.dart` —
  `showNewProjectSheet()` → `NewProjectSheet` (a plain `StatelessWidget`, **no
  Riverpod**), navigates with go_router `context.push` only. Four options:
  | Label | onTap route |
  |---|---|
  | "3D Sehrgar" | `/wizard` |
  | **"LiDAR skaner"** | `context.push('/scanning/lidar')` (`new_project_sheet.dart:82`) |
  | "360° Foto skan" | `/scanning/photo` |
  | "O'zingiz chizing" | `/setup/draw` |
- **Routes:** `lib/config/router.dart` — `/scanning/lidar` → `LiDARScanningScreen`,
  `/setup/draw` → `DrawRoomScreen`, `/setup/wall-measurements`, etc.

### The button is NOT a dead placeholder — there is a whole simulated LiDAR flow
- `lib/screens/scanning/lidar_scanning_screen.dart` already calls a real service and,
  on success, `applyScannedDimensions(width/length/height)` →
  `_seedRoomPlan()` → `context.push('/setup/wall-measurements')`.
- `lib/services/lidar_service.dart` defines
  **`MethodChannel('com.tamir_uy/lidar')`** with methods
  `isLidarAvailable → bool`, `startScan`, `stopScan`, `getScanData` (point cloud),
  **`scanRoom → {width, length, height, pointCount, durationMs}`**, `getMeasurements`.
  **No native handler is registered** (AppDelegate registers nothing), so on-device
  the channel throws and the screen falls back to a timer-driven **simulation**.
- `_seedRoomPlan()` already builds
  `RoomPlan.rectangle(width: wallB.length, length: wallA.length,
  ceilingHeightM: wallA.height, source: RoomSource.lidar)` — but it does **not**
  persist; it routes to wall-measurements and persistence happens later on the shared
  path.
- There is also a second, legacy provider file `lib/providers/lidar_provider.dart`
  (distinct from the in-screen `liDARScanProvider`).

> **DECISION NEEDED (D2) — the core reconciliation.** The task specifies a **new**
> `MethodChannel("andoza/roomscan")` returning a full RoomPlan `CapturedRoom`
> (walls, doors, windows, objects, `.usdz`), whereas the codebase already has a
> `com.tamir_uy/lidar` channel returning only a **bounding box** (w×l×h). Options:
> - **(recommended) Replace/upgrade** the existing LiDAR service to the RoomPlan
>   contract: repoint `lidar_service.dart` (and the screen) to `andoza/roomscan`,
>   return the parametric `CapturedRoom`, and delete the box-only `scanRoom`/point-
>   cloud methods and the legacy `lidar_provider.dart`. Keeps one entry point and one
>   simulation fallback. **Downside:** touches existing screens/providers/tests.
> - **Add alongside:** keep `com.tamir_uy/lidar` for the box path and add
>   `andoza/roomscan` for parametric; the screen chooses. **Downside:** two channels,
>   two sims, drift.
> The rest of this doc assumes the **replace/upgrade** option unless you say
> otherwise.

### Logger / error patterns (reuse these)
- Logger: `logger` pkg, `static final _logger = Logger();` per class; `_logger.i(...)`
  / `_logger.e('msg', error: e)`.
- Errors surface via **SnackBar only** (no dialogs): capture
  `final messenger = ScaffoldMessenger.of(context);` before the await, then
  `messenger.showSnackBar(SnackBar(content: Text('…: $e')))`. Reference:
  `wallpaper_library_sheet.dart`.

---

## 3. The room representation the LiDAR flow must reproduce ★ (most important)

Everything funnels into **one** POST. The manual flow and the (future) LiDAR flow
already share it.

### 3a. Unified in-app model — `lib/models/room_plan.dart`
- `enum RoomSource { lidar, photo, wizard, sketch, drag }` — **`lidar` already
  exists.**
- `RoomPlan { List<Vec2> corners /*metres*/, List<RoomWall> walls, double
  ceilingHeightM, RoomSource source, String name='Xona' }`.
- `RoomWall { int a, int b /*corner indices*/, double lengthM, List<RoomOpening>
  openings }`.
- `RoomOpening { String type /*'door'|'window'*/, double width, double height,
  double position /*0..1*/, double sillHeight /*m, default 0.0*/ }`.
- Builders: `RoomPlan.rectangle(width, length, ceilingHeightM, source)` — corners
  **CCW** `(0,0)→(0,length)→(width,length)→(width,0)`, walls map to legacy A/B/C/D;
  `RoomPlan.fromCorners(...)` for N-gons. `isAxisAlignedRect` picks the persistence
  path.
- `Vec2` = a 2-D point **in metres** (`lib/geometry/room_geometry.dart`).

### 3b. The wire DTO — `lib/models/api/room_create.dart` (Freezed)
```dart
enum WallElementType { eshik('eshik'), deraza('deraza'), balkon('balkon') } // door/window/balcony
WallElementCreate { type; width; height; sill_height=0.0; position=0.5; }     // metres, position 0..1
WallCreate        { id; length; elements=[] }                                 // length metres
RoomGeometryCreate{ walls; vertices?: List<List<double>> }                    // vertices metres, CCW
RoomCreate        { name; ceiling_h; geometry }                               // ceiling_h metres
```
Mappers `lib/utils/room_geometry_mapper.dart`:
- `roomToRoomCreate` → **rectangle** path: wall ids `A..D`, **omits `vertices`**
  (backend auto-fills), doors→`eshik` (sill 0), windows→`deraza` (sill def 0.9).
- `roomPlanToPolygonRoomCreate` → **polygon** path: wall ids `0..N-1`, **includes**
  `vertices: [[x,y]…]` in metres.
- `lib/services/room_plan_handoff.dart::handoffRoomPlan` picks the mapper via
  `plan.isAxisAlignedRect`, then `roomPersistenceProvider.ensurePersisted(...)`
  (also auto-creates a "Mening uyim" apartment if none). POST is
  `apartment_repository.dart::createRoom` →
  **`POST /api/v1/apartments/{apt_id}/rooms`**, body `RoomCreate.toJson()`.

### 3c. Backend contract — `andoza_ai/backend/app/schemas/room.py`
```python
WallElement: type: Literal["eshik","deraza","balkon"];
  width 0.3..5.0; height 0.3..3.5; sill_height 0..2.5 (def 0);
  position 0..1 (def .5); style_id?: str; sashes?: 1..2      # metres
Wall:        id: str; length 0.5..25.0; elements: []          # metres
RoomGeometry: walls (min 3); vertices?: [(x,y)…] metres, CCW  # 4-wall → vertices auto-filled
RoomCreate:  name; ceiling_h 1.8..6.0; geometry
# validator: every element height+sill_height ≤ ceiling_h+0.01
```
- Endpoint: `backend/app/routers/rooms.py::create_room`
  `POST /apartments/{apt_id}/rooms` (auth `CurrentUser`, ownership via
  `_get_owned_apartment`). Stores `geometry = body.geometry.model_dump()` **verbatim**
  plus computed metrics. `update_room` PATCH recomputes on geometry change.
- Model: `backend/app/models/room.py` table `rooms` — JSONB `geometry/surfaces/
  furniture_layout/state`; scalars `ceiling_h`, `floor_area`, `net_wall_area`,
  `perimeter`, `openings_count`.

### 3d. EXACT stored `geometry` JSON
```json
{
  "walls": [
    { "id": "A", "length": 6.4,
      "elements": [
        { "id": "<uuid4>", "type": "deraza", "width": 1.5, "height": 1.4,
          "sill_height": 0.9, "position": 0.5, "style_id": null, "sashes": null }
      ] },
    { "id": "B", "length": 4.0, "elements": [] }
  ],
  "vertices": [[0.0,0.0],[6.4,0.0],[6.4,4.0],[0.0,4.0]]
}
```
- Rectangles: 4 walls `A..D`, `vertices` omitted (server fills
  `[(0,0),(a,0),(a,b),(0,b)]`).
- Polygons: N walls `0..N-1`, `vertices` **required** (else 422).
- Openings live only in `walls[].elements[]`.

### 3e. Coordinate convention & units (authoritative)
- **Units: metres** end-to-end on the API/model. `ceiling_h` metres.
- **Positions: fractional 0..1** along the wall (`position`). *(The web store uses mm
  + absolute positions internally; `roomStore.loadRoom` converts m→mm and
  fraction→absolute. That conversion is the studio's concern, not the API's.)*
- **Origin** first corner `(0,0)`; **axes** x=width, y=length/depth (2-D floor);
  **corner order CCW**.
- **Auto-straighten** already exists: `lib/geometry/room_geometry.dart::
  regularizeFreehand` (`resample → rdpSimplify → mergeCloseVertices → regularize`),
  `snapAngleRad` (snaps to 90°/45° within 12°), wall lengths rounded to 0.05 m. The
  LiDAR converter should **reuse `regularize`/`snapAngleRad`** to straighten
  near-axis walls (task's ±3° → note current tolerance is **12°**, and snap bases are
  **90 and 45** — reconcile in Phase 3.2).
- **SMETA mm caveat:** `backend/app/services/smeta.py::_to_metres` treats any value
  `>100` as mm and divides by 1000. Current client sends metres (<100) so it's a
  no-op. **The LiDAR flow must send metres**; sending mm would be silently mis-scaled
  everywhere except this one heuristic.

### 3f. Objects / furniture — NOT expressible in `RoomCreate`
`RoomCreate.geometry` has **no** furniture field; placements live in the separate
`rooms.furniture_layout` JSONB (managed elsewhere, e.g. furniture placements API).
So RoomPlan-scanned **objects** cannot ride along in the room create. Per the task,
keep them in a **separate `scanObjects`** payload for the studio/backend to consume
later (Phase 4/5), and extend `RoomPlan`/`RoomOpening`-level models to carry openings
(the current `RoomPlan.rectangle` seeded by the LiDAR screen carries **no openings or
objects** yet — that's the gap Phase 3 fills).

### 3g. SMETA metrics — derived automatically
`backend/app/services/room_geometry.py::compute_metrics` (called on create/update)
computes `floor_area` (shoelace of `vertices`, or `w×l` for 4-wall), `perimeter`
(Σ lengths), `net_wall_area` (`perimeter×ceiling − Σ opening w×h`), `openings_count`.
`smeta.py` reads these cached scalars. **A LiDAR room that posts the same
`RoomCreate` gets every measurement for free — no extra fields.**

---

## 4. Web studio: builds rooms source-agnostically + the WebView bridge

### 4a. Studio is provenance-blind
`andoza_ai/frontend/src/pages/studio/ThreeDPage.tsx` (all inline on the current
`feat/studio-surface-radial-and-wall-openings` branch — the `three-d/` split is
**not** merged here). `RoomScene` branches purely on **topology**:
- Wall ids exactly `A/B/C/D` → legacy rectangle renderer.
- `geometry.vertices.length ≥ 3` → `NWallRoomShell` polygon path (has comments
  explicitly mentioning *"a RoomPlan scan"* and *"a scanned room is always drawn
  open-topped"*).
Walls/openings are carved from `walls[].elements[]` (`Wall.segments`), frames by
`WindowFrames`/`DoorFrames`. **No source/lidar flag anywhere.** A LiDAR room with the
same `geometry` renders identically and takes the N-wall path automatically.

### 4b. Store shape & unit conversion
`frontend/src/store/roomStore.ts`: store is **millimetres, absolute positions**.
`loadRoom` converts API **m→mm** and **fraction→absolute** (`position =
round(e.position × lengthMm)`), mints fresh element ids, and clears draft elements in
`loadDraftState` so API openings win. Save reverses it. So the API stays metres +
fractions; the studio owns the mm conversion.

### 4c. WebView bridge — `lib/screens/studio/studio_webview_screen.dart`
- Loads `${AppConfig.studioBaseUrl}${path}` where `path = '/studio/$roomId'`
  (+ optional `?phase=`). `studioBaseUrl` = `String.fromEnvironment('STUDIO_BASE_URL',
  default 'http://10.0.2.2:5173')`.
- **Auth is dual-seeded before the studio route loads:** (1) a `token` **cookie** via
  `WebViewCookieManager` (port-agnostic, covers :5173 + :8000), and (2)
  **localStorage** `uy-tamir-auth` via `runJavaScript` (the zustand persisted auth
  flag), by first loading the origin root, seeding on `onPageFinished`, then
  `loadRequest('/studio/$roomId')`.
- **No JS channels.** Web→app is only navigation interception (`_hasLeftStudio` →
  `_returnToApp`).
- Studio side: `StudioPage.tsx` reads `roomId` from the route, `getRoom(roomId)` via
  `api.ts` (`credentials:'include'` cookie auth, 401→refresh→retry). So the LiDAR
  flow, after creating a room, just opens `StudioWebViewScreen.studio(roomId:
  newRoomId)` — identical to the manual flow.

---

## 5. Native RoomPlan module notes (for Phase 2)
- Wrap **everything** in `if #available(iOS 16, *)`; weak-link `RoomPlan.framework`
  (Optional) so the 13.0 min still launches.
- Channel handler must bind to the **implicit engine** (see §1), and the modal VC must
  be presented from the active `UIWindowScene`'s root VC, not `AppDelegate.window`.
- `CapturedRoom` is `Codable` → JSON-encode; `room.export(to:exportOptions:
  .parametric)` → temp `.usdz`. Guard double-presentation (`busy`), stop the session +
  release VC on cancel/background, `os_log` subsystem `uz.andoza.roomscan` at every
  transition.
- `scanObject` → `FlutterError("not_implemented")` stub until Phase 6.

---

## 6. CI/CD state

### `andoza_ai_mobile` (Flutter)
- `.github/workflows/ci.yml` — push `main` + PR; `ubuntu-latest`; Flutter
  **3.44.8** stable via `subosito/flutter-action@v2`; `pub get` →
  `flutter analyze --no-fatal-infos --no-fatal-warnings` → `flutter test`. No build.
- `.github/workflows/release.yml` — on `tags: ['v*']` + dispatch; `ubuntu-latest`;
  builds a **signed Android `.aab`** (keystore from secrets), hardcoded
  `--dart-define` API `http://189.74.96.11:8000/...`; Play publish **commented out**.
- **No iOS/macOS job anywhere.** `ios.yml` (build+TestFlight) and `ios-check.yml`
  (PR-only `flutter build ios --no-codesign --simulator`) are **net-new**.
- Pin Flutter in `ios.yml` to the same **3.44.8** for parity.

### `andoza_ai` (backend + web)
- `.github/workflows/ci.yml` — push/PR `master|main`; backend `pytest` (pg16+redis7
  services, `alembic upgrade head`), frontend `tsc --noEmit` + `npm run build` +
  `vitest` (`continue-on-error`).
- **`.github/workflows/deploy.yml` — auto-deploys production on `push: branches:
  [master]`** (SSH `deploy/remote-deploy.sh`). ⇒ Phases 4/5 must not land on `master`
  without explicit authorization.

---

## 7. Backend build blocks for Phase 4

- **Storage:** `backend/app/core/storage.py::upload_file(bytes, key, content_type)` —
  dual-mode, **local disk default** (`/app/media`, served at `/media` via StaticFiles),
  S3/MinIO when configured. Reuse with keys like `scans/<user>/<uuid>.usdz` /
  `.glb` (content-types `model/vnd.usdz+zip`, `model/gltf-binary`). `absolute_media_url`
  builds URLs. Same mechanism wallpapers/furniture-GLBs use.
- **Background jobs:** Celery app `backend/celery_app.py` (`Celery("uytamir")`, Redis
  broker). Queues `default`, `media`, `ai-gpu` (last has no consumer). `worker` service
  consumes `default,media`. Template task `backend/app/tasks/media.py::process_photo`
  (`@app.task(..., queue="media")`), dispatched `process_photo.delay(...)` from
  `routers/media.py`. ⇒ USDZ→GLB conversion = a new `app/tasks/media.py`-style task on
  the `media` queue, fired after the `.usdz` upload.
- **Blender: absent.** Not in `backend/Dockerfile` (which installs Node 20 +
  `tools/glb-compress` gltf-transform). Must be added. Follow the
  `app/core/glb_compress.py` wrapper pattern (temp files, `subprocess.run(..., timeout)`,
  `asyncio.to_thread`, best-effort/never-raise) for a `tools/usdz_to_glb.py` invoked as
  `blender -b --python usdz_to_glb.py -- in.usdz out.glb`.
  - **Prefer a separate `converter`/Blender service** (or Blender only in the worker
    image) to keep the API image slim — matches the task.
- ⚠️ **Prod media-volume gap:** in `docker-compose.prod.yml` neither `api` nor
  `worker` mounts a shared `/app/media` volume (code baked in, no named media volume).
  A worker-hosted converter in prod therefore needs **either S3 configured** (pass keys,
  fetch/put bytes) **or a new shared media volume** added to compose. Dev is fine
  (`worker` bind-mounts `./backend`). **Flag for Phase 4 infra.**

### Endpoint-naming mismatch to resolve
The task says `POST /api/.../projects/{project_id}/room-scan`, but the domain has **no
"projects"** — it's **apartments → rooms**. The LiDAR flow *creates a room* via the
existing `POST /apartments/{apt}/rooms`. So the scan-artifact endpoint should be
**room-scoped**, e.g. `POST /api/v1/rooms/{room_id}/room-scan` (multipart `room_json`
+ `usdz`), plus `GET /api/v1/rooms/{room_id}/room-scan/model.glb`. The `room_scan`
metadata (`source`, `roomplan_version`, `scanned_at`, `usdz_path`, `glb_path`,
`object_count`) attaches to the **room** (new Alembic migration), not a "project".

> **DECISION NEEDED (D3):** confirm the endpoint is **room-scoped**
> (`/rooms/{room_id}/room-scan`) and that "project id" in the brief == room id.

---

## 8. Guessed / assumed mappings to confirm (RoomPlan → app schema)

1. **RoomPlan axes → app 2-D:** RoomPlan is Y-up metres; project wall corners onto the
   **XZ** plane → app `(x=width, y=length)`. Emit corners **CCW** to match the manual
   flow and backend `vertices`. (Guess: use RoomPlan wall/surface `transform`
   translation XZ for corners; derive `RoomWall` edges by connecting consecutive
   corners — same as `RoomPlan.fromCorners`.)
2. **Wall extraction:** RoomPlan gives wall polygons, not a clean corner loop. Plan:
   take wall centerline endpoints → dedupe/merge near corners
   (`mergeCloseVertices`) → `regularize` (snap ±tolerance to 90°/45°) → `RoomPlan`.
   **Tolerance mismatch to settle:** task says ±3°, existing `snapAngleRad` uses 12°
   and bases [90,45]. Recommend a dedicated tighter tolerance for scans (±3°) rather
   than reusing 12°, to avoid over-straightening real angled walls.
3. **Openings:** RoomPlan `doors[]`/`windows[]`/`openings[]` → nearest wall by
   perpendicular distance of the opening center; `position` = projected offset /
   wall length (0..1); `width`/`height` from opening dimensions; door `sill_height=0`,
   window `sill_height` from opening transform Y (fallback 0.9 m as the manual mapper
   does). Map RoomPlan door→`eshik`, window→`deraza`; no RoomPlan concept maps to
   `balkon` (leave unused).
4. **Ceiling height:** median wall height. Keep the **raw** metre value in `ceiling_h`
   (backend accepts any 1.8..6.0); only *display* snaps to chips
   (2.5/2.7/2.8/3.0/3.2).
5. **Objects → category enum:** Apple categories → internal {table, chair, sofa, bed,
   storage, refrigerator, stove, sink, toilet, bathtub, washer, television, fireplace,
   stairs, other}; unknown → `other`. These go to `scanObjects`, **not** `RoomCreate`.
6. **Server-side parity:** Phase 4 must port 3.2's converter to Python
   (`backend/app/services/room_scan_converter.py`) with an **identical fixture** and
   expected output to the Dart test, so mobile preview and server truth can't diverge.

---

## 9. Per-phase target map (proposed)

| Phase | Repo | Key paths |
|---|---|---|
| 1 iOS build | `andoza_ai_mobile` | `ios/Podfile`, `ios/Runner/Info.plist`, `ios/ExportOptions.plist`, `.github/workflows/ios.yml`, `ios-check.yml`, `docs/mobile/IOS_BUILD.md` |
| 2 Swift RoomPlan | `andoza_ai_mobile` | `ios/Runner/RoomScan/*.swift`, `ios/Runner/AppDelegate.swift` (implicit-engine channel wiring) |
| 3 Flutter side | `andoza_ai_mobile` | `lib/features/room_scan/**`, reuse `models/room_plan.dart`, `services/room_plan_handoff.dart`; repoint/replace `services/lidar_service.dart` + `screens/scanning/lidar_scanning_screen.dart` (D2) |
| 4 Backend | `andoza_ai` | `backend/app/routers/rooms.py` (new room-scan endpoints), `schemas/`, `services/room_scan_converter.py`, `tasks/media.py`, `tools/usdz_to_glb.py`, Dockerfile/compose (Blender service), Alembic migration |
| 5 Web studio | `andoza_ai` | `frontend/src/pages/studio/ThreeDPage.tsx` (optional GLB overlay + scanObjects ghost boxes), i18n `uz.` |
| 6 Object Capture | both | `andoza_ai_mobile` Swift+Dart; `andoza_ai` backend object endpoint |

---

## 10. Open decisions blocking Phase 1 (need confirmation)

- **D1 — repo layout:** confirm the split-repo mapping above (esp. that Phases 4/5
  land in `andoza_ai`, whose `master` auto-deploys).
- **D2 — LiDAR channel:** replace/upgrade the existing `com.tamir_uy/lidar` box flow
  to the `andoza/roomscan` RoomPlan contract (recommended), or add alongside?
- **D3 — endpoint naming:** room-scoped `/rooms/{room_id}/room-scan` (there is no
  "projects" concept) — confirm.
- **D4 — straightening tolerance:** ±3° dedicated for scans vs reusing existing 12°
  snap.
- **D5 — bundle id / TestFlight:** iOS id is `com.tamiruy.tamirUyMobileFlutter`
  (≠ Android). Confirm the App Store Connect app + provisioning profile use it.
- **D6 — Flutter pin:** pin `ios.yml` to Flutter **3.44.8** (matches existing CI).

Everything else in Phase 1 (Info.plist keys, ExportOptions placeholders, the two
workflows, the secrets list, the Linux `openssl` cert docs) is unblocked and ready to
implement once D1/D5/D6 are confirmed.
