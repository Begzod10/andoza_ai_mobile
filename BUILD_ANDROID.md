# Building the Android App (Flutter) — Setup & Gotchas

This is the exact, working recipe for building the **Andoza AI** mobile app on this
machine. It documents the non-standard toolchain layout that caused the install/build
trouble, so you never have to rediscover it.

> App id: `com.tamir_uy.tamir_uy_mobile_flutter` · Brand: **Andoza AI** · min Android 7.0 (SDK 24)

---

## TL;DR — build a server-connected APK

```bash
# 1. Put the toolchain on PATH (Flutter is NOT installed globally — see below)
export PATH="$PATH:/home/rimefara/flutter/bin:/home/rimefara/Android/platform-tools"

# 2. Tell Flutter where the (non-default) Android SDK lives — ONE TIME
flutter config --android-sdk /home/rimefara/Android

# 3. Build a release APK with the server API baked in
cd /home/rimefara/projects/tamir_uy_mobile_flutter
flutter build apk --release \
  --dart-define=API_URL=http://189.74.96.11:8000/api/v1 \
  --dart-define=API_BASE_URL=http://189.74.96.11:8000 \
  --dart-define=STUDIO_BASE_URL=http://189.74.96.11:5173

# Output: build/app/outputs/flutter-apk/app-release.apk  (~60 MB)
```

Install on a phone plugged in via USB (USB debugging on):

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

Log in with a seeded test account: **`rimefara` / `12345678`**.

---

## Verified toolchain on this machine (Arch Linux)

| Component | Version | Location |
|---|---|---|
| Flutter | 3.44.8 (stable) | `/home/rimefara/flutter` (git clone) |
| Dart | 3.12.2 | bundled with Flutter |
| Android SDK | — | `/home/rimefara/Android` **(non-standard path)** |
| Platform tools (`adb`) | — | `/home/rimefara/Android/platform-tools` (also symlinked at `/usr/bin/adb`) |
| Build-tools | 34.0.0 | `/home/rimefara/Android/build-tools` |
| Platforms | android-34, 35, 36 | `/home/rimefara/Android/platforms` |
| NDK | 28.2.13676358 | `/home/rimefara/Android/ndk` |
| JDK | OpenJDK 17.0.19 | system (`/usr/lib/jvm/default`) |

---

## The troubles we hit (and the fixes)

### 1. `flutter: command not found`
Flutter is a **git checkout at `/home/rimefara/flutter`**, not a system package, and its
`bin/` is **not on the default PATH**. Every new shell needs:

```bash
export PATH="$PATH:/home/rimefara/flutter/bin:/home/rimefara/Android/platform-tools"
```

**Make it permanent** — add that line to `~/.bashrc` (this machine uses bash):

```bash
echo 'export PATH="$PATH:/home/rimefara/flutter/bin:/home/rimefara/Android/platform-tools"' >> ~/.bashrc
```

### 2. Android SDK is in a non-default folder
Flutter expects `~/Android/Sdk`, but here it's `~/Android` (no `Sdk` subfolder).
`ANDROID_HOME` is **unset**, so `flutter doctor` couldn't find the SDK. Fix it once:

```bash
flutter config --android-sdk /home/rimefara/Android
# optional but recommended for other Android tooling:
export ANDROID_HOME=/home/rimefara/Android
export ANDROID_SDK_ROOT=/home/rimefara/Android
```

### 3. Android license / cmdline-tools checks
If `flutter doctor` complains about licenses:

```bash
flutter doctor --android-licenses   # accept all with "y"
```

The `cmdline-tools`, `licenses`, and `platform-tools` are already present under
`/home/rimefara/Android`, so this should just tick the boxes.

### 4. Sanity-check the environment before building
```bash
flutter doctor -v
```
The two lines that matter: **Flutter** (channel stable, at `/home/rimefara/flutter`) and
**Android toolchain** (SDK at `/home/rimefara/Android`, Java 17). Chrome/Linux-desktop
warnings are irrelevant for an APK build.

---

## Why `--dart-define` (and what the defaults are)

The API endpoints are **compile-time constants** read via `String.fromEnvironment` in
[`lib/config/app_config.dart`](lib/config/app_config.dart). If you don't pass
`--dart-define`, the build falls back to the **Android-emulator defaults**:

| Define | Default (emulator) | Pass this for the server |
|---|---|---|
| `API_URL` | `http://10.0.2.2:8000/api/v1` | `http://189.74.96.11:8000/api/v1` |
| `API_BASE_URL` | `http://10.0.2.2:8000` | `http://189.74.96.11:8000` |
| `STUDIO_BASE_URL` | `http://10.0.2.2:5173` | `http://189.74.96.11:5173` |

- `10.0.2.2` is the emulator's alias for the host machine's `localhost` — it only works
  **inside the Android emulator**, never on a physical phone.
- For a real phone the value must be reachable from the phone: the **public server IP**
  (`189.74.96.11`) over the internet, or your **PC's LAN IP** (e.g. `192.168.x.x`) if the
  backend runs locally and the phone is on the same Wi-Fi.

**Verify the URLs actually got baked in** (they're AOT-inlined into `libapp.so`):

```bash
unzip -p build/app/outputs/flutter-apk/app-release.apk lib/arm64-v8a/libapp.so \
  | strings | grep -E '189\.74\.96\.11|10\.0\.2\.2'
```
You should see the server URLs and **no** `10.0.2.2` leaking.

---

## Signing — the release APK is debug-signed (intentional, for now)

`android/app/build.gradle.kts` sets the `release` build type to reuse the **debug**
signing config (there's no keystore / `key.properties`). That's why the release APK
installs by sideloading without extra setup — but Android will show an *"unknown
developer"* prompt, and this APK **cannot be published to Google Play**.

To ship for real, generate an upload keystore and wire it into `build.gradle.kts`:

```bash
keytool -genkey -v -keystore ~/andoza-upload.jks -keyalg RSA -keysize 2048 \
  -validity 10000 -alias andoza
```
Then create `android/key.properties` (git-ignored) and reference it from
`signingConfigs { release { ... } }`. Ask and I'll wire this up.

---

## Cleartext HTTP note

The server is plain **HTTP** (no TLS). The app allows this because
`android:usesCleartextTraffic="true"` is set in the Android manifest. Fine for testing;
put HTTPS on the API before a real launch, then this flag can be removed.

---

## Handy commands

```bash
# List connected devices / emulators
adb devices
flutter devices

# Run in debug on a connected device (hot reload)
flutter run --dart-define=API_URL=http://189.74.96.11:8000/api/v1 \
            --dart-define=API_BASE_URL=http://189.74.96.11:8000 \
            --dart-define=STUDIO_BASE_URL=http://189.74.96.11:5173

# Smaller, per-architecture APKs instead of one fat APK
flutter build apk --release --split-per-abi <same --dart-define flags>

# App Bundle for the Play Store (needs a real release keystore first)
flutter build appbundle --release <same --dart-define flags>

# Clean build if things get weird
flutter clean && flutter pub get
```

---

## Server reference (backend the app talks to)

- **API:** `http://189.74.96.11:8000` (FastAPI, routes under `/api/v1`)
- **Web/Studio:** `http://189.74.96.11:5173`
- Deployed via `docker-compose.prod.yml`; auto-deploys on push to `master`
  (GitHub Actions → SSH → `deploy/remote-deploy.sh`).
- Test login: **`rimefara` / `12345678`**.
