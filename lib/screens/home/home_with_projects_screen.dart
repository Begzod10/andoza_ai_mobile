import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/apartment_provider.dart';
import '../../widgets/design/stage_progress_line.dart';
import 'home_empty_screen.dart';

/// Home Screen with Projects (A2)
/// Shows list of existing projects with options to view/edit
class HomeWithProjectsScreen extends ConsumerWidget {
  const HomeWithProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(projectsProvider).when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _HomeErrorState(
        onRetry: () => ref.invalidate(apartmentsProvider),
      ),
      data: (projects) {
        if (projects.isEmpty) {
          return const HomeEmptyBody();
        }

        final activeProject = projects.first;
        final otherProjects = projects.skip(1).toList();

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
      },
    );
  }

  void _openAllProjects(BuildContext context) {
    context.push('/profile/e5');
  }
}

/// Shown when the backend project list fails to load. [onRetry] should
/// invalidate [apartmentsProvider] to trigger a refetch.
class _HomeErrorState extends StatelessWidget {
  const _HomeErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off_outlined,
                size: DesignTokens.iconXl,
                color: DesignTokens.textGray,
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              Text(
                'Loyihalarni yuklab bo\'lmadi',
                style: DesignTokens.subtitle1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                'Internet aloqasini tekshiring va qayta urinib ko\'ring',
                style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Qayta urinish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveProjectCard extends ConsumerWidget {
  const _ActiveProjectCard({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          // Tapping the stage/progress area opens the stage picker sheet so
          // the user can set which renovation stage this project is at.
          InkWell(
            onTap: () => _showStagePicker(context, ref, project),
            borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DesignTokens.spacingXs,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: StageProgressLine(
                      currentStep: currentIndex,
                      totalSteps: RenovationStage.values.length,
                      stageStates: stageStates,
                      stageLabel: stageLabel,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  const Icon(
                    Icons.edit_outlined,
                    size: DesignTokens.iconSm,
                    color: DesignTokens.primaryBlue,
                  ),
                ],
              ),
            ),
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
              // Per the button-wiring table: an already-assessed project's
              // "Davom etish" jumps straight into the 3D studio (B2), not
              // back to B1's room-condition question (that's only for a
              // brand-new project finishing A9 for the first time).
              onPressed: () => context.go('/design/b2'),
              child: const Text('Davom etish'),
            ),
          ),
        ],
      ),
    );
  }

}

/// Human-readable name for a [RenovationStage], shared by the active-project
/// card and the stage-picker sheet.
String _stageLabel(RenovationStage stage) => switch (stage) {
  RenovationStage.suvoq => 'suvoq',
  RenovationStage.shpaklovka => 'shpaklovka',
  RenovationStage.boyoqOboi => 'bo\'yoq/oboi',
  RenovationStage.pol => 'pol',
  RenovationStage.mebel => 'mebel',
  RenovationStage.elektr => 'elektr',
  RenovationStage.yoruglik => 'yorug\'lik',
  RenovationStage.santexnika => 'santexnika',
};

/// Opens the "Bosqichni tanlang" bottom sheet for [project], letting the user
/// set its renovation stage. On select it PATCHes the apartment and
/// invalidates [apartmentsProvider] so Home/E4/E5 refetch.
Future<void> _showStagePicker(
  BuildContext context,
  WidgetRef ref,
  ProjectItem project,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x801E2439),
    builder: (_) => _StagePickerSheet(project: project),
  );
}

/// Bottom sheet listing all 8 renovation stages with the current one
/// highlighted. Selecting one persists it via the apartment repository.
class _StagePickerSheet extends ConsumerWidget {
  const _StagePickerSheet({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStage = project.renovationStage;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.screenPaddingHorizontal,
        DesignTokens.spacingMd,
        DesignTokens.screenPaddingHorizontal,
        DesignTokens.spacingXl,
      ),
      decoration: const BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusSheet),
          topRight: Radius.circular(DesignTokens.radiusSheet),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              margin: const EdgeInsets.only(bottom: DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: DesignTokens.borderGray,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
            ),
          ),
          Text('Bosqichni tanlang', style: DesignTokens.heading3),
          const SizedBox(height: DesignTokens.spacingLg),
          for (final stage in RenovationStage.values) ...[
            _StageOption(
              index: stage.index + 1,
              label: _stageLabel(stage),
              selected: stage == currentStage,
              onTap: () => _selectStage(context, ref, stage),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
          ],
        ],
      ),
    );
  }

  Future<void> _selectStage(
    BuildContext context,
    WidgetRef ref,
    RenovationStage stage,
  ) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(apartmentRepositoryProvider)
          .updateApartment(project.id, renovationStage: stage.index + 1);
      ref.invalidate(apartmentsProvider);
      navigator.pop();
    } catch (_) {
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('Bosqichni saqlab bo\'lmadi')),
      );
    }
  }
}

class _StageOption extends StatelessWidget {
  const _StageOption({
    required this.index,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEEF2FF) : const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
          border: Border.all(
            color: selected
                ? DesignTokens.primaryBlue
                : const Color(0xFFEDEFF3),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? DesignTokens.primaryBlue
                    : DesignTokens.borderGrayAlt,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Text(
                '$index',
                style: DesignTokens.subtitle2.copyWith(
                  color: selected ? DesignTokens.white : DesignTokens.textGray,
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(
              child: Text(
                'Bosqich $index/8 · $label',
                style: DesignTokens.subtitle2,
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: DesignTokens.primaryBlue,
                size: DesignTokens.iconSm,
              ),
          ],
        ),
      ),
    );
  }
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
