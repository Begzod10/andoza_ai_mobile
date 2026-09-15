import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';

/// Splash Screen (S0)
/// Initial loading screen with gradient and brand logo animation
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: DesignTokens.animationSlow,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeInOutQuad),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();

    _bootstrap();
  }

  /// Restore any persisted session BEFORE navigating, so a returning user with
  /// a valid stored token lands on Home instead of being bounced to /login by
  /// the router's auth guard. Once auth resolves, we leave the splash and the
  /// redirect routes to '/' (authenticated) or '/login' (not).
  Future<void> _bootstrap() async {
    await ref.read(authStateProvider.notifier).restoreToken();
    if (!mounted) return;
    context.go('/');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: DesignTokens.darkBg,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.1,
            colors: [Color(0xFF1A2230), DesignTokens.darkBg],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Brand mark — large, centered, on the dark brand gradient.
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(
                    'assets/images/andozaai-mark.png',
                    width: 140,
                    height: 140,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              // Brand wordmark — set in Inter, not the source mark's own font.
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  l10n.brandName,
                  style: DesignTokens.heading2.copyWith(
                    color: DesignTokens.white,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXxl),
              // Loading Indicator
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      DesignTokens.white.withValues(alpha: 0.9),
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
