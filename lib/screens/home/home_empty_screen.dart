import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/api/apartment.dart';
import '../../models/design_selection_model.dart';
import '../../providers/apartment_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/empty_state_pattern.dart';
import '../room_setup/new_project_sheet.dart';

/// Riverpod provider for home screen state
final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
  (ref) => HomeStateNotifier(),
);

/// The merged project list the UI renders: the user's real backend
/// apartments ([apartmentsProvider]) mapped to [ProjectItem]s, plus any
/// locally-added ([homeStateProvider]) projects not yet present on the
/// server. Dedup is by `id` with the server winning, so an optimistic add
/// disappears cleanly once the refetch returns it.
///
/// Loading/error state is passed straight through from [apartmentsProvider]
/// (via [AsyncValue.whenData]); invalidate [apartmentsProvider] to retry.
final projectsProvider = Provider<AsyncValue<List<ProjectItem>>>((ref) {
  final localProjects = ref.watch(homeStateProvider).projects;
  return ref.watch(apartmentsProvider).whenData((apartments) {
    final serverProjects = apartments.map(_apartmentToProject).toList();
    final serverIds = serverProjects.map((p) => p.id).toSet();
    final localOnly =
        localProjects.where((p) => !serverIds.contains(p.id)).toList();
    return [...serverProjects, ...localOnly];
  });
});

/// Maps a backend [Apartment] to the UI's [ProjectItem]. The backend's
/// `renovation_stage` is a 1-based int (1..8); it maps to the
/// [RenovationStage] enum value at the matching 0-based position, so the
/// card's "Bosqich N/8" mirrors the server exactly. [roomCondition] stays
/// null ("not yet assessed") — the server has no room-condition concept yet.
ProjectItem _apartmentToProject(Apartment a) {
  // Pick the most-recently-edited room to resume in the 3D Studio.
  final rooms = [...a.rooms]
    ..sort((r1, r2) => r2.updatedAt.compareTo(r1.updatedAt));
  return ProjectItem(
    id: a.id,
    name: a.name,
    location: a.address ?? '',
    roomCount: a.rooms.length,
    createdAt: a.createdAt,
    renovationStage: RenovationStage.values[(a.renovationStage - 1).clamp(
      0,
      RenovationStage.values.length - 1,
    )],
    studioRoomId: rooms.isNotEmpty ? rooms.first.id : null,
  );
}

class HomeState {
  final List<ProjectItem> projects;
  final bool isLoading;

  HomeState({required this.projects, this.isLoading = false});

  HomeState copyWith({List<ProjectItem>? projects, bool? isLoading}) {
    return HomeState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(HomeState(projects: []));

  void addProject(ProjectItem project) {
    state = state.copyWith(projects: [...state.projects, project]);
  }

  void removeProject(String id) {
    state = state.copyWith(
      projects: state.projects.where((p) => p.id != id).toList(),
    );
  }
}

class ProjectItem {
  final String id;
  final String name;
  final String location;
  final int roomCount;
  final DateTime createdAt;

  /// Null until Batch B's room-state selection (B1) has run for this
  /// project. Rendering must NOT fabricate a condition — see
  /// [ProjectItem.stageStates] for how the null case is handled.
  final RoomCondition? roomCondition;
  final RenovationStage renovationStage;

  /// The room to open in the 3D Studio when "Davom etish" is tapped — the
  /// apartment's most-recently-edited room. Null for a local/optimistic
  /// project that has no server room yet.
  final String? studioRoomId;

  ProjectItem({
    required this.id,
    required this.name,
    required this.location,
    required this.roomCount,
    required this.createdAt,
    this.roomCondition,
    this.renovationStage = RenovationStage.suvoq,
    this.studioRoomId,
  });

  /// Delta-mechanic display states for this project's progress bar. When
  /// [roomCondition] hasn't been set yet, falls back to a raw/korobka
  /// baseline — the correct semantic default for "not yet assessed" (raw
  /// means nothing is pre-excluded), not a fabricated value.
  List<StageDisplayState> get stageStates => deriveStageStates(
    condition: roomCondition ?? const RoomCondition(wall: SurfaceCondition.raw),
    currentStage: renovationStage,
  );
}

/// One of the three "story circle" onboarding shortcuts on A1 — animated
/// conic-gradient ring (2.5s spin) that greys out once tapped.
class _StoryCircle extends StatefulWidget {
  const _StoryCircle({
    required this.icon,
    required this.label,
    required this.seen,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool seen;
  final VoidCallback onTap;

  @override
  State<_StoryCircle> createState() => _StoryCircleState();
}

class _StoryCircleState extends State<_StoryCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: DesignTokens.animationStoryRing,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: widget.seen
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: DesignTokens.existingStateGray,
                        width: 2.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        widget.icon,
                        color: DesignTokens.textMuted,
                        size: DesignTokens.iconMd,
                      ),
                    ),
                  )
                : AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _ConicRingPainter(_controller.value),
                        child: Center(
                          child: Icon(
                            widget.icon,
                            color: DesignTokens.primaryBlue,
                            size: DesignTokens.iconMd,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: DesignTokens.spacingXs),
          SizedBox(
            width: 72,
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: DesignTokens.caption,
            ),
          ),
        ],
      ),
    ),
    );
  }
}

