import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import '../providers/auth_provider.dart';
import '../screens/app_shell.dart';
import '../screens/auth/login_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/home_empty_screen.dart';
import '../screens/home/home_with_projects_screen.dart';
import '../screens/room_setup/dimensions_entry_screen.dart';
import '../screens/room_setup/wall_measurements_screen.dart';
import '../screens/room_setup/room_summary_screen.dart';
import '../screens/scanning/lidar_scanning_screen.dart';
import '../screens/scanning/photo_scanning_screen.dart';
import '../screens/measurement/measurement_stubs.dart';
import '../screens/design/b1_room_intro_screen.dart';
import '../screens/design/b2_room_entry_screen.dart';
import '../screens/design/b3_decoration_rail_screen.dart';
import '../screens/interior/c1_paint_wallpaper_screen.dart';
import '../screens/interior/c4_floor_selection_screen.dart';
import '../screens/interior/c5_furniture_placement_screen.dart';
import '../screens/interior/c7_walkthrough_screen.dart';
import '../screens/interior/c8_topdown_plan_screen.dart';
import '../screens/interior/c9_decoration_complete_screen.dart';
import '../screens/electrical/d1_electrical_intro_screen.dart';
import '../screens/electrical/d2_wire_routing_screen.dart';
import '../screens/electrical/d3_advanced_routing_screen.dart';
import '../screens/electrical/d4_routing_confirmation_screen.dart';
import '../screens/electrical/d5_outlet_placement_screen.dart';
import '../screens/electrical/d6_lighting_placement_screen.dart';
import '../screens/electrical/d7_device_review_screen.dart';
import '../screens/electrical/d8_electrical_summary_screen.dart';
import '../screens/electrical/d9_cost_estimate_screen.dart';
import '../screens/electrical/d10_final_confirmation_screen.dart';
import '../screens/estimation/e1_estimation_intro_screen.dart';
import '../screens/estimation/e2_material_costs_screen.dart';
import '../screens/estimation/e3_labor_costs_screen.dart';
import '../screens/estimation/e10_estimate_summary_screen.dart';
import '../screens/shop/s1_shop_home_screen.dart';
import '../screens/shop/s5_shopping_cart_screen.dart';
import '../screens/shop/s7_order_confirmation_screen.dart';
import '../screens/masters/u1_masters_intro_screen.dart';
import '../screens/masters/u2_master_profile_screen.dart';
import '../screens/masters/u3_request_booking_screen.dart';
import '../screens/masters/u4_review_rating_screen.dart';
import '../screens/masters/u5_booking_confirmation_screen.dart';
import '../screens/profile/e4_profile_settings_screen.dart';
import '../screens/profile/e5_payment_methods_screen.dart';
import '../screens/profile/e6_saved_estimates_screen.dart';
import '../screens/onboarding/e7_onboarding_welcome_screen.dart';
import '../screens/onboarding/e8_tutorial_tour_screen.dart';
import '../screens/onboarding/e9_preferences_settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _GoRouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isAuthenticated = authState is AuthAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login';
      final isSplash = state.matchedLocation == '/splash';

      // Allow splash screen
      if (isSplash) {
        return null;
      }

      // Redirect unauthenticated users to login
      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }

      // Redirect authenticated users away from login
      if (isAuthenticated && isLoginRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeWithProjectsScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const E6SavedEstimatesScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const E4ProfileSettingsScreen(),
          ),
          // New AndozaAI Routes
          GoRoute(
            path: '/home/empty',
            builder: (context, state) => const HomeEmptyScreen(),
          ),
          GoRoute(
            path: '/home/projects',
            builder: (context, state) => const HomeWithProjectsScreen(),
          ),
          GoRoute(
            path: '/setup/dimensions',
            builder: (context, state) => const DimensionsEntryScreen(),
          ),
          GoRoute(
            path: '/setup/wall-measurements',
            builder: (context, state) => const WallMeasurementsScreen(),
          ),
          // A8 (Eshik/Deraza qo'shish) has no standalone route — it's only
          // ever shown as a modal sheet with a real onAdd callback, from A7
          // (wall_measurements_screen.dart's _showAddOpeningSheet).
          GoRoute(
            path: '/setup/summary',
            builder: (context, state) => const RoomSummaryScreen(),
          ),
          GoRoute(
            path: '/scanning/lidar',
            builder: (context, state) => const LiDARScanningScreen(),
          ),
          GoRoute(
            path: '/scanning/photo',
            builder: (context, state) => const PhotoScanningScreen(),
          ),
          // Batch B Routes (Room state & entering the 3D room) — B1 kept
          // (matches spec), B1-alt/B2/B3 are genuinely missing and get
          // built fresh in Step 5. B2-B4 route paths retired here since
          // design/b2-b4_*.dart don't correspond to real spec screens
          // (see plans/screen-mapping.md) — they remain as unrouted
          // reference files for Step 9's in-3D rail screens to consult.
          GoRoute(
            path: '/design/b1',
            builder: (context, state) => const B1RoomIntroScreen(),
          ),
          GoRoute(
            path: '/design/b2',
            builder: (context, state) => const B2RoomEntryScreen(),
          ),
          GoRoute(
            path: '/design/b3',
            builder: (context, state) => const B3DecorationRailScreen(),
          ),
          // Batch C Routes (decoration inside the 3D room) — C1-C3, C5-C6
          // are each one continuous interactive screen (see
          // c1_paint_wallpaper_screen.dart's doc comment for why).
          GoRoute(
            path: '/interior/c1',
            builder: (context, state) => const C1PaintWallpaperScreen(),
          ),
          GoRoute(
            path: '/interior/c4',
            builder: (context, state) => const C4FloorSelectionScreen(),
          ),
          GoRoute(
            path: '/interior/c5',
            builder: (context, state) => const C5FurniturePlacementScreen(),
          ),
          GoRoute(
            path: '/interior/c7',
            builder: (context, state) => const C7WalkthroughScreen(),
          ),
          GoRoute(
            path: '/interior/c8',
            builder: (context, state) => const C8TopdownPlanScreen(),
          ),
          GoRoute(
            path: '/interior/c9',
            builder: (context, state) => const C9DecorationCompleteScreen(),
          ),
          // Electrical System Routes (D1-D10)
          GoRoute(
            path: '/electrical/d1',
            builder: (context, state) => const D1ElectricalIntroScreen(),
          ),
          GoRoute(
            path: '/electrical/d2',
            builder: (context, state) => const D2WireRoutingScreen(),
          ),
          GoRoute(
            path: '/electrical/d3',
            builder: (context, state) => const D3AdvancedRoutingScreen(),
          ),
          GoRoute(
            path: '/electrical/d4',
            builder: (context, state) => const D4RoutingConfirmationScreen(),
          ),
          GoRoute(
            path: '/electrical/d5',
            builder: (context, state) => const D5OutletPlacementScreen(),
          ),
          GoRoute(
            path: '/electrical/d6',
            builder: (context, state) => const D6LightingPlacementScreen(),
          ),
          GoRoute(
            path: '/electrical/d7',
            builder: (context, state) => const D7DeviceReviewScreen(),
          ),
          GoRoute(
            path: '/electrical/d8',
            builder: (context, state) => const D8ElectricalSummaryScreen(),
          ),
          GoRoute(
            path: '/electrical/d9',
            builder: (context, state) => const D9CostEstimateScreen(),
          ),
          GoRoute(
            path: '/electrical/d10',
            builder: (context, state) => const D10FinalConfirmationScreen(),
          ),
          GoRoute(
            path: '/electrical/complete',
            builder: (context, state) => const MeasurementStub(
              title: 'Electrical Design Complete',
              description: 'Your electrical system has been planned and saved',
            ),
          ),
          // Estimation Routes (E1-E3, E10)
          GoRoute(
            path: '/estimation/e1',
            builder: (context, state) => const E1EstimationIntroScreen(),
          ),
          GoRoute(
            path: '/estimation/e2',
            builder: (context, state) => const E2MaterialCostsScreen(),
          ),
          GoRoute(
            path: '/estimation/e3',
            builder: (context, state) => const E3LaborCostsScreen(),
          ),
          GoRoute(
            path: '/estimation/e10',
            builder: (context, state) => const E10EstimateSummaryScreen(),
          ),
          // Shop Routes (S1-S7)
          GoRoute(
            path: '/shop/s1',
            builder: (context, state) => const S1ShopHomeScreen(),
          ),
          GoRoute(
            path: '/shop/s2',
            builder: (context, state) => const MeasurementStub(
              title: 'Product Catalog',
              description: 'Browse products by category with filtering',
            ),
          ),
          GoRoute(
            path: '/shop/s3',
            builder: (context, state) => const MeasurementStub(
              title: 'Product Details',
              description: 'View product specifications and reviews',
            ),
          ),
          GoRoute(
            path: '/shop/s4',
            builder: (context, state) => const MeasurementStub(
              title: 'Product Detail',
              description: 'Full product details with images and pricing',
            ),
          ),
          GoRoute(
            path: '/shop/s5',
            builder: (context, state) => const S5ShoppingCartScreen(),
          ),
          GoRoute(
            path: '/shop/s6',
            builder: (context, state) => const MeasurementStub(
              title: 'Checkout',
              description: 'Order review and payment',
            ),
          ),
          GoRoute(
            path: '/shop/s7',
            builder: (context, state) => const S7OrderConfirmationScreen(),
          ),
          // Masters Routes (U1-U5)
          GoRoute(
            path: '/masters/u1',
            builder: (context, state) => const U1MastersIntroScreen(),
          ),
          GoRoute(
            path: '/masters/u2',
            builder: (context, state) => const U2MasterProfileScreen(),
          ),
          GoRoute(
            path: '/masters/u3',
            builder: (context, state) => const U3RequestBookingScreen(),
          ),
          GoRoute(
            path: '/masters/u4',
            builder: (context, state) => const U4ReviewRatingScreen(),
          ),
          GoRoute(
            path: '/masters/u5',
            builder: (context, state) => const U5BookingConfirmationScreen(),
          ),
          // Profile Routes (E4-E6)
          GoRoute(
            path: '/profile/e4',
            builder: (context, state) => const E4ProfileSettingsScreen(),
          ),
          GoRoute(
            path: '/profile/e5',
            builder: (context, state) => const E5PaymentMethodsScreen(),
          ),
          GoRoute(
            path: '/profile/e6',
            builder: (context, state) => const E6SavedEstimatesScreen(),
          ),
          // Onboarding Routes (E7-E8 — spec has no separate E9, see
          // plans/screen-mapping.md; the existing E9 settings screen moves
          // to /profile/settings, reachable from E4's menu, wired in Step 8)
          GoRoute(
            path: '/onboarding/e7',
            builder: (context, state) => const E7OnboardingWelcomeScreen(),
          ),
          GoRoute(
            path: '/onboarding/e8',
            builder: (context, state) => const E8TutorialTourScreen(),
          ),
          GoRoute(
            path: '/profile/settings',
            builder: (context, state) => const E9PreferencesSettingsScreen(),
          ),
        ],
      ),
    ],
  );
});

/// Bridges Riverpod's [authStateProvider] to GoRouter's [Listenable]-based
/// refresh mechanism, so an auth change re-runs `redirect` without
/// rebuilding the GoRouter instance (which would reset navigation to
/// `initialLocation` and remount the whole shell).
class _GoRouterRefreshNotifier extends ChangeNotifier {
  _GoRouterRefreshNotifier(Ref ref) {
    _subscription = ref.listen<AuthState>(
      authStateProvider,
      (previous, next) => notifyListeners(),
    );
  }

  late final ProviderSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
