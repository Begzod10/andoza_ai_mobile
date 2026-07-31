import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// E7: Onboarding Welcome
/// First-time user welcome and feature introduction
class E7OnboardingWelcomeScreen extends ConsumerWidget {
  const E7OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Skip button
              Padding(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Skip'),
                  ),
                ),
              ),

              // Hero illustration
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.home_repair_service,
                  size: 120,
                  color: DesignTokens.primaryBlue,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Welcome text
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Tamir!',
                      style: DesignTokens.heading2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      'Your complete solution for room measurement, interior design, cost estimation, and contractor management.',
                      style: DesignTokens.bodyMedium.copyWith(
                        color: DesignTokens.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Features
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing16,
                ),
                child: Column(
                  children: [
                    _FeatureCard(
                      icon: Icons.camera_alt_outlined,
                      title: 'Measure Rooms',
                      description:
                          'Capture accurate room dimensions using your phone',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _FeatureCard(
                      icon: Icons.palette_outlined,
                      title: 'Design Interiors',
                      description:
                          'Choose materials, colors, and layout options',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _FeatureCard(
                      icon: Icons.receipt_outlined,
                      title: 'Get Estimates',
                      description: 'Receive detailed cost breakdowns instantly',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _FeatureCard(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Shop Materials',
                      description: 'Browse and purchase materials directly',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _FeatureCard(
                      icon: Icons.person_outline,
                      title: 'Hire Contractors',
                      description: 'Connect with verified professionals',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: DesignTokens.spacing12),
            child: Text('Get Started'),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
            ),
            child: Icon(icon, color: DesignTokens.primaryBlue, size: 24),
          ),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.text,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  description,
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
