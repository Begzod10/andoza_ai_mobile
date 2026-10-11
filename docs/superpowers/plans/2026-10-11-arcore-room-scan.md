# ARCore xona o'lchash (Android, A bosqich) — bajarish rejasi

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** LiDAR'siz Android telefonda foydalanuvchi pol burchaklarini belgilab va shift balandligini o'lchab xona rejasini oladi; natija iOS skaneri bilan bir xil ko'rib chiqish → saqlash → Studio yo'lidan o'tadi.

**Architecture:** Native Kotlin Activity (ARCore + OpenGL + native tugmalar) `MethodChannel("andoza/arscan")` orqali ochiladi va xom burchaklar + balandlikni JSON qilib qaytaradi. Barcha to'g'rilash (birlashtirish, yopilish xatosini taqsimlash, 90° ga tekislash, tekshiruv) Dart'da toza funksiyalarda. Natija `RoomPlan(source: arcore)` sifatida mavjud `RoomScanReviewPage` ga tushadi.

**Tech Stack:** Flutter/Riverpod/go_router (Dart), Kotlin, ARCore Android SDK, OpenGL ES 2, JUnit 4 (Kotlin JVM testlari), flutter_test.

**Spec:** `docs/superpowers/specs/2026-10-11-arcore-room-scan-design.md`

## Global Constraints

- Kanal nomi: `andoza/arscan`; metodlar `checkSupport`, `scanFloorPlan`. iOS `andoza/roomscan` ga tegilmaydi.
- `checkSupport` → `{supported: bool, reason: String}`, `reason` ∈ `ok | arcore_not_installed | unsupported_device | camera_denied`.
- `scanFloorPlan({strings})` → `{corners: [[x, z], …] (metr), height: double, heightMeasured: bool, closed: bool, trackingLossCount: int, durationSec: int}`; bekor → `null`; xato → `PlatformException(code, message)`.
- Yopishish masofasi 0.20 m; burchaklarni birlashtirish 0.10 m; to'g'ri burchak toleransi ±8°; uzunliklar 0.01 m ga yaxlitlanadi; kamida 3 burchak.
- Balandlik qo'lda kiritish variantlari: 2.5 / 2.7 / 2.8 / 3.0 / 3.2 m; o'lchangan balandlik [1.8, 4.5] m oralig'idan tashqarida bo'lsa qabul qilinmaydi.
- Ko'rib chiqishdagi izoh matni (uz): "Kamera o'lchovi: ±3–5% xato bo'lishi mumkin, muhim devorlarni ruletka bilan tekshiring".
- Ekran matnlari Flutter l10n'dan (uz/ru/en) `strings` orqali uzatiladi; Kotlin'da o'zbekcha matn qattiq yozilmaydi (faqat `strings` bo'lmaganda zaxira).
- ARCore manifestda `optional` qoladi; ilova ARCore'siz ham ishlaydi.
- Qurilma: `minSdk 24` o'zgarmaydi.

## Review Focus

1. **Konturni yopmasdan "Tayyor" bosish** (≥ 3 burchak, birinchisiga yopishmagan) — kutilgan: `closed:false` qaytadi, Dart oxirgi→birinchi devor bilan yopadi, yopilish xatosi taqsimlanmaydi. Test: Task 1 `closes an open outline without redistributing`.
2. **Burchaklar soat strelkasi bo'yicha yoki teskari tartibda** — kutilgan: natija bir xil maydon va devor uzunliklari. Test: Task 1 `clockwise and counter-clockwise give the same plan`.
3. **Adashib uzoq tekislikka bosilgan nuqta** (bitta devor > 30 m) — kutilgan: natija rad etiladi, sabab `wall_too_long`. Test: Task 1 `rejects an outlier corner`.
4. **Skaner o'rtasida ilova fonga o'tib qaytishi** — kutilgan: sessiya davom etadi; ARCore kuzatuvi `STOPPED` bo'lgan langarlar tashlanadi va foydalanuvchiga "Qaytadan boshlash" taklif qilinadi. Test: Task 3 `drops anchors that stopped tracking`.
5. **ARCore o'rnatilgan, lekin eskirgan / o'rnatish bekor qilingan** — kutilgan: `arcore_not_installed`, ekranda Play havolasi. Test: Task 2 `maps arcore_not_installed to install prompt`.

