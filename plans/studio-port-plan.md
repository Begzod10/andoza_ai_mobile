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
