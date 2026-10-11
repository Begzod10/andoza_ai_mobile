# Flutter Mobile App - Quick Reference Guide

## Build & Run

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build release APK (Android)
flutter build apk --release

# Build release IPA (iOS)
flutter build ios --release

# Analyze code
dart analyze

# Format code
dart format .
```

## Project Structure Cheat Sheet

| Path | Purpose |
|------|---------|
| `lib/config/design_tokens.dart` | All colors, spacing, typography, radius |
| `lib/config/router.dart` | GoRouter configuration, all 61 routes |
| `lib/screens/` | UI screens organized by series (A, B, D, E, S, U) |
| `lib/providers/` | Riverpod StateNotifierProvider definitions |
| `lib/models/` | Freezed immutable data models |
| `pubspec.yaml` | Dependencies and project configuration |

## Common Tasks

### Add a New Screen
1. Create file: `lib/screens/series/screen_file.dart`
2. Extend `ConsumerWidget` or `ConsumerStatefulWidget`
3. Add route to `lib/config/router.dart`:
   ```dart
   GoRoute(
     path: '/series/screen',
     builder: (context, state) => const ScreenName(),
   ),
   ```
4. Run `dart analyze` to verify

### Update Design Tokens
Edit `lib/config/design_tokens.dart`:
```dart
static const Color primaryBlue = Color(0xFF2563EB);
static const double spacing16 = 16.0;
static const double radiusMd = 12.0;
```

### Use Riverpod State
```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myProvider);
    return state.when(
      data: (data) => Text(data.toString()),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
```

### Navigate to a Route
```dart
context.go('/shop/s1');
context.push('/masters/u2');  // With back navigation
```

## Key Dependencies

- **flutter_riverpod** (3.1.2) - State management
- **go_router** (13.0.0) - Navigation
- **freezed_annotation** (2.4.1) - Model generation
- **dio** (5.4.0) - HTTP client
- **google_maps_flutter** (2.5.0) - Maps integration

## Design System

**Colors:**
- `primaryBlue` - Primary actions
- `accentOrange` - Highlights, warnings
- `success` - Success states
- `error` - Error states
- `text` - Primary text
- `textSecondary` - Secondary text

**Spacing:** `spacing4`, `spacing8`, `spacing12`, `spacing16`, `spacing24`, `spacing32`

**Radius:** `radiusSm` (8), `radiusMd` (12), `radiusLg` (16)

**Typography:** `heading1-3`, `subtitle1-2`, `bodyLarge/Medium/Small`, `caption`

## Screens by Series (Quick Navigation)

- **A1-A9:** `/measurement/a1` → `/measurement/a9`
- **B1-B4:** `/design/b1` → `/design/b4`
- **D1-D10:** `/electrical/d1` → `/electrical/d10`
- **E1-E3, E10:** `/estimation/e1`, `/estimation/e2`, `/estimation/e3`, `/estimation/e10`
- **E4-E6:** `/profile/e4`, `/profile/e5`, `/profile/e6`
- **E7-E9:** `/onboarding/e7`, `/onboarding/e8`, `/onboarding/e9`
- **S1-S7:** `/shop/s1` → `/shop/s7`
- **U1-U5:** `/masters/u1` → `/masters/u5`

## Testing Checklist

- [ ] Screen renders without errors
- [ ] All navigation works (forward & back)
- [ ] State persists across navigation
- [ ] Responsive design works on multiple screen sizes
- [ ] Accessibility features present (labels, contrast)
- [ ] No console warnings or errors
- [ ] Build passes `dart analyze`

## Troubleshooting

**Build fails:**
```bash
flutter clean
flutter pub get
flutter run
```

**Analysis errors:**
```bash
dart analyze --fatal-infos
dart fix --apply
```

**Lost hot reload:**
```bash
flutter clean
flutter run
```

---

For detailed information, see `DEVELOPMENT_SUMMARY.md`
