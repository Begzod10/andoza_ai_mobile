import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/electrical_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/design/stage_progress_line.dart';

/// D1: Electrical System Introduction
/// Explains electrical system planning and allows user to proceed with wire routing
class D1ElectricalIntroScreen extends ConsumerStatefulWidget {
  const D1ElectricalIntroScreen({super.key});

  @override
  ConsumerState<D1ElectricalIntroScreen> createState() =>
      _D1ElectricalIntroScreenState();
}

class _D1ElectricalIntroScreenState
    extends ConsumerState<D1ElectricalIntroScreen> {
  int _selectedLoadIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electrical System'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress
              StageProgressLine(currentStep: 0, totalSteps: 3),
              const SizedBox(height: DesignTokens.spacing32),

              // Header
              Text(
                'Plan Your Electrical System',
                style: DesignTokens.heading3.copyWith(color: DesignTokens.text),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Text(
                'Design the wiring layout, place outlets and switches, and calculate material costs.',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // System type selector
              Text(
                'Electrical Load Profile',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _LoadProfileCard(
                title: 'Light Load (Residential)',
                description:
                    '5-10 amps per circuit\nIdeal for bedroom or office',
                icon: Icons.lightbulb_outline,
                isSelected: _selectedLoadIndex == 0,
                onTap: () => setState(() => _selectedLoadIndex = 0),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _LoadProfileCard(
                title: 'Medium Load (Standard)',
                description:
                    '10-20 amps per circuit\nSuitable for kitchen or living room',
                icon: Icons.power_outlined,
                isSelected: _selectedLoadIndex == 1,
                onTap: () => setState(() => _selectedLoadIndex = 1),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _LoadProfileCard(
                title: 'Heavy Load (High Demand)',
                description:
                    '20+ amps per circuit\nFor appliances and intensive use',
                icon: Icons.electric_bolt,
                isSelected: _selectedLoadIndex == 2,
                onTap: () => setState(() => _selectedLoadIndex = 2),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Features section
              Text(
                'What You\'ll Design',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              _FeatureItem(
                icon: Icons.cable,
                title: 'Wire Routing',
                description: 'Plan cable runs and junction points',
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _FeatureItem(
                icon: Icons.power_outlined,
                title: 'Outlets & Sockets',
                description: 'Place electrical outlets on walls',
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _FeatureItem(
                icon: Icons.light_mode_outlined,
                title: 'Switches & Lights',
                description: 'Add lighting and switch locations',
              ),
              const SizedBox(height: DesignTokens.spacing12),
              _FeatureItem(
                icon: Icons.plumbing,
                title: 'Plumbing (Optional)',
                description: 'Plan hot/cold water pipe layout',
              ),
              const SizedBox(height: DesignTokens.spacing40),

              // Action buttons
              ElevatedButton(
                onPressed: () => context.go('/electrical/d2'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  child: Text('Start Wire Routing'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              OutlinedButton.icon(
                onPressed: () => context.go('/design/b4'),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Design Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadProfileCard extends StatelessWidget {
  const _LoadProfileCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? DesignTokens.primaryBlue : DesignTokens.border,
            width: isSelected ? 2.5 : 1.5,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          color: isSelected
              ? DesignTokens.primaryBlue.withValues(alpha: 0.05)
              : DesignTokens.surface,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? DesignTokens.primaryBlue
                  : DesignTokens.textSecondary,
            ),
            const SizedBox(width: DesignTokens.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: DesignTokens.subtitle2.copyWith(
                      color: isSelected
                          ? DesignTokens.primaryBlue
                          : DesignTokens.text,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing4),
                  Text(
                    description,
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: DesignTokens.primaryBlue,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(DesignTokens.spacing8),
          decoration: BoxDecoration(
            color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          ),
          child: Icon(icon, size: 24, color: DesignTokens.primaryBlue),
        ),
        const SizedBox(width: DesignTokens.spacing16),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
