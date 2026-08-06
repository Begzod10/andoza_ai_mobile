# Porting the web "Studio" (backend + frontend features) into the Flutter app

Status: **DRAFT for approval** · Created 2026-08-04

This plan maps the web app's Studio (3D room-design editor) and its backing
API onto the existing Flutter app. It is written to be executed in phases;
**Phases 1–6 are valuable and shippable regardless of which 3D approach we
pick**, so we don't have to resolve the 3D question before starting.

---

## 1. Where we're starting from

The Flutter app is **not** empty — it already has the full renovation journey
as native screens (capture → decorate → electrical → smeta → shop → masters),
freezed models (`room_model`, `design_selection_model`, `estimate_model`,
`electrical_model`), Riverpod state, and a dio-based `ApiClient` with bearer-token
auth. Three things separate it from the web Studio:

1. **No real 3D.** Every "3D" view is `CustomPaint` faux-perspective
   (`room_perspective_view.dart`, `room_canvas.dart`) — no engine. The web
   Studio's core is a 4,300-line react-three-fiber editor.
2. **Mock data, not backend.** Shop, masters, and **smeta are hardcoded
   client-side**. The rich backend (materials catalog, apartments, **room-state
   + delta**, finishes/decoration/furniture/electrical persistence, wallpaper
   library, PDF smeta, AI builder) is **not wired**.
3. **No streaming.** The dio client has no SSE support, which the AI Builder
   needs.

So "add both backend and frontend features" = **(A) wire the real backend**
(native, high value, screens mostly exist) + **(B) the 3D editor** (the hard fork).

---

## 2. The 3D decision (the one big fork)

| Option | What it is | Effort | Recommendation |
|---|---|---|---|
| **WebView the web Studio** | Embed the existing React/Three.js `/studio/:roomId` in `webview_flutter`, inject the JWT | Days | **Recommended** for fast full parity |
| **Native 3D (Filament/thermion)** | Rebuild the viewport in Dart | Months | Later optional upgrade |
| **Skip 3D, wire data** | Keep native 2D/faux-3D, focus on backend | — | The fallback if we never want a WebView |

**Recommended path: hybrid.** Do Phases 1–6 natively (real data everywhere),
and use the **WebView Studio** for photoreal 3D parity (Phase 7A). If we later
want it fully native, Phase 7B (Filament) can replace the WebView without
touching Phases 1–6. This defers the expensive, uncertain work while shipping
real value immediately.

---

## 3. Phased plan

### Phase 0 — API foundations (enables everything)
- Add **SSE support** to `ApiClient` (dio `ResponseType.stream` + line parser) for the AI builder.
- Add an **auth interceptor** (currently a manual header setter) so every call carries the token and 401s are handled centrally.
- New freezed models to mirror backend: `Apartment`, `RoomState` (xom/suvoq/shpaklovka/tayyor), `DeltaResult`, `Material` (with `texture_key`, `pbr_roughness`, category), `Wallpaper`, `Finish`, `Decoration`, `FurniturePlacement` (server), `ElectricalPlan`.
- Files: `lib/services/api_client.dart` (+SSE), `lib/services/sse_client.dart` (new), `lib/models/*` (new).

### Phase 1 — Real materials & catalog (replaces mock shop data)
- Wire `GET /api/v1/materials` (paginated, category/store filters), `/furniture`, `/stores`, `/ustalar`.
- Replace `shop_provider.dart` hardcoded catalog + `masters_provider.dart` `mockMasters` with repository-backed providers (client-side Redis-cache mirrored by simple in-memory cache).
- Surface real PBR fields (color, roughness, texture image) in the material rail (`widgets/room_3d_rail.dart`, `material_rail.dart`).
- Files: new `catalog_repository.dart`, rewrite `shop_provider.dart`, `masters_provider.dart`.

### Phase 2 — Apartments/Rooms persistence + room-state + **delta**
- Wire `apartments` CRUD and `rooms` CRUD (already partly in `room_repository.dart`), including walls/openings endpoints.
- Wire `GET/POST/PATCH /rooms/{id}/state` and **`GET /rooms/{id}/delta`** — replace the client-side `deriveStageStates()` delta with the server's authoritative delta (material/cost difference between current construction stage and finished).
- Hook into `activeRoomProvider` / new `roomStateProvider`, feed the E1 "you saved" banner from the real `delta_savings_uzs`.
- Files: `apartment_repository.dart` (new), extend `room_repository.dart`, `room_state_provider.dart` (new), update `estimation/e1_*`.

