# ARCore bilan xona o'lchash (Android) — dizayn

Sana: 2026-10-11. Holat: tasdiqlangan dizayn, A bosqich.

## Maqsad

LiDAR'siz Android telefonlarda foydalanuvchi telefonni xonada yurgizib xona
rejasini (burchaklar, devor uzunliklari, shift balandligi) oladi. Natija iOS
LiDAR skaneri bilan bir xil yo'ldan o'tadi: ko'rib chiqish ekrani → saqlash →
3D Studio va smeta. Aniqlik maqsadi: perimetr xatosi ≤ 3%, balandlik ≤ 5 sm
(sinov qurilmasi: Samsung S25 Ultra).

**A bosqich (shu hujjat):** pol konturi (burchaklarni belgilash) + balandlik.
**B bosqich (keyin):** eshik va derazalarni belgilash.
**Doiradan tashqarida:** bir skanerda bir nechta xona, Depth API bilan
avtomatik devor aniqlash.

## Mavjud holat

- iOS: Apple RoomPlan, `MethodChannel("andoza/roomscan")`, `RoomScanService`,
  `RoomScanScreen` (`/scanning/roomplan`) → `RoomScanReviewPage` →
  `handoffRoomPlan` (`lib/services/room_plan_handoff.dart`).
- Android: "LiDAR skaner" "qo'llamaydi" deb Chizish/Foto taklif qiladi.
  Ishlatilmayotgan ARCore qolipi bor: `DepthScanActivity`, `RoomMeasurer`
  (tekislik o'lchamidan "quti" taxmini), `LidarMethodChannel`
  (`com.tamir_uy/lidar`), `BackgroundRenderer`, `ShaderUtil`;
  `com.google.ar:core:1.42.0`, manifestda ARCore `optional`.
- Dart geometriya: `RoomPlan.fromCorners`, `regularize`,
  `mergeCloseVertices`, `isSelfIntersecting`, `removeCollinearVertices`
  (`lib/geometry/room_geometry.dart`, `lib/models/room_plan.dart`).

## Tanlangan yondashuv

Alohida **native Android ekran** (Kotlin Activity: ARCore + OpenGL + native
tugmalar), Flutter uni platform channel orqali ochadi va JSON natija oladi —
iOS RoomPlan bilan bir xil tuzilish. Rad etilganlar: Flutter PlatformView
(OpenGL + Flutter kompozitsiyasi qotish/lifecycle xavfi), eskirgan Flutter AR
plaginlari (`ar_flutter_plugin` 2022'dan beri yangilanmagan).

Qoida: **native faqat xom o'lchovni oladi, hisob-kitobni Dart qiladi** —
to'g'rilash mantiqi unit-test qilinadi va iOS bilan bo'lishiladi.

## Foydalanuvchi jarayoni

Kirish: "Yangi loyiha" → "Kamera bilan o'lchash" (iOS'da "LiDAR skaner"
nomi qoladi). Android'da `RoomScanScreen` `/scanning/arcore` ga yo'naltiradi.

1. **Polni topish** — "Telefonni polga qaratib sekin aylantiring". Pol
   tekisligi topilgach markazda nishon chiqadi.
2. **Burchaklar** — nishonni pol burchagiga keltirib "Burchak qo'shish".
   Burchaklar orasida chiziq va uzunlik ko'rinadi; "Bekor qilish" oxirgisini
   o'chiradi; birinchi burchakka ≤ 20 sm yaqinlashganda yopishib kontur
   yopiladi (kamida 3 burchak).
3. **Balandlik** — birinchi burchakdan vertikal o'q; telefon shift chizig'iga
   qaratiladi, balandlik jonli ko'rinadi, "Tasdiqlash". O'lchab bo'lmasa —
   qo'lda kiritish (2.5 / 2.7 / 2.8 / 3.0 / 3.2 m tayyor variantlar).
4. **Natija** — skaner yopiladi, burchaklar + balandlik mavjud ko'rib chiqish
   ekraniga tushadi (devor uzunliklari, maydon, qo'lda tahrir), keyin
   `handoffRoomPlan` orqali saqlanadi.

Doimiy elementlar: qadam ko'rsatkichi ("2/3 — burchaklar"), kuzatuv
ogohlantirishi, "Chiqish" (tasdiq so'raydi).

## Aniqlik va to'g'rilash

**Kotlin (o'lchash paytida):**
- Har burchak ARCore `Anchor`; natija skaner yopilgan paytdagi anchor
  pozalaridan olinadi (ARCore xaritani yaxshilaganda ular siljiydi).
- Hit-test faqat topilgan pol tekisligiga (`Plane.Type.HORIZONTAL_UPWARD_FACING`,
  poza poligon ichida). Pol yo'q joyga bosilsa — "Avval polni skaner qiling".
- Barcha burchaklar birinchi pol tekisligi balandligiga keltiriladi (2D XZ).
- `TrackingState != TRACKING` bo'lsa burchak qo'shish o'chadi, sabab
  (`TrackingFailureReason`) ko'rsatiladi.

**Dart (`lib/features/ar_scan/arcore_plan.dart`, toza funksiyalar):**
1. `mergeCloseVertices` — 10 sm dan yaqin burchaklar birlashadi.
2. Yopilish xatosini taqsimlash — kontur yopilishidagi farq devorlarga
   uzunligiga mutanosib taqsimlanadi.
3. `regularize` — 90° ga ±8° yaqin burchaklar aniq 90°; qiya devorlar qoladi.
4. Tekshiruv — < 3 burchak yoki `isSelfIntersecting` → rad etiladi (sabab bilan).
5. Uzunliklar 1 sm ga yaxlitlanadi.
6. `RoomPlan.fromCorners(..., source: RoomSource.arcore)` — yangi enum qiymati.

Ko'rib chiqish ekranida izoh: "Kamera o'lchovi: ±3–5% xato bo'lishi mumkin,
muhim devorlarni ruletka bilan tekshiring".

## Interfeys: `MethodChannel("andoza/arscan")`

- `checkSupport()` → `{supported: bool, reason: String}`;
  `reason` ∈ `ok | arcore_not_installed | unsupported_device | camera_denied`.
- `scanFloorPlan({strings: Map<String,String>})` →
  `{corners: [[x, z], …] (metr), height: double, heightMeasured: bool,
  closed: bool, trackingLossCount: int, durationSec: int}`;
  bekor qilinsa `null`; xatoda `PlatformException(code, message)`.
  `strings` — ekran matnlari joriy tilda (uz/ru/en), Flutter l10n'dan.

`andoza/roomscan` (iOS) o'zgarmaydi.

## Fayllar

**Kotlin** (`android/app/src/main/kotlin/com/tamir_uy/tamir_uy_mobile_flutter/arscan/`):
- `ArScanChannel.kt` — kanal, Activity'ni ochish, natija qaytarish.
- `ArScanActivity.kt` — ARCore sessiyasi, qadamlar, tugmalar, lifecycle.
- `FloorPlanCapture.kt` — burchak/yopilish/balandlik mantig'i, ARCore'siz
  (JVM unit-test qilinadi).
- `ArRenderer.kt` — kamera foni (`BackgroundRenderer` qayta ishlatiladi),
  nuqtalar, chiziqlar, nishon.
- O'chiriladi: `DepthScanActivity.kt`, `RoomMeasurer.kt`,
  `LidarMethodChannel.kt` (va Dart'dagi `com.tamir_uy/lidar` foydalanuvchilari
  — `lidar_service.dart`, `lidar_provider.dart` — ishlatilishi tekshirilib,
  kerak bo'lsa yangi servisga o'tkaziladi).
- ARCore `1.42.0` → oxirgi barqaror versiya.

**Dart:**
- `lib/features/ar_scan/ar_scan_service.dart` — kanal o'rami.
- `lib/features/ar_scan/arcore_plan.dart` — to'g'rilash.
- `lib/screens/scanning/ar_scan_screen.dart` — `/scanning/arcore`.
- `RoomScanScreen`: Android'da yangi ekranga yo'naltirish.
- `new_project_sheet.dart`: Android'da band nomi "Kamera bilan o'lchash".
- l10n (uz/ru/en): skaner matnlari, izoh, xatolar.

## Xatolar

| Holat | Xatti-harakat |
|---|---|
| ARCore o'rnatilmagan | Play'dagi "Google Play Services for AR" ga havola; qaytgach qayta tekshiruv |
| Kamera ruxsati yo'q | Tushuntirish + Sozlamalarga o'tish |
| Qurilma qo'llamaydi | Chizish / Foto taklifi (avvalgidek) |
| Pol 20 s da topilmadi | Yorug'lik / naqshli yuza maslahati |
| Kuzatuv yo'qoldi | Qo'shish to'xtaydi, ogohlantirish; langarlar saqlanadi |
| Fonga o'tib qaytish | Sessiya davom etadi; burchaklar yo'qolsa "Qaytadan boshlash" |
| Yaroqsiz kontur | Sababli xabar → qayta skaner yoki chizish |
| Balandlik o'lchanmadi | Qo'lda kiritish |

## Test qilish

**Avtomatik:**
- Dart `arcore_plan`: qiyshiq to'rtburchak → 90°; L-shakl 6 burchak; qiya
  devor qoladi; yopilish xatosi taqsimlanadi; yaqin burchaklar birlashadi;
  kesishgan / < 3 burchak rad; manba `arcore`.
- Dart `ar_scan_service`: soxta kanal — natija, bekor qilish, xato kodlari,
  `MissingPluginException` → qo'llamaydi.
- Dart ekranlar: Android yo'naltirish, qo'llamaydigan holat taklifi.
- Kotlin `FloorPlanCapture` (JVM): qo'shish/bekor qilish, 20 sm yopishish,
  kuzatuv yo'qolganda blok, o'q bo'ylab balandlik.

**Qo'lda (S25 Ultra):**
1. To'rtburchak xona, ruletka bilan solishtirish: perimetr ≤ 3%, balandlik ≤ 5 sm.
2. L-shakl xona: 6 burchak.
3. Xira yorug'lik / oq pol: ko'rsatmalar, yiqilmaslik.
4. Fonga o'tish, bekor qilish, kamera ruxsatini rad etish.
5. Skaner → ko'rib chiqish → saqlash → Studio va smeta to'g'ri o'lchamlar.

## Tayyorlik mezoni (A bosqich)

- S25 Ultra'da 5 ta qo'lda tekshiruv o'tadi.
- Avtomatik testlar yashil, `flutter analyze` toza.
- iOS LiDAR skaneri o'zgarmagan holda ishlaydi.
- Play uchun build tayyor.