---

### Task 1: Dart — xom burchaklardan `RoomPlan` (`arcore_plan.dart`)

**Files:**
- Modify: `lib/models/room_plan.dart:7` (`enum RoomSource` ga `arcore` qo'shish)
- Create: `lib/features/ar_scan/arcore_plan.dart`
- Test: `test/unit/arcore_plan_test.dart`

**Interfaces:**
- Consumes: `lib/geometry/room_geometry.dart` — `mergeCloseVertices`, `regularize`, `isSelfIntersecting`, `removeCollinearVertices`, `perimeter`; `RoomPlan.fromCorners`.
- Produces:
  ```dart
  class ArScanRaw { // natijaning Dart ko'rinishi
    final List<Vec2> corners; final double height; final bool heightMeasured;
    final bool closed; final int trackingLossCount; final int durationSec;
    factory ArScanRaw.fromMap(Map<String, dynamic> m);
  }
  sealed class ArPlanResult {}
  class ArPlanOk extends ArPlanResult { final RoomPlan plan; }
  class ArPlanRejected extends ArPlanResult { final String reason; } // too_few_corners | self_intersecting | wall_too_long
  ArPlanResult buildArcorePlan(ArScanRaw raw, {String name = 'Xona'});
  ```

Tartib (spec bo'yicha): birlashtirish (0.10 m) → yopilish xatosini taqsimlash (faqat `closed:true` bo'lsa) → `regularize` (±8°) → `removeCollinearVertices` → tekshiruv → 0.01 m yaxlitlash → `RoomPlan.fromCorners(source: RoomSource.arcore)`.

Yopilish xatosi algoritmi (`closed:true` da native oxirgi nuqta sifatida yopishishdan oldingi bosish nuqtasini `corners` oxiriga qo'shib yuboradi):
```
e = last - first            // yopilish xatosi
drop last
cum_i = 0 dan i gacha devor uzunliklari yig'indisi, L = perimetr (ochiq zanjir)
corner_i -= e * (cum_i / L)
```

- [ ] **Step 1: Failing testlar** — `test/unit/arcore_plan_test.dart`:
  - `squares a slightly skewed rectangle` — burchaklar `(0,0),(4.02,0.05),(3.98,3.03),(-0.03,2.98)`, `closed:false` → `ArPlanOk`, `isAxisAlignedRectangle(plan.corners)` true, maydon `closeTo(12.0, 0.25)`.
  - `keeps all six corners of an L-shape` — L-shakl (spec'dagi `_lShape` kabi 4×4, ichki 2×2 kesilgan) → 6 burchak.
  - `leaves a genuinely slanted wall slanted` — trapetsiya, bitta burchak 75° → 75° saqlanadi (±1°).
  - `spreads the closure error along the walls` — 4×3 to'rtburchak + oxirgi nuqta `(0.10, 0.06)` (birinchi `(0,0)`), `closed:true` → 4 burchak, perimetr `closeTo(14.0, 0.05)`.
  - `merges corners closer than 10 cm` — ikki burchak 6 sm oralig'ida → bittaga birlashadi.
  - `closes an open outline without redistributing` — `closed:false`, 4 burchak → 4 devor, oxirgisi oxirgi→birinchi.
  - `clockwise and counter-clockwise give the same plan` — bir xil to'rtburchak teskari tartibda → `areaM2` va saralangan devor uzunliklari teng.
  - `rejects fewer than 3 corners` → `ArPlanRejected('too_few_corners')`.
  - `rejects a self-intersecting outline` (bow-tie) → `self_intersecting`.
  - `rejects an outlier corner` — bitta devor 35 m → `wall_too_long` (chegara 30 m).
  - `tags the plan as arcore and rounds to 1 cm` — `plan.source == RoomSource.arcore`, har devor uzunligi `*100` butun.
  - `ArScanRaw.fromMap parses the channel payload` — Global Constraints'dagi map → maydonlar.
- [ ] **Step 2:** `flutter test test/unit/arcore_plan_test.dart` → FAIL (fayl yo'q).
- [ ] **Step 3:** `RoomSource.arcore` qo'shish va `buildArcorePlan` / `ArScanRaw` ni yozish. `RoomSource` ishlatilgan `switch`lar (`grep -rn "RoomSource\." lib`) yangi qiymatni qamrashi kerak (`lidar` kabi ishlansin).
- [ ] **Step 4:** `flutter test test/unit/arcore_plan_test.dart` → PASS; `flutter analyze lib` → No issues.
- [ ] **Step 5:** Commit: `feat(ar-scan): turn raw ARCore corners into a squared, validated RoomPlan`.

### Task 2: Dart — kanal o'rami (`ar_scan_service.dart`)

**Files:**
- Create: `lib/features/ar_scan/ar_scan_service.dart`
- Test: `test/unit/ar_scan_service_test.dart`

**Interfaces:**
- Consumes: `ArScanRaw.fromMap` (Task 1).
- Produces:
  ```dart
  class ArScanSupport { final bool supported; final String reason; }
  class ArScanException implements Exception { final String code; final String message; }
  class ArScanService {
    static const MethodChannel channel = MethodChannel('andoza/arscan');
    Future<ArScanSupport> checkSupport();               // hech qachon throw qilmaydi
    Future<ArScanRaw?> scanFloorPlan(Map<String, String> strings); // null = bekor
  }
  final arScanServiceProvider = Provider<ArScanService>((ref) => ArScanService());
  ```

- [ ] **Step 1: Failing testlar** (`TestDefaultBinaryMessengerBinding` bilan soxta kanal, `room_scan_service` testlaridagi uslubda):
  - `reports support from the native side` — `{supported:true, reason:'ok'}`.
  - `maps arcore_not_installed to install prompt` — `{supported:false, reason:'arcore_not_installed'}` → `reason == 'arcore_not_installed'`.
  - `missing plugin means unsupported` — handler yo'q → `ArScanSupport(false, 'not_implemented')`.
  - `returns the parsed scan` — Global Constraints'dagi payload → `ArScanRaw` maydonlari.
  - `null means the user cancelled` → `null`.
  - `native error becomes ArScanException with its code` — `PlatformException(code:'tracking_lost')` → `ArScanException.code == 'tracking_lost'`.
  - `passes the localized strings through` — chaqiruv argumentida `strings` map'i bor.
- [ ] **Step 2:** `flutter test test/unit/ar_scan_service_test.dart` → FAIL.
- [ ] **Step 3:** `ArScanService` ni yozish.
- [ ] **Step 4:** test → PASS.
- [ ] **Step 5:** Commit: `feat(ar-scan): Dart side of the andoza/arscan channel`.

### Task 3: Kotlin — o'lchash mantig'i (`FloorPlanCapture`, ARCore'siz)

**Files:**
- Create: `android/app/src/main/kotlin/com/tamir_uy/tamir_uy_mobile_flutter/arscan/FloorPlanCapture.kt`
- Create: `android/app/src/test/kotlin/com/tamir_uy/tamir_uy_mobile_flutter/arscan/FloorPlanCaptureTest.kt`
- Modify: `android/app/build.gradle.kts` (`dependencies` ga `testImplementation("junit:junit:4.13.2")`)

**Interfaces:**
- Produces (Task 4 ishlatadi):
  ```kotlin
  data class Vec3(val x: Float, val y: Float, val z: Float)
  class FloorPlanCapture(val snapDistanceM: Float = 0.20f) {
    val floorY: Float?                    // birinchi burchak balandligi
    val corners: List<Vec3>               // joriy (anchor yangilangan) pozalar
    val isClosed: Boolean
    var trackingLossCount: Int
    fun canAddCorner(tracking: Boolean): Boolean   // tracking && !isClosed
    fun addCorner(p: Vec3): AddResult              // ADDED | CLOSED | REJECTED_NOT_TRACKING
    fun undo(): Boolean
    fun wouldSnap(p: Vec3): Boolean                // birinchi burchakka ≤ snapDistanceM (XZ), kamida 3 burchak bo'lsa
    fun updatePositions(positions: List<Vec3?>)    // null = anchor STOPPED → o'sha burchak tashlanadi
    fun heightFromRay(origin: Vec3, dir: Vec3): Float? // [1.8, 4.5] dan tashqari → null
    fun toResult(height: Float, heightMeasured: Boolean, durationSec: Int): Map<String, Any>
  }
  ```
  `addCorner`: y `floorY` ga keltiriladi. Yopishishda (`wouldSnap`) bosilgan nuqta oxiriga qo'shiladi va `isClosed = true` (Dart xatoni taqsimlashi uchun, Task 1). `toResult` — Global Constraints'dagi map (corners `[[x,z],…]` Double).
  `heightFromRay`: vertikal o'q `(c0.x, *, c0.z)` va nur orasidagi eng yaqin nuqtalar (ikki chiziq orasidagi eng yaqin nuqta formulasi); o'qdagi nuqtaning `y - floorY`. Nur o'qqa parallel bo'lsa → null.

- [ ] **Step 1: Failing JUnit testlar:**
  - `adds corners on the floor height` — ikkinchi nuqta y=0.05 → `floorY` ga keltiriladi.
  - `snaps to the first corner within 20 cm` — 3 burchakdan keyin `(0.15,0,0.1)` → `CLOSED`, `isClosed`, 4 ta nuqta (oxirgisi bosilgan nuqta).
  - `does not snap before three corners`.
  - `undo removes the last corner and reopens`.
  - `blocks adding while not tracking` — `REJECTED_NOT_TRACKING`.
  - `drops anchors that stopped tracking` — `updatePositions(listOf(a, null, c))` → 2 burchak, `isClosed == false`.
  - `measures height along the vertical axis` — kamera `(2,1.5,2)`, `floorY=0`, birinchi burchak `(0,0,0)`, nur `(0,2.7,0)` ga qaratilgan → `2.7 ± 0.01`.
  - `rejects heights outside 1.8–4.5 m` → `null`.
  - `serializes the channel payload` — `toResult` kalitlari va qiymatlari.
- [ ] **Step 2:** `cd android && ./gradlew :app:testDebugUnitTest --tests '*FloorPlanCaptureTest*'` → FAIL.
- [ ] **Step 3:** `FloorPlanCapture` ni yozish (faqat `kotlin.math`, ARCore import yo'q).
- [ ] **Step 4:** shu buyruq → PASS.
- [ ] **Step 5:** Commit: `feat(ar-scan): floor-plan capture logic (corners, snapping, height) with JVM tests`.

### Task 4: Kotlin — skaner ekrani, renderer, kanal; eski qolipni olib tashlash

**Files:**
- Create: `…/arscan/ArScanChannel.kt`, `…/arscan/ArScanActivity.kt`, `…/arscan/ArRenderer.kt`
- Modify: `…/MainActivity.kt` (LidarMethodChannel → ArScanChannel), `android/app/src/main/AndroidManifest.xml` (`DepthScanActivity` → `.arscan.ArScanActivity`, `screenOrientation="portrait"`, kamera ruxsati bor-yo'qligini tekshirish), `android/app/build.gradle.kts` (`com.google.ar:core` → `1.56.0`; build buzilsa `1.42.0` da qoldirib, sababini commit xabariga yozish)
- Delete: `…/DepthScanActivity.kt`, `…/RoomMeasurer.kt`, `…/LidarMethodChannel.kt`, `lib/services/lidar_service.dart`, `lib/providers/lidar_provider.dart` (avval `grep -rn "lidar_service\|lidar_provider\|com.tamir_uy/lidar" lib test` bo'sh ekanini tasdiqlash)
- Reuse: `BackgroundRenderer.kt`, `ShaderUtil.kt` (`arscan` ga ko'chirmasdan import qilinadi)

**Interfaces:**
- Consumes: `FloorPlanCapture` (Task 3).
- Produces: `andoza/arscan` kanali (Global Constraints) — Task 5 Dart ekrani shuni chaqiradi. `ArScanActivity` natijani `Intent` extra `"result"` (JSON string) bilan qaytaradi; `ArScanChannel` uni `Map` ga aylantirib `result.success` qiladi; bekor → `success(null)`; xato kodlari: `camera_denied`, `arcore_not_installed`, `unsupported_device`, `session_failed`, `busy`.

Xatti-harakat (spec "Foydalanuvchi jarayoni" va "Xatolar"):
- `checkSupport`: `ArCoreApk.checkAvailability` (transient bo'lsa 200 ms kutib qayta), `SUPPORTED_INSTALLED` → ok; `SUPPORTED_NOT_INSTALLED/APK_TOO_OLD` → `arcore_not_installed`; boshqalar → `unsupported_device`.
- Activity: `Config(planeFindingMode=HORIZONTAL_AND_VERTICAL, depthMode=AUTOMATIC agar qo'llansa, focusMode=AUTO, updateMode=LATEST_CAMERA_IMAGE)`; ekran markazidan `frame.hitTest` → faqat `Plane.Type.HORIZONTAL_UPWARD_FACING` va `plane.isPoseInPolygon`; nishon, burchak nuqtalari, chiziqlar va uzunlik yozuvlari (`ArRenderer` + native `TextView` overlay); qadamlar: pol topish → burchaklar → balandlik → natija; har kadrda `capture.updatePositions(anchors.map { if (it.trackingState==STOPPED) null else pose→Vec3 })`; tugmalar: Burchak qo'shish / Bekor qilish / Tayyor / Tasdiqlash / Qo'lda kiritish / Chiqish (tasdiq dialogi); pol 20 s da topilmasa maslahat; `TrackingFailureReason` bo'yicha ogohlantirish; `onPause` → `session.pause()`, `onResume` → `session.resume()`.

- [ ] **Step 1:** Eski qolipni o'chirish va `MainActivity` ni `ArScanChannel` ga o'tkazish; `cd android && ./gradlew :app:assembleDebug` → BUILD SUCCESSFUL.
- [ ] **Step 2:** `ArScanChannel` + `ArScanActivity` + `ArRenderer` ni yozish; `./gradlew :app:assembleDebug` va `./gradlew :app:testDebugUnitTest` → muvaffaqiyatli.
- [ ] **Step 3:** Activity natija JSON'ini `Log.i("ArScan", …)` bilan ham yozadi (qurilmada `adb logcat -s ArScan` bilan kuzatish uchun). Activity `exported="false"` qoladi; qurilmadagi birinchi tutun-test Task 5 ekrani orqali Task 6 da qilinadi.
- [ ] **Step 4:** `flutter analyze lib` va `flutter test` → toza (o'chirilgan Dart fayllar hech qayerda ishlatilmasligi tasdiqlanadi).
- [ ] **Step 5:** Commit: `feat(ar-scan): native ARCore floor-plan scanner on andoza/arscan; drop the unused box-guess scaffold`.

### Task 5: Dart — skaner ekrani, yo'naltirish, ko'rib chiqish va matnlar

**Files:**
- Create: `lib/screens/scanning/ar_scan_screen.dart` (route `/scanning/arcore`)
- Modify: `lib/config/router.dart` (yangi route), `lib/screens/scanning/room_scan_screen.dart` (Android'da `context.pushReplacement('/scanning/arcore')`), `lib/screens/room_setup/new_project_sheet.dart` (Android'da sarlavha `l10n.newProjectArScanTitle`, tavsif `l10n.newProjectArScanDesc`), `lib/screens/scanning/room_scan_review_page.dart` (`RoomScanReviewArgs.scan` → `ScanResult?`; `null` bo'lsa artefakt yuklash o'tkazib yuboriladi; `plan.source` saqlanadi (hozir `RoomSource.lidar` qattiq yozilgan → `_plan.source`); `source == arcore` bo'lsa aniqlik izohi), `lib/l10n/app_{uz,ru,en}.arb`
- Test: `test/widget/ar_scan_screen_test.dart`, `test/widget/room_scan_review_summary_test.dart` (kengaytirish)

**Interfaces:**
- Consumes: `arScanServiceProvider`, `ArScanSupport`, `ArScanException` (Task 2); `buildArcorePlan`, `ArPlanOk`, `ArPlanRejected` (Task 1); `RoomScanDraft(plan:, objects: const [])`, `RoomScanReviewArgs(draft:, scan: null)`.
- Produces: `/scanning/arcore` route; l10n kalitlari: `newProjectArScanTitle` ("Kamera bilan o'lchash"), `newProjectArScanDesc`, `arScanFindFloor`, `arScanAddCorner`, `arScanUndo`, `arScanFinish`, `arScanAimCeiling`, `arScanConfirm`, `arScanEnterManually`, `arScanExit`, `arScanExitConfirm`, `arScanTrackingLost`, `arScanFloorHint`, `arScanSnapToFirst`, `arScanNotInstalled`, `arScanInstall`, `arScanCameraDenied`, `arScanOpenSettings`, `arScanRejected_too_few_corners`, `arScanRejected_self_intersecting`, `arScanRejected_wall_too_long`, `scanReviewArcoreAccuracy` (Global Constraints'dagi matn).

Ekran oqimi: `checkSupport` → `ok` bo'lsa darhol `scanFloorPlan(strings)` (strings = yuqoridagi `arScan*` kalitlarining joriy tildagi qiymatlari) → `buildArcorePlan` → `ArPlanOk` bo'lsa `context.pushReplacement('/scanning/roomplan/review', extra: RoomScanReviewArgs(draft: RoomScanDraft(plan: plan, objects: const []), scan: null))`; `ArPlanRejected` / xato / qo'llamaydi holatlari uchun sabab + tugmalar ("Qayta skaner", "Chizish", `arcore_not_installed` da "O'rnatish" → Play URL `market://details?id=com.google.ar.core`, `camera_denied` da "Sozlamalar"). `heightMeasured:false` bo'lsa review sahifasidagi balandlik chiplari (mavjud) qo'lda tanlash uchun yetarli.

- [ ] **Step 1: Failing testlar** (`ArScanService` ni soxta bilan override qilib):
  - `ok scan opens the review with an arcore plan` — `/scanning/roomplan/review` ga `RoomPlan.source == arcore` bilan o'tadi.
  - `cancelled scan goes back` — `null` → ekran yopiladi.
  - `rejected outline explains why and offers rescan or draw` — `ArPlanRejected('self_intersecting')` matni + ikki tugma.
  - `missing ARCore offers the install link` — `arcore_not_installed` → "O'rnatish".
  - `unsupported device offers draw` — `unsupported_device` → Chizish.
  - `review shows the accuracy note for arcore scans` va `review saves without a LiDAR scan payload` — `scan: null` bilan "Davom etish" `handoffRoomPlan` ni chaqiradi va artefakt yuklashni chaqirmaydi (mavjud `room_scan_review_upload_test` dagi soxtalar bilan).
  - `Android sheet shows the camera-measure entry` — `debugDefaultTargetPlatformOverride = TargetPlatform.android` → "Kamera bilan o'lchash".
- [ ] **Step 2:** `flutter test test/widget/ar_scan_screen_test.dart test/widget/room_scan_review_summary_test.dart` → FAIL.
- [ ] **Step 3:** Ekran, route, yo'naltirish, review o'zgarishlari va l10n (`flutter gen-l10n`) ni yozish. Mavjud `RoomScanReviewArgs(... scan: ...)` chaqiruvlari (`app_shell.dart:85`, `room_scan_screen.dart:92`, testlar) o'zgarishsiz kompilyatsiya bo'ladi.
- [ ] **Step 4:** `flutter analyze lib` va to'liq `flutter test` → PASS.
- [ ] **Step 5:** Commit: `feat(ar-scan): camera-measure flow on Android — scanner screen, review, copy`.

### Task 6: S25 Ultra'da qabul sinovi va build

**Files:** —

- [ ] **Step 1:** `flutter build apk --release` (prod `--dart-define` lari bilan, `BUILD_AND_RELEASE.md` dagidek; massiv `A=(…)` bilan uzatish) → APK `~/Downloads/AndozaAI.apk`; ichida `andoza.jumaniyozov.uz/api/v1` borligini `unzip -p … libapp.so | grep -a -c` bilan tekshirish.
- [ ] **Step 2:** Foydalanuvchi bilan qo'lda tekshiruv (spec "Qo'lda"): (1) to'rtburchak xona — ruletka bilan solishtirish, perimetr ≤ 3%, balandlik ≤ 5 sm; (2) L-shakl — 6 burchak; (3) xira yorug'lik / oq pol; (4) fonga o'tish, bekor qilish, kamera ruxsatini rad etish; (5) skaner → ko'rib chiqish → saqlash → Studio va smeta.
- [ ] **Step 3:** Topilgan muammolarni tuzatish (har biri o'z testi bilan), qayta APK, qayta sinov — 5 band ham o'tguncha.
- [ ] **Step 4:** iOS regressiyasi: `flutter build ios --simulator` va simulyatorda "LiDAR skaner" bandi avvalgidek (simulyatorda "qo'llamaydi" oynasi) — o'zgarmagan.
- [ ] **Step 5:** `pubspec.yaml` versiyasini oshirish, AAB yig'ish, commit + push (foydalanuvchi tasdig'idan keyin).