### Phase 3 — Real smeta (compute + preview + PDF)
- Wire `POST /rooms/{id}/estimate/preview` (live), `POST /rooms/{id}/estimate` (persist), history list, and **`GET /rooms/{id}/estimate.pdf`** (open/share via a PDF viewer or share sheet).
- Replace `estimate_provider.dart` hardcoded so'm rates with server-computed estimates.
- Files: rewrite `estimate_provider.dart` to call `estimate_repository.dart` (already has `/compute`), add PDF handling (`open_filex`/`share_plus`), update `estimation/e2_*`, `e3_*`.

### Phase 4 — Design persistence (finishes / decoration / furniture / electrical)
- Wire `PUT /rooms/{id}/decoration`, `finishes`, `furniture` placements, and `electrical` plan endpoints so the C-batch and D-batch screens **save to the backend** instead of local Riverpod only.
- Map existing `design_selection_model` / `electrical_model` to the server schemas.
- Files: `decoration_repository.dart`, `electrical_repository.dart` (new), update `design_provider.dart`, `electrical_provider.dart`, C/D screens.

### Phase 5 — Wallpaper library + media upload
- Wire `GET /wallpapers` (shared library) and `POST /wallpapers` (upload image, ≤15 MB) into the paint/wallpaper screen (C1) as a real, shared pattern source.
- Add image picking + multipart upload (`image_picker`, dio multipart).
- Files: `wallpaper_repository.dart` (new), update `interior/c1_*`, add `image_picker` dep.

### Phase 6 — AI Builder (SSE) + smeta explainer
- New "AI dizayner" entry in the room editor → prompt sheet → **`POST /rooms/{id}/ai-build`** streamed over SSE; render thinking / tool-call / done events; apply-or-discard the returned patch into local state, then persist.
- Wire `POST /rooms/{id}/smeta/ask` as a chat-style explainer on the smeta screen.
- Requires Phase 0 SSE. Files: `ai_repository.dart` (new), `ai_builder_sheet.dart` (new screen), `ai_provider.dart` (new).

### Phase 7 — The 3D Studio
- **7A (recommended, WebView):** add `webview_flutter`, a `StudioWebView` screen at `/studio/:roomId` that loads the web editor with the JWT injected (via `Authorization` header or a token query the frontend reads), and a JS↔Dart bridge for "save/close." Host the frontend on the LAN (already running on `:5173`) or bundle a built SPA served locally.
- **7B (optional later, native):** evaluate `thermion_flutter` (Filament) to render room geometry + GLB furniture natively; large, sequenced after 7A proves the UX.

### Phase 8 — Meshy image→3D (optional)
- Wire `POST /api/meshy/convert` + poll, to turn a room/object photo into a GLB usable in the 3D view.

---

