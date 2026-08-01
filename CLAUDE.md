# Session Handoff — tamir_uy_mobile_flutter (PC2 copy)

This machine (PC2, 192.168.1.5, user `rimefara`) is a **secondary test
machine**, set up mid-session because PC1's Android emulator was
segfaulting. This directory is a **plain file copy** (via `tar` over SSH),
**not a git clone** — it has its own independent `.git` history that is
behind PC1's canonical repo and currently has local uncommitted edits.
Read this before doing anything else.

## Why this machine exists

PC1's emulator crashed ("Lost connection to device") every time, right
after login, during the IME-hide + Navigator transition to Home.
`dmesg` on PC2 (PC1 lacked passwordless sudo for this) showed the real
cause: a host-side `SIGSEGV` in the Android Emulator's own RenderThread —
a known Flutter **Impeller**-vs-Android-emulator incompatibility
(flutter/flutter#105323, #175562, #148481, #163421), not a hardware
problem and not an app bug. Confirmed fixed by disabling Impeller
(see Fixes below). PC2 was set up in parallel to cross-check on a second
GPU/host before that root cause was found, and ended up being the
machine all the live QA in this session actually ran on.

## Repo / git state on THIS machine

- `git log --oneline -5` here tops out at `adc187d step 13: final QA /
  regression pass (last gate)` — it does **not** have the later commits
  that exist on PC1 (`6ea082d`, `3c206f5`, `a9f5bac`).
- Instead, this working tree has those same fixes applied as
  **uncommitted local modifications** (they were `scp`'d over as raw
  files, not `git pull`'d), currently showing as modified in
  `git status --short`:
  - `android/app/src/main/AndroidManifest.xml`
  - `android/gradle.properties` (see divergence note below — do NOT
    copy this one back to PC1 as-is)
  - `lib/config/router.dart`
  - `lib/screens/app_shell.dart`
  - `lib/screens/home/home_empty_screen.dart`
- **If you want a clean git history here**, either `git pull`/fetch from
  wherever PC1's remote lives (if one exists) or treat PC1
  (`/home/rimefara/projects/tamir_uy_mobile_flutter`) as the source of
  truth and re-sync. Don't assume `git log` here reflects the real
  project history.

## Fixes made this session (all committed on PC1, uncommitted here)

1. **Impeller emulator crash** (the big one) — `android/app/src/main/
   AndroidManifest.xml`: added
   `io.flutter.embedding.android.EnableImpeller = false` meta-data to
   fall back to Skia. This is what actually made the emulator stable —
   without it, the app reliably segfaults the emulator's RenderThread
   shortly after login.
2. **`HomeGreetingHeader` RenderFlex overflow** (58px) when a long user
   name competes with the "AndozaAI" status pill —
   `lib/screens/home/home_empty_screen.dart`: wrapped the greeting
   Column in `Expanded` + added `maxLines: 1, overflow: TextOverflow
   .ellipsis` to the name Text.
3. **E7/E8 onboarding bled through the tab shell's bottom nav/FAB**,
   and the system back button exited the app instead of returning
   Home — root cause was go_router's `ShellRoute` nested-Navigator
   default resolving `context.push()` onto the shell's own Navigator.
   Fixed in `lib/config/router.dart` with a root `navigatorKey` +
   `parentNavigatorKey` on the E7/E8 routes, and switched their
   story-circle taps from `context.go` to `context.push` in
   `home_empty_screen.dart` so they get a real back-stack entry.
4. **U1 pin-preview bottom sheet's "Profilni ko'rish" button
   untappable near the bottom nav** — same root-cause family as #3.
   `extendBody: true` on `AppShell`'s `Scaffold`
   (`lib/screens/app_shell.dart`) let the ShellRoute branch Navigator's
   Overlay (and any modal bottom sheet inside it) extend past the nav
   bar's top edge; the bottom nav/FAB paints on top of that region and
   always wins hit-testing there, so taps on the sheet's CTA fell
   through to the nav bar underneath. Fixed by removing `extendBody:
   true`. Verified live: tapping the wrench pin → "Profilni ko'rish"
   now correctly opens the master's full profile (U4).

## Environment on this machine

- Flutter: `~/flutter` (stable branch, `git clone -b stable
  https://github.com/flutter/flutter.git` — NOT installed via AUR/pacman,
  that failed on a stale `dart<3.12.0` constraint).
- Android SDK: `~/Android` (cmdline-tools, platform-tools, platforms
  34/35/36, system-image `android-34 google_apis x86_64`, emulator,
  build-tools 34.0.0, NDK 28.2.13676358, cmake 3.22.1).
- AVD: `Pixel5` (`~/.android/avd/Pixel5.avd`).
- `~/.bashrc` has `ANDROID_HOME`/`PATH` exports already added.
- `android/gradle.properties` **on this machine only** has
  `org.gradle.java.home` pointed at
  `/usr/lib/jvm/java-17-openjdk` (PC1's canonical copy uses a different,
  PC1-specific JDK path — don't let this diff leak back to PC1).
- A `system-images;android-30;google_apis;x86_64` download may have
  been left running/incomplete in the background from an earlier
  troubleshooting detour that got superseded once the Impeller fix
  landed — check `sdkmanager --list_installed` if you care, it's not
  needed for anything currently working.

## How to run

Backend lives on PC1 (192.168.1.29:8000, FastAPI + Postgres in Docker,
project at `/home/rimefara/projects/tamir_uy/backend` on PC1). Point
the emulator at it via `--dart-define` (no source changes needed —
`lib/config/app_config.dart` already reads `API_URL`/`API_BASE_URL`
from `String.fromEnvironment`):

```bash
export ANDROID_HOME=/home/rimefara/Android
export PATH="$HOME/flutter/bin:$ANDROID_HOME/platform-tools:$PATH"
cd /home/rimefara/projects/tamir_uy_mobile_flutter
flutter run -d emulator-5554 --debug \
  --dart-define=API_URL=http://192.168.1.29:8000/api/v1 \
  --dart-define=API_BASE_URL=http://192.168.1.29:8000
```

(Start the emulator first if it isn't already up:
`~/Android/emulator/emulator -avd Pixel5 -no-window -no-audio &`, or
drop the `-no-window` if you have a display attached.)

**Login**: there's a real seeded test account — username `rimefara`,
password `12345678` (name "Test User", phone `998901234567`, created on
PC1's backend). Login form labels say "Email"/"Password" but the field
actually validates as `username`.

**Tap automation tip** (learned the hard way this session): don't
compute tap coordinates by eyeballing a screenshot — screenshots you
see are scaled (e.g. 923×2000 shown for a real 1080×2340 device, factor
≈1.17), and on-screen-keyboard appearance shifts field positions.
Instead use `adb shell uiautomator dump /sdcard/ui.xml` +
`adb pull`, then grep the XML's `content-desc="..."` /
`bounds="[x1,y1][x2,y2]"` attributes and tap the bounds' center in real
device pixels. Much more reliable than screenshot-coordinate math.

## What's been visually verified live (this session, on this machine)

- Home (A1), Do'kon home (S1), Ustalar map (U1) + list (U3), Profil (E4)
- E5 (Loyihalarim), E6 (Buyurtmalarim), E11 (Saqlangan dizaynlar)
- E7 (onboarding slide 1, post-fix), E8 (Demo qo'llanma)
- Full Do'kon purchase flow: S3 (product detail) → S4 (dealer
  comparison, cheapest-dealer "ENG YAXSHI" ribbon logic correct) → S5
  (cart, delivery-fee math correct) → S6 (checkout, payment method
  selector) → S7 (order status timeline)
- Full Ustalar booking flow: U1 (map) → U3 (list) → U4 (full profile,
  correct privacy-safe approximate-location circle, not an exact pin)
  → U5 (send-smeta sheet, personalized greeting + correct computed
  price)

## What's still outstanding

- Not yet re-verified live post-fix: E5/E6/E11 and the Do'kon/Ustalar
  flows above were checked *before* the `extendBody` fix landed — none
  of them exercise a modal-bottom-sheet-near-the-nav-bar path, so
  they're not expected to regress, but they haven't been re-screenshotted
  since.
- `android/gradle.properties` JDK-path divergence between PC1 and this
  machine (noted above) — never reconciled; PC1's canonical copy is
  correct for PC1 but the checked-in path isn't portable across
  machines. Worth switching to `JAVA_HOME` env var instead of a
  hardcoded property if this project moves between machines again.
- This machine's git history is stale relative to PC1 (see "Repo / git
  state" above) — decide whether to sync before doing further git
  operations here.
