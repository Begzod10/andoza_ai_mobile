import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../widgets/design/stage_progress_line.dart';
import '../../widgets/empty_state_pattern.dart';
import '../home/home_empty_screen.dart';
import '../room_setup/new_project_sheet.dart';

enum _ProjectFilter { all, ongoing, finished }

bool _isFinished(ProjectItem p) =>
    p.renovationStage == RenovationStage.santexnika;

/// E5: Loyihalarim — also A2's "Barchasi" destination (there is no
/// separate spec screen for that; this is the single, real
/// destination). Reuses the same [homeStateProvider] list and delta
/// progress bar as A2, so this never shows different data than home
/// does.
class E5ProjectsScreen extends ConsumerStatefulWidget {
  const E5ProjectsScreen({super.key});

  @override
  ConsumerState<E5ProjectsScreen> createState() => _E5ProjectsScreenState();
}

class _E5ProjectsScreenState extends ConsumerState<E5ProjectsScreen> {
  _ProjectFilter _filter = _ProjectFilter.all;

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(projectsProvider).maybeWhen(
      data: (list) => list,
      orElse: () => const <ProjectItem>[],
    );
    final visible = switch (_filter) {
      _ProjectFilter.all => projects,
      _ProjectFilter.ongoing => projects.where((p) => !_isFinished(p)).toList(),
      _ProjectFilter.finished => projects.where(_isFinished).toList(),
    };

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: Text('Loyihalarim', style: DesignTokens.heading3),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showNewProjectSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Yangi loyiha'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.screenPaddingHorizontal,
              vertical: DesignTokens.spacingSm,
            ),
            child: Row(
              children: [
                _FilterChip(
                  label: 'Barchasi',
                  selected: _filter == _ProjectFilter.all,
                  onTap: () => setState(() => _filter = _ProjectFilter.all),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                _FilterChip(
                  label: 'Davom etayotgan',
                  selected: _filter == _ProjectFilter.ongoing,
                  onTap: () => setState(() => _filter = _ProjectFilter.ongoing),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                _FilterChip(
                  label: 'Tugagan',
                  selected: _filter == _ProjectFilter.finished,
                  onTap: () =>
                      setState(() => _filter = _ProjectFilter.finished),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(
                      DesignTokens.screenPaddingHorizontal,
                    ),
                    child: Center(
                      child: EmptyStatePattern(
                        icon: Icons.architecture_outlined,
                        title: 'Hali loyiha yo\'q',
                        message: 'Birinchi loyihangizni boshlang',
                        actionLabel: '+ Yangi loyiha',
                        onAction: () => showNewProjectSheet(context),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(
                      DesignTokens.screenPaddingHorizontal,
                    ),
                    itemCount: visible.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: DesignTokens.spacingMd),
                    itemBuilder: (context, index) =>
                        _ProjectCard(project: visible[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: DesignTokens.white,
      selectedColor: DesignTokens.primaryBlue,
      labelStyle: DesignTokens.caption.copyWith(
        color: selected ? DesignTokens.white : DesignTokens.textDark,
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final stageStates = project.stageStates;
    final currentIndex = project.renovationStage.index;
    final finished = _isFinished(project);
    final excludedCount = stageStates
        .where((s) => s == StageDisplayState.excluded)
        .length;

    return InkWell(
      // Same "continue an already-assessed project → B2" rule as A2's
      // Davom etish button (button-wiring table) — not back to B1.
      onTap: () => context.go('/design/b2'),
      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          color: DesignTokens.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          border: Border.all(color: DesignTokens.borderGray),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: DesignTokens.borderGrayAlt,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: const Center(
                child: Icon(
                  Icons.view_in_ar_outlined,
                  size: DesignTokens.iconXl,
                  color: DesignTokens.primaryBlue,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Row(
              children: [
                Expanded(
                  child: Text(project.name, style: DesignTokens.subtitle2),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingSm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (finished
                                ? DesignTokens.successGreen
                                : DesignTokens.primaryBlue)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: Text(
                    finished ? 'Tugagan' : 'Davom etayotgan',
                    style: DesignTokens.caption.copyWith(
                      color: finished
                          ? DesignTokens.successGreen
                          : DesignTokens.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '${project.roomCount} xona · ${project.location} · '
              '${project.createdAt.day}.${project.createdAt.month}.${project.createdAt.year}',
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.textGray,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            StageProgressLine(
              currentStep: currentIndex,
              totalSteps: RenovationStage.values.length,
              stageStates: stageStates,
              stageLabel: excludedCount == 0
                  ? 'Bosqich ${currentIndex + 1}/8'
                  : 'Bosqich ${currentIndex + 1}/8 · ✓ $excludedCount '
                        'bosqich mavjud edi',
            ),
          ],
        ),
      ),
    );
  }
}
