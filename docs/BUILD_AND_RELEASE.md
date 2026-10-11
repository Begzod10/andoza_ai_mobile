# Build, imzolash va reliz

Ilovani lokal ishga tushirish, sozlash, Android va iOS build'larini olish va
do'konlarga chiqarish. Batafsil: [mobile/IOS_BUILD.md](mobile/IOS_BUILD.md) (iOS, TestFlight)
va [RELEASE_SIGNING.md](RELEASE_SIGNING.md) (Android kalit).

## Talablar

- Flutter **3.44.8** stable (CI shu versiyani ishlatadi), Dart `^3.12.1`.
- Android: Java 17, Android SDK (minSdk 24).
- iOS: macOS va Xcode, minimal iOS **15.0**. LiDAR skaner iOS 16+ va LiDAR'li iPhone/iPad'da ishlaydi.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed/json modellar
flutter gen-l10n                                            # tarjimalar (pub get ham qiladi)
```

## Sozlamalar (`--dart-define`)

Hammasi `lib/config/app_config.dart` da. Flavor'lar yo'q: muhit faqat shu qiymatlar bilan almashadi.

| Nom | Standart | Vazifasi |
|---|---|---|
| `API_URL` | `http://10.0.2.2:8000/api/v1` | Backend API |
| `API_BASE_URL` | `http://10.0.2.2:8000` | Backend origin (media fayllar) |
| `STUDIO_BASE_URL` | `http://10.0.2.2:5173` | WebView'da ochiladigan veb-studiya |
| `SMS_LOGIN_ENABLED` | `false` | SMS kod bilan kirish. O'chiq bo'lsa, login va parol |
| `LIDAR_ENABLED` | `true` | LiDAR skaner |
| `DEBUG_LOGGING` | `true` | Debug log (so'rov tanalari baribir yozilmaydi) |

`10.0.2.2` — Android emulyatoridan kompyuterning `localhost` iga murojaat.
Haqiqiy qurilma yoki production uchun:

```bash
flutter run \
  --dart-define=API_URL=https://andoza.jumaniyozov.uz/api/v1 \
  --dart-define=API_BASE_URL=https://andoza.jumaniyozov.uz \
  --dart-define=STUDIO_BASE_URL=https://andoza.jumaniyozov.uz
```

Android HTTP (shifrlanmagan) ulanishni faqat `10.0.2.2`, `localhost`, `127.0.0.1`
va ikkita lokal tarmoq manzili uchun ruxsat beradi
(`android/app/src/main/res/xml/network_security_config.xml`). iOS'da ATS istisnolari
yo'q. Shuning uchun haqiqiy qurilmada server manzili **HTTPS** bo'lishi kerak.

## Identifikatorlar

| | Android | iOS |
|---|---|---|
| Ilova ID | `andozaai.com` (`applicationId`) | `com.tamiruy.tamirUyMobileFlutter` (bundle id) |
| Kod paketi | `com.tamir_uy.tamir_uy_mobile_flutter` (namespace) | — |
| Nomi | Andoza AI | Andoza AI |
| Minimal versiya | Android 7.0 (SDK 24) | iOS 15.0 |
| Imzolash | `android/key.properties` (yo'q bo'lsa debug kalit) | Apple team `24GC58FD74`; CI'da qo'lda imzolash (`ios/ExportOptions.plist`) |

Android'da `andozaai://` deep link'lari yoqilgan. Impeller o'chirilgan:
emulyatorlarda u ilovani yiqitardi.

## Versiya

`pubspec.yaml` dagi `version: 1.0.0+N` qo'lda oshiriladi (`+N` — build raqami,
har reliz uchun oshadi). Commit odati: `chore: 1.0.0+N (<qisqa izoh>)`.
`AppConfig.appVersion` ishlatilmaydi. Sozlamalar ekrani versiyani `package_info_plus` dan oladi.

## CI (`.github/workflows/`)

| Workflow | Qachon | Nima qiladi |
|---|---|---|
| `ci.yml` | `main` ga push, har bir PR | `flutter analyze` va `flutter test` |
| `ios-check.yml` | PR (iOS bilan bog'liq fayllar) | Imzosiz simulator build — iOS kompilyatsiya bo'lishini tekshiradi |
| `ios.yml` | `main` ga push (`lib/`, `ios/`, `pubspec.*` o'zgarsa), qo'lda | Imzolangan IPA va TestFlight'ga yuklash. Server manzillari `API_URL_PROD`, `API_BASE_URL_PROD`, `STUDIO_BASE_URL_PROD` secret'laridan |
| `release.yml` | `v*` tag, qo'lda | Imzolangan Android AAB (production manzillari bilan). Play'ga avtomatik yuklash hozircha o'chiq |

Kerakli secret'lar ro'yxati: iOS — [mobile/IOS_BUILD.md](mobile/IOS_BUILD.md), Android — [RELEASE_SIGNING.md](RELEASE_SIGNING.md).

## Testlar

```bash
flutter test
```

`test/` da 53 ta test fayli: `unit/`, `widget/`, `providers/`, `features/room_scan/`,
`geometry/`, `models/`. Yordamchilar: `test/support/localized_pump.dart` (tarjimalar bilan
widget chizish), `test/fixtures/`. Integratsiya testlari yo'q.
Modellar o'zgargan bo'lsa, avval `build_runner` ni ishga tushiring.
