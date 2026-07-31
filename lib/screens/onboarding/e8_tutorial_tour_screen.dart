import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// E8: Interactive Tutorial & Feature Tour
/// Guided tour of app features and capabilities
class E8TutorialTourScreen extends ConsumerStatefulWidget {
  const E8TutorialTourScreen({super.key});

  @override
  ConsumerState<E8TutorialTourScreen> createState() =>
      _E8TutorialTourScreenState();
}

class _E8TutorialTourScreenState extends ConsumerState<E8TutorialTourScreen> {
  int _currentStep = 0;

  final List<_TutorialStep> _steps = [
    _TutorialStep(
      title: 'Capture Your Room',
      description:
          'Use your phone camera or LiDAR to accurately measure room dimensions. Start a new project from the home screen.',
      icon: Icons.camera_alt_outlined,
      highlightArea: 'measurement',
    ),
    _TutorialStep(
      title: 'Choose Your Design',
      description:
          'Select flooring materials, paint colors, and finishing options. Preview your choices in real-time.',
      icon: Icons.palette_outlined,
      highlightArea: 'design',
    ),
    _TutorialStep(
      title: 'Plan Your Electrical',
      description:
          'Map out electrical outlets, switches, and lighting placement. Get recommendations for safety and efficiency.',
      icon: Icons.power_outlined,
      highlightArea: 'electrical',
    ),
    _TutorialStep(
      title: 'Get Cost Estimates',
      description:
          'Receive detailed cost breakdowns for materials and labor. Export estimates as PDF for sharing.',
      icon: Icons.receipt_outlined,
      highlightArea: 'estimation',
    ),
    _TutorialStep(
      title: 'Browse Materials',
      description:
          'Shop for all materials directly in the app. Compare prices and read reviews from other users.',
      icon: Icons.shopping_bag_outlined,
      highlightArea: 'shop',
    ),
    _TutorialStep(
      title: 'Hire Contractors',
      description:
          'Connect with verified contractors in your area. View profiles, ratings, and request quotes.',
      icon: Icons.person_outline,
      highlightArea: 'masters',
    ),
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      context.go('/');
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Tour'),
        automaticallyImplyLeading: true,
        actions: [
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_currentStep + 1} of ${_steps.length}',
                        style: DesignTokens.bodyMedium.copyWith(
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                      Text(
                        '${((_currentStep + 1) / _steps.length * 100).toStringAsFixed(0)}%',
                        style: DesignTokens.bodyMedium.copyWith(
                          color: DesignTokens.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacing8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                    child: LinearProgressIndicator(
                      value: (_currentStep + 1) / _steps.length,
                      minHeight: 6,
                      backgroundColor: DesignTokens.border,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        DesignTokens.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Illustration area
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
              ),
              child: Icon(
                step.icon,
                size: 120,
                color: DesignTokens.primaryBlue,
              ),
            ),

            // Step content
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: DesignTokens.heading3.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  Text(
                    step.description,
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            // Tips section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacing12),
                decoration: BoxDecoration(
                  color: DesignTokens.accentOrange.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(
                    color: DesignTokens.accentOrange.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: DesignTokens.accentOrange,
                      size: 20,
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Text(
                        'Tip: Take your time exploring each feature. You can access the tutorial again from settings anytime.',
                        style: DesignTokens.caption.copyWith(
                          color: DesignTokens.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  child: const Text('Previous'),
                ),
              )
            else
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Exit'),
                ),
              ),
            const SizedBox(width: DesignTokens.spacing12),
            Expanded(
              child: ElevatedButton(
                onPressed: _nextStep,
                child: Text(
                  _currentStep == _steps.length - 1 ? 'Finish' : 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TutorialStep {
  _TutorialStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.highlightArea,
  });

  final String title;
  final String description;
  final IconData icon;
  final String highlightArea;
}