## 4. New dependencies (by phase)
- P5: `image_picker`
- P3: `share_plus` / `open_filex` (PDF)
- P7A: `webview_flutter`
- P7B: `thermion_flutter` (or equiv) — only if we go native 3D
- (SSE uses dio's existing streaming — no new package)

## 5. Cross-cutting
- **Auth bridge** for the WebView (Phase 7A) reuses the token already in `flutter_secure_storage`.
- **Base URL**: everything keeps flowing through `app_config.dart` `--dart-define`, so pointing at PC1 vs localhost stays a launch flag.
- **Backend is already running** (docker-compose on this machine, all 6 services healthy) — no backend changes needed; this is purely client wiring + one 3D decision.

## 6. Suggested execution order
Phase 0 → 1 → 2 → 3 (this gives a fully backend-real, native app with real
catalog, real rooms, real delta, real smeta) → 4 → 5 → 6 → 7A → (7B/8 optional).

Each phase is independently shippable and testable against the live backend.

---

## Progress log

### Phase 0 — DONE (2026-08-04)
- `lib/services/sse_client.dart`, `ApiClient` gains SSE `stream()`, an auth
  interceptor (per-request token + central 401), FastAPI `detail` error
  parsing, and a `patch()` method.
- Backend-mirroring models under `lib/models/api/`: catalog (Material/Furniture/
  Store), apartment, room_out, room_state, estimate, delta, usta, wallpaper.
- Verified: `dart analyze` clean; deserialization unit tests against real
  captured payloads pass.

### Phase 1 — DONE (2026-08-04)
- `catalog_repository.dart` + `catalog_provider.dart` (materials/furniture/
  stores/ustalar), `utils/catalog_rail.dart` mapper.
- Live wire: C1 paint/wallpaper rail now shows real backend materials (boyoq/
  oboy/plitka) with real names+colours, falling back to hardcoded swatches.
- Deferred (with reason): shop/masters rewire — shop quantities depend on
  rooms+smeta (Phase 2/3); `Usta` has no map coords so U1 map can't be
  backend-fed without fabrication.

### Phase 2 — DONE (2026-08-04)
- `apartment_repository.dart` (apartments + rooms CRUD, replaces the broken
  `room_repository.dart` which hit a non-existent `/api/v1/rooms` and
  double-prefixed the base), `room_state_repository.dart` (state + delta),
  `models/api/room_create.dart`, `utils/room_geometry_mapper.dart` (client
  Room → RoomCreate, clamped to backend bounds), `providers/apartment_provider.dart`.
- **Room-persistence bridge**: `providers/room_persistence_provider.dart` —
  on demand, ensures an apartment exists, creates the backend room from the
  captured client room via `roomToRoomCreate`, and sets its construction state
  from the captured room condition (raw→xom / plastered→suvoq / puttied→shpaklovka).
  Idempotent per captured room.
- **E1 wire**: `e1_estimation_intro_screen.dart` now triggers persistence on
  open and prefers the backend `delta_savings_uzs` for the "tejaldingiz" banner,
  falling back to the local computation while loading / if unauthenticated /
  if backend savings is 0. No regression to the existing screen.
- Verified END-TO-END against the live backend: login → create apartment →
  create room (server computed floor_area 16.2, openings_count 2) → set state
  → GET delta. Deserialization unit-tested against those exact captured payloads.
  29 unit tests pass; `dart analyze` clean; 0 errors across lib.
- CAVEAT: the backend delta returns meaningful (non-zero) savings only once a
  room has surface materials assigned (that persistence lands in Phase 4). For a
  bare captured room the smeta total is ~0, so E1 correctly falls back to the
  local "you saved" figure until then. On-device screenshot of E1 with a real
  backend delta is deferred to the consolidated live pass.

### Phase 3 — DONE (2026-08-05)
- `repositories/estimate_repository.dart` (rewrite; deleted the dead one that
  targeted non-existent `/estimates` paths): preview, create(persist), history,
  getById, downloadPdf (raw bytes). `ApiClient.getBytes()` added.
- `providers/estimate_api_provider.dart` (estimatePreview/history by roomId),
  `services/pdf_share_service.dart` (writes PDF bytes to temp + share sheet).
- Deps added: `path_provider`, `share_plus`.
- E1 wire: shows the real server smeta total when the room is persisted (falls
  back to local), plus a "PDF smetani yuklab olish" button that downloads the
  ReportLab PDF and opens the share sheet.
- Verified END-TO-END live: assigned a paint material to a room's walls →
  preview total 840,000 with real priced lines ("Bo'yoq: Tikkurila Euro 3 Oq")
  → persist (final/UZS) → history (1 item) → PDF (HTTP 200, valid %PDF-, 3.6KB).
  8 new deserialization tests vs captured payloads; 33 tests pass; analyze clean;
  **debug APK builds** (share_plus/path_provider native plugins link OK).
- More DB drift fixed non-destructively: `estimates.currency` + `estimates.status`
  were missing (persist 500'd) → `ALTER TABLE ADD COLUMN` with the model's
  server_defaults.

### Phase 4 — DONE (2026-08-05)
- Models: `models/api/decoration.dart` (walls/floor/ceiling/furniture),
  `models/api/electrical.dart` (plan + device create/out).
- Repos: `decoration_repository.dart` (GET/PUT), `electrical_repository.dart`
  (GET/PUT plan). Providers in `design_persistence_provider.dart`.
- **Loop-closing win**: `RoomPersistenceNotifier.setSurfaceMaterials()` PATCHes
  the backend room's `surfaces` map (merging) and invalidates the delta +
  estimate-preview providers. C1 now persists the chosen paint/wallpaper to
  wall A (single tap) or all walls ("Hamma devorga"), but ONLY for real catalog
  materials (UUID-guarded; fallback swatch slugs stay local-only).
- **Proven live end-to-end**: a bare room's smeta preview = 0 UZS; after
  assigning paint to its walls (the exact PATCH setSurfaceMaterials issues) the
  smeta = 665,000 UZS. So a C1 material choice now flows through to the Phase 3
  smeta and Phase 2 delta. Decoration + electrical PUT/GET verified live (200).
- 2 new model tests vs captured payloads; 35 tests pass; analyze clean.
- NOTE: decoration PUT and the electrical repo/providers are built + tested but
  not yet wired into a save button on C4/C5/D1 — those screens can adopt them
  incrementally. The high-value surface (C1 → smeta loop) is wired.

### Phase 7A — WebView 3D Studio: app-side DONE, live verify PENDING (2026-08-05)
- Dep `webview_flutter`; `AppConfig.studioBaseUrl` (dart-define STUDIO_BASE_URL,
  default `http://10.0.2.2:5173`); `android:usesCleartextTraffic="true"` (WebView
  respects Android cleartext policy, unlike the app's dart:io calls).
- `screens/studio/studio_webview_screen.dart` — the auth bridge:
  1. sets the `token` cookie for the shared host (cookies ignore port → covers
     both the :5173 frontend and :8000 API),
  2. seeds the Zustand `uy-tamir-auth` localStorage key ({state:{user,
     isAuthenticated:true},version:0}) so the web app's RequireAuth guard passes,
  3. two-step load: origin root → onPageFinished injects the flag → navigate to
     `/studio/{roomId}`. Loading + error/retry overlays.
- Route `/studio/:roomId`; entry button "3D Studio" on E1 (uses persisted roomId,
  alongside the PDF button).
- Verified: analyze clean; 35 tests pass; **debug APK builds** (webview native
  plugin links).
- ⚠️ LIVE VERIFY PENDING — needs the frontend served with a VITE_API_URL that is
  reachable from the device. The docker frontend bakes `localhost:8000`, which
  fails from inside the emulator WebView (localhost = the emulator). To demo:
  serve the frontend with `VITE_API_URL=http://10.0.2.2:8000/api/v1` (emulator)
  or `http://<LAN-IP>:8000/api/v1` (physical device), then open E1 → 3D Studio.
  This reconfig disrupts host-browser access to the studio, so it wasn't done
  automatically.

### Phase 7A — LIVE VERIFIED on the emulator (2026-08-06)
Ran the full stack on the Pixel5 emulator (x86_64 build; note: build for
`android-x64`, not arm64, or the app crashes with an EM_AARCH64/EM_X86_64 ABI
mismatch). Reconfigured the frontend container with
`VITE_API_URL=http://10.0.2.2:8000/api/v1` and added `http://10.0.2.2:5173` to
the backend `CORS_ORIGINS_STR` (backend/.env; needs `up -d --force-recreate api`,
a plain `restart` does NOT reload .env). Proven, with screenshots:
- App launches (Andoza AI rebrand), login → `POST /auth/login 200`.
- Room capture flow (manual dims 4×3×2.8 → walls → summary → korobka state).
- C1 rail shows REAL backend materials (Tikkurila Euro 3 Oq / Optiva Kulrang /
  Dulux Mos Sariq) once the catalog loads (first render briefly shows fallbacks).
- Room-persistence bridge hits the backend (`GET /apartments 200`).
- **WebView 3D Studio**: deep-linked `andozaai:///studio/{roomId}` → the native
  "3D Studio" screen embeds the React/Three.js editor; the auth bridge works
  (`GET /auth/me 200` via the seeded cookie/localStorage); after the CORS fix the
  Studio loads the real room (`GET /rooms/{id} 200`, `materials 200`,
  `wallpapers 200`) showing "Zal 4.5×3.6×2.8" with the correct stage state, and
  the Three.js scene renders the room floor + orientation gizmo and orbits on drag.

Two bugs found via the live run:
1. App crashes on login (`type 'Null' is not a subtype of type 'String'`) when the
   user's `phone` is null — `User.fromJson` requires phone. It's an uncaught
   CastError (not an Exception), so the login button hangs. Should make phone
   nullable or catch Error in AuthNotifier.login.
2. Emulator/software-GL renders WebGL slowly; fine on real-device GPU.

### Emulator run — how to reproduce
```bash
# frontend reachable from the device + CORS
(cd tamir_uy && VITE_API_URL=http://10.0.2.2:8000/api/v1 \
  sudo docker compose up -d --force-recreate --no-deps frontend)
# add http://10.0.2.2:5173 to backend/.env CORS_ORIGINS_STR, then:
(cd tamir_uy && sudo docker compose up -d --force-recreate --no-deps api)
# build x64 (NOT arm64) + run
flutter build apk --debug --target-platform android-x64 \
  --dart-define=API_URL=http://10.0.2.2:8000/api/v1 \
  --dart-define=API_BASE_URL=http://10.0.2.2:8000 \
  --dart-define=STUDIO_BASE_URL=http://10.0.2.2:5173
# open studio directly: adb shell am start -a android.intent.action.VIEW \
#   -d "andozaai:///studio/<roomId>" com.tamir_uy.tamir_uy_mobile_flutter
```
NOTE: the frontend is currently left configured for the emulator
(`VITE_API_URL=10.0.2.2`), which breaks host-browser studio access. To restore
normal host dev: `VITE_API_URL=http://localhost:8000/api/v1 docker compose up -d
--force-recreate --no-deps frontend`.

### Phase 5 — DONE + LIVE VERIFIED (2026-08-06)
- `models/api/wallpaper.dart` (Phase 0), `wallpaper_repository.dart` (list +
  multipart upload), `wallpaper_provider.dart`. `ApiClient.uploadFile()` for
  `multipart/form-data` (uses dio `DioMediaType`).
- `screens/interior/wallpaper_library_sheet.dart` — shared-library grid
  (Image.network thumbnails) + "Rasm yuklash" upload via `image_picker`.
- C1 entry: a bottom-left `FloatingActionButton.extended` "Oboy kutubxonasi".
- Dep `image_picker`; its transitive AndroidX (core 1.18 / activity 1.12) demand
  AGP 8.9.1+, so `android/app/build.gradle.kts` pins core→1.13.1, activity→1.9.3
  via resolutionStrategy (avoids a full AGP/Gradle upgrade).
- Verified live: multipart upload round-trip (`POST /wallpapers` 201 → `GET` shows
  it → stored image fetchable 200); ON-DEVICE the FAB opens the sheet, which
  fetches `GET /wallpapers 200` and renders the uploaded wallpaper thumbnail.
  38 unit tests pass; analyze clean; APK builds.
- GOTCHA discovered: the decoration flow's paint screen is `/design/b3`
  (B3DecorationRailScreen), and ITS "Keyingi bosqich" leads to `/interior/c1`
  (C1PaintWallpaperScreen, the one with real materials + the wallpaper FAB).
  Don't confuse the two — the FAB/real-materials are on c1, one step past b3.

### Phase 6 — DONE (SSE plumbing live-verified; real generation needs an LLM key) (2026-08-06)
- `models/api/ai.dart`: `AiPatch` (freezed, mirrors RoomDraft.to_patch) + sealed
  `AiBuildEvent` (thinking/toolCall/toolResult/done/error/unknown) + `SmetaAnswer`.
- `ai_repository.dart`: `build()` maps the Phase-0 `ApiClient.stream()` SSE frames
  to typed events; `smetaAsk()`. Provider in `ai_provider.dart`.
- `screens/studio/ai_builder_sheet.dart`: prompt → streamed thinking/tool log →
  done card with Apply/Discard. Apply persists the patch's ceiling_h + surfaces
  via updateRoom and invalidates delta/estimate (furniture/lights/wall_lengths
  are shown in the summary but owned by their own flows / the 3D Studio).
- Entry: "AI dizayner" button on E1 (needs a persisted roomId).
- Verified live: the SSE endpoint streams correctly — captured real frames
  `{"type":"thinking",...}` then `{"type":"error", 401 invalid_api_key}` because
  `OPENAI_API_KEY=sk-...` in tamir_uy/backend/.env is a PLACEHOLDER. So transport,
  auth, framing and the parser all work end-to-end; a successful generation needs
  a real OpenAI-compatible key server-side (AI_MODEL_BUILDER is set to a Gemini
  model, so pair it with a Gemini key + OPENAI_BASE_URL, or use an OpenAI key).
- 6 new event/patch parsing tests vs the real frames; 43 tests pass; analyze
  clean; APK builds.

### ⚠️ Backend findings (this machine's local docker DB)
1. **Schema drift from the git pull, now FIXED non-destructively.** The pulled
   code added `users.is_admin` and `rooms.deleted`, plus new tables, but the DB
   predated them and the compose override skips migrations → auth + room create
   were 500ing. Fixed via `ALTER TABLE ... ADD COLUMN IF NOT EXISTS` (users.is_admin,
   rooms.deleted) + `python _init_db.py` (create_all for the missing tables).
   A real deploy on a fresh DB wouldn't hit this; an existing DB needs these ALTERs.
2. **Register endpoint bug (NOT fixed — flagged).** `app/routers/auth.py::register`
   returns `LoginResponse(user=...)` without the required `access_token`/
   `refresh_token`, so `POST /auth/register` 500s. The OTP-verify handler does it
   right. The mobile app uses `/login` (works), so this isn't blocking, but it
   should be fixed in the web backend.