/// Blue→orange conic-gradient ring, per spec ("animated blue→orange conic
/// rings, 2.5s spin").
class _ConicRingPainter extends CustomPainter {
  _ConicRingPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 6.28319,
        transform: GradientRotation(progress * 6.28319),
        colors: const [
          DesignTokens.primaryBlue,
          DesignTokens.accentOrange,
          DesignTokens.primaryBlue,
        ],
      ).createShader(rect);
    canvas.drawOval(rect.deflate(1.25), paint);
  }

  @override
  bool shouldRepaint(_ConicRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Shared greeting + brand-pill header row, used by both A1 and A2.
class HomeGreetingHeader extends ConsumerWidget {
  const HomeGreetingHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final name = currentUser.maybeWhen(
      data: (user) => user?.firstName ?? user?.name ?? user?.username,
      orElse: () => null,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xush kelibsiz',
                style: DesignTokens.body2.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXs),
              Text(
                name != null ? 'Salom, $name! 👋' : 'Salom! 👋',
                style: DesignTokens.heading2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: DesignTokens.spacingSm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingMd,
            vertical: DesignTokens.spacingXs,
          ),
          decoration: BoxDecoration(
            color: DesignTokens.borderGrayAlt,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: DesignTokens.accentOrange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Text(
                'AndozaAI',
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Empty-state body content (A1), shared between the standalone
/// [HomeEmptyScreen] route and [HomeWithProjectsScreen] (which supplies its
/// own AppBar/nav and swaps this in when the project list is empty).
class HomeEmptyBody extends StatelessWidget {
  const HomeEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
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
            // Three story-circle onboarding shortcuts.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StoryCircle(
                  icon: Icons.help_outline,
                  label: 'Qanday ishlaydi?',
                  seen: false,
                  onTap: () => context.push('/onboarding/e7'),
                ),
                _StoryCircle(
                  icon: Icons.play_circle_outline,
                  label: 'Demo qo\'llanma',
                  seen: true,
                  onTap: () => context.push('/onboarding/e8'),
                ),
                _StoryCircle(
                  icon: Icons.auto_awesome,
                  label: 'Demo',
                  seen: false,
                  onTap: () => context.push('/onboarding/e8'),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingXl),
            EmptyStatePattern(
              icon: Icons.home_outlined,
              title: 'Birinchi xonangizni qo\'shing',
              message: 'Hali loyiha yo\'q — yangi loyiha boshlang',
              actionLabel: '+ Loyiha qo\'shish',
              onAction: () => showNewProjectSheet(context),
            ),
            const SizedBox(height: DesignTokens.spacingXl),
            // Tezkor amallar — 2x2 quick-action grid.
            Text('Tezkor amallar', style: DesignTokens.subtitle1),
            const SizedBox(height: DesignTokens.spacingMd),
            Row(
              children: [
                Expanded(
                  child: _QuickAction(
                    icon: Icons.camera_alt_outlined,
                    label: 'Xonani skanlash',
                    onTap: () => showNewProjectSheet(context),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: _QuickAction(
                    icon: Icons.receipt_long_outlined,
                    label: 'Smeta',
                    onTap: () => context.go('/estimation/e1'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Row(
              children: [
                Expanded(
                  child: _QuickAction(
                    icon: Icons.storefront_outlined,
                    label: 'Dilerlar',
                    onTap: () => context.go('/shop/s1'),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: _QuickAction(
                    icon: Icons.groups_outlined,
                    label: 'Ustalar',
                    onTap: () => context.go('/masters/u1'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
      onTap: onTap,
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: DesignTokens.borderGrayAlt,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Icon(
                icon,
                color: DesignTokens.primaryBlue,
                size: DesignTokens.iconMd,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              label,
              style: DesignTokens.body2.copyWith(
                fontWeight: FontWeight.w600,
                color: DesignTokens.textDark,
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
