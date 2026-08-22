import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../config/design_tokens.dart';
import '../providers/auth_provider.dart';
import 'room_setup/new_project_sheet.dart';

/// Shared app shell: the bottom navigation bar (Uy / Do'kon / Ustalar /
/// Profil) with a center orange FAB that opens the "+" new-project sheet
/// (A3) — per spec, this FAB is a shared nav-level element, not something
/// any individual screen renders itself.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    // Restore token on app startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authStateProvider.notifier).restoreToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    if (location == '/login') {
      return Scaffold(body: widget.child);
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _BottomNavWithFab(location: location),
    );
  }
}

class _BottomNavWithFab extends StatelessWidget {
  const _BottomNavWithFab({required this.location});

  final String location;

  static const _tabs = [
    _NavTab(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Uy',
      route: '/',
    ),
    _NavTab(
      icon: Icons.storefront_outlined,
      activeIcon: Icons.storefront,
      label: "Do'kon",
      route: '/shop/s1',
    ),
    _NavTab(
      icon: Icons.groups_outlined,
      activeIcon: Icons.groups,
      label: 'Ustalar',
      route: '/masters/u1',
    ),
    _NavTab(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profil',
      route: '/profile',
    ),
  ];

  bool _isCurrent(_NavTab tab) {
    if (tab.route == '/') return location == '/';
    return location.startsWith(tab.route.split('/').take(2).join('/'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94 + 22,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 94,
            decoration: BoxDecoration(
              color: DesignTokens.white,
              border: const Border(
                top: BorderSide(color: Color(0xFFF0F1F4), width: 1),
              ),
              boxShadow: [DesignTokens.shadowNavBar],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(child: _navItem(context, _tabs[0])),
                  Expanded(child: _navItem(context, _tabs[1])),
                  const SizedBox(width: 64), // FAB gap
                  Expanded(child: _navItem(context, _tabs[2])),
                  Expanded(child: _navItem(context, _tabs[3])),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 94 - 32,
            child: Semantics(
              button: true,
              label: 'Yangi loyiha qo\'shish',
              child: GestureDetector(
              onTap: () => showNewProjectSheet(context),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2952D6), DesignTokens.primaryBlue],
                  ),
                  border: Border.all(color: DesignTokens.white, width: 4),
                  boxShadow: [DesignTokens.shadowFab],
                ),
                child: const Icon(
                  Icons.add,
                  color: DesignTokens.white,
                  size: 28,
                ),
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, _NavTab tab) {
    final isCurrent = _isCurrent(tab);
    final color = isCurrent ? DesignTokens.primaryBlue : DesignTokens.textMuted;
    return Semantics(
      button: true,
      selected: isCurrent,
      child: InkWell(
      onTap: () => context.go(tab.route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isCurrent ? tab.activeIcon : tab.icon, color: color, size: 24),
          const SizedBox(height: 2),
          Text(
            tab.label,
            style: DesignTokens.caption.copyWith(
              color: color,
              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class _NavTab {
  const _NavTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
}
