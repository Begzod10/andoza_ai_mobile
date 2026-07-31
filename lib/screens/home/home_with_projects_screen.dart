import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../widgets/design/stage_progress_line.dart';
import 'home_empty_screen.dart';

/// Home Screen with Projects (A2)
/// Shows list of existing projects with options to view/edit
class HomeWithProjectsScreen extends ConsumerWidget {
  const HomeWithProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);

    if (homeState.projects.isEmpty) {
      return const HomeEmptyBody();
    }

    final activeProject = homeState.projects.first;
    final otherProjects = homeState.projects.skip(1).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.screenPaddingHorizontal,
          vertical: DesignTokens.spacingLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeGreetingHeader(),
            const SizedBox(height: DesignTokens.spacingLg),
            _ActiveProjectCard(project: activeProject),
            const SizedBox(height: DesignTokens.spacingXl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Loyihalaringiz', style: DesignTokens.subtitle1),
                GestureDetector(
                  onTap: () => _openAllProjects(context),
                  child: Text(
                    'Barchasi',
                    style: DesignTokens.body2.copyWith(
                      color: DesignTokens.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            for (final project in otherProjects) ...[
              _ProjectListRow(project: project),
              const SizedBox(height: DesignTokens.spacingSm),
            ],
          ],
        ),
      ),
    );
  }

  void _openAllProjects(BuildContext context) {
    // TODO: E5 "Loyihalarim" (also A2's "Barchasi" destination) is built
    // in Step 11 of plans/andozaai-design-rebuild.md.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Barcha loyihalar tez orada')));
  }
}

class _ActiveProjectCard extends StatelessWidget {
  const _ActiveProjectCard({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final stageStates = project.stageStates;
    final currentIndex = project.renovationStage.index;
    final excludedNames = [
      for (final stage in RenovationStage.values)
        if (stageStates[stage.index] == StageDisplayState.excluded)
          _stageLabel(stage),
    ];
    final stageLabel = excludedNames.isEmpty
        ? 'Bosqich ${currentIndex + 1}/8'
        : 'Bosqich ${currentIndex + 1}/8 · ✓ ${excludedNames.join(' va ')} mavjud edi';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEEF2FF), Color(0xFFF4F6FB), Color(0xFFF3F4F6)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE7ECFA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: DesignTokens.borderGrayAlt,
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
            ),
            child: const Center(
              child: Icon(
                Icons.view_in_ar_outlined,
                size: DesignTokens.iconXxl,
                color: DesignTokens.primaryBlue,
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Text(project.name, style: DesignTokens.subtitle1),
          const SizedBox(height: DesignTokens.spacingMd),
          StageProgressLine(
            currentStep: currentIndex,
            totalSteps: RenovationStage.values.length,
            stageStates: stageStates,
            stageLabel: stageLabel,
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Row(
            children: [
              _LegendDot(color: DesignTokens.existingStateGray),
              const SizedBox(width: DesignTokens.spacingXs),
              Text(
                'Mavjud (hisoblanmaydi)',
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              _LegendDot(color: DesignTokens.delta.inProgress),
              const SizedBox(width: DesignTokens.spacingXs),
              Text(
                'Kerak (delta)',
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/design/b1'),
              child: const Text('Davom etish'),
            ),
          ),
        ],
      ),
    );
  }

  static String _stageLabel(RenovationStage stage) => switch (stage) {
    RenovationStage.suvoq => 'suvoq',
    RenovationStage.shpaklovka => 'shpaklovka',
    RenovationStage.boyoqOboi => 'bo\'yoq/oboi',
    RenovationStage.pol => 'pol',
    RenovationStage.mebel => 'mebel',
    RenovationStage.elektr => 'elektr',
    RenovationStage.yoruglik => 'yorug\'lik',
    RenovationStage.santexnika => 'santexnika',
  };
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _ProjectListRow extends StatelessWidget {
  const _ProjectListRow({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final stageStates = project.stageStates;
    final currentIndex = project.renovationStage.index;
    final excludedCount = stageStates
        .where((s) => s == StageDisplayState.excluded)
        .length;

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.name, style: DesignTokens.subtitle2),
          const SizedBox(height: DesignTokens.spacingSm),
          StageProgressLine(
            currentStep: currentIndex,
            totalSteps: RenovationStage.values.length,
            stageStates: stageStates,
            stageLabel: excludedCount == 0
                ? 'Bosqich ${currentIndex + 1}/8'
                : 'Bosqich ${currentIndex + 1}/8 · ✓ $excludedCount bosqich mavjud edi',
          ),
        ],
      ),
    );
  }
}
