import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../config/design_tokens.dart';
import '../providers/auth_provider.dart';

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

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildBottomNav(context, location),
    );
  }

  Widget? _buildBottomNav(BuildContext context, String location) {
    // Hide nav on login screen
    if (location == '/login') return null;

    final tabs = [
      _NavTab(
        icon: Icons.home,
        label: 'Home',
        route: '/',
        current: location == '/',
      ),
      _NavTab(
        icon: Icons.add_circle,
        label: 'Measure',
        route: '/measurement/a1',
        current: location.startsWith('/measurement'),
      ),
      _NavTab(
        icon: Icons.history,
        label: 'History',
        route: '/history',
        current: location == '/history',
      ),
      _NavTab(
        icon: Icons.person,
        label: 'Profile',
        route: '/profile',
        current: location == '/profile',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: DesignTokens.border,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: tabs.indexWhere((t) => t.current),
        backgroundColor: DesignTokens.surface,
        items: tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              ),
            )
            .toList(),
        onTap: (index) {
          if (index < tabs.length) {
            context.go(tabs[index].route);
          }
        },
      ),
    );
  }
}

class _NavTab {
  _NavTab({
    required this.icon,
    required this.label,
    required this.route,
    required this.current,
  });

  final IconData icon;
  final String label;
  final String route;
  final bool current;
}
