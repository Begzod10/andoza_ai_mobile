import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../models/design_selection_model.dart';
import '../../providers/auth_provider.dart';
import '../room_setup/new_project_sheet.dart';

/// Riverpod provider for home screen state
final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
  (ref) => HomeStateNotifier(),
);

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

  ProjectItem({
    required this.id,
    required this.name,
    required this.location,
    required this.roomCount,
    required this.createdAt,
    this.roomCondition,
    this.renovationStage = RenovationStage.suvoq,
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

/// A1: Bosh sahifa (bo'sh) — first-run home, empty state.
/// Standalone-route wrapper; [HomeEmptyBody] is the actual content, shared
/// with [HomeWithProjectsScreen] which supplies its own AppBar/nav.
class HomeEmptyScreen extends ConsumerWidget {
  const HomeEmptyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: HomeEmptyBody());
  }
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
    return GestureDetector(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xush kelibsiz',
              style: DesignTokens.body2.copyWith(color: DesignTokens.textGray),
            ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text(
              name != null ? 'Salom, $name! 👋' : 'Salom! 👋',
              style: DesignTokens.heading2,
            ),
          ],
        ),
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
                  onTap: () => context.go('/onboarding/e7'),
                ),
                _StoryCircle(
                  icon: Icons.play_circle_outline,
                  label: 'Demo qo\'llanma',
                  seen: true,
                  onTap: () => context.go('/onboarding/e8'),
                ),
                _StoryCircle(
                  icon: Icons.auto_awesome,
                  label: 'Demo',
                  seen: false,
                  onTap: () => context.go('/onboarding/e8'),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingXl),
            // Empty-state card.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: const Color(0xFFFBFCFD),
                borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
                border: Border.all(color: const Color(0xFFD6DAE2), width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: DesignTokens.borderGrayAlt,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusXl,
                      ),
                    ),
                    child: const Icon(
                      Icons.home_outlined,
                      size: DesignTokens.iconXxl,
                      color: DesignTokens.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  Text(
                    'Birinchi xonangizni qo\'shing',
                    style: DesignTokens.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  Text(
                    'Hali loyiha yo\'q — pastdagi + tugmasini bosing',
                    style: DesignTokens.body2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
    return InkWell(
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
    );
  }
}
