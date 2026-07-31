import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import 'home_empty_screen.dart';

/// Home Screen with Projects (A2)
/// Shows list of existing projects with options to view/edit
class HomeWithProjectsScreen extends ConsumerWidget {
  const HomeWithProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.backgroundLight,
        title: Text(
          'AndozaAI',
          style: DesignTokens.heading3.copyWith(
            color: DesignTokens.primaryBlue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: DesignTokens.spacingMd),
            child: Center(
              child: CircleAvatar(
                radius: 20,
                backgroundColor: DesignTokens.accentOrange,
                child: Text(
                  'U',
                  style: DesignTokens.subtitle1.copyWith(
                    color: DesignTokens.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: homeState.projects.isEmpty
          ? const HomeEmptyBody()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingSm,
                      vertical: DesignTokens.spacingMd,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Projects', style: DesignTokens.heading2),
                        const SizedBox(height: DesignTokens.spacingSm),
                        Text(
                          '${homeState.projects.length} active project${homeState.projects.length > 1 ? 's' : ''}',
                          style: DesignTokens.body2.copyWith(
                            color: DesignTokens.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  // Projects List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeState.projects.length,
                    itemBuilder: (context, index) {
                      final project = homeState.projects[index];
                      return _ProjectCard(
                        project: project,
                        onTap: () => _openProjectDetail(context, project.id),
                        onDelete: () {
                          ref
                              .read(homeStateProvider.notifier)
                              .removeProject(project.id);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: DesignTokens.spacingLg),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/setup/room-selection'),
        backgroundColor: DesignTokens.primaryBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openProjectDetail(BuildContext context, String projectId) {
    // TODO: no project-detail route/screen exists yet.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project details coming soon')),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ProjectCard({
    required this.project,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: DesignTokens.white,
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              border: Border.all(
                color: _isHovering
                    ? DesignTokens.primaryBlue.withOpacity(0.3)
                    : DesignTokens.borderGray,
                width: 1,
              ),
              boxShadow: _isHovering
                  ? [DesignTokens.shadowMd]
                  : [DesignTokens.shadowSm],
            ),
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.project.name,
                              style: DesignTokens.subtitle1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: DesignTokens.spacingSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: DesignTokens.iconSm,
                                  color: DesignTokens.textGray,
                                ),
                                const SizedBox(width: DesignTokens.spacingSm),
                                Expanded(
                                  child: Text(
                                    widget.project.location,
                                    style: DesignTokens.body2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // More menu
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Row(
                              children: [
                                Icon(Icons.edit_outlined, size: 18),
                                SizedBox(width: DesignTokens.spacingSm),
                                Text('Edit'),
                              ],
                            ),
                            onTap: widget.onTap,
                          ),
                          PopupMenuItem(
                            child: const Row(
                              children: [
                                Icon(Icons.share_outlined, size: 18),
                                SizedBox(width: DesignTokens.spacingSm),
                                Text('Share'),
                              ],
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                  color: DesignTokens.errorRed,
                                ),
                                SizedBox(width: DesignTokens.spacingSm),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: DesignTokens.errorRed,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              _showDeleteDialog(context);
                            },
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                        offset: const Offset(0, 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  // Stats
                  Row(
                    children: [
                      _StatItem(
                        icon: Icons.layers_outlined,
                        label: 'Rooms',
                        value: '${widget.project.roomCount}',
                      ),
                      const SizedBox(width: DesignTokens.spacingLg),
                      _StatItem(
                        icon: Icons.access_time_outlined,
                        label: 'Updated',
                        value: _formatDate(widget.project.createdAt),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  // Progress bar
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: DesignTokens.borderGray,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Container(
                        decoration: BoxDecoration(
                          color: DesignTokens.accentOrange,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  Text(
                    '75% Complete',
                    style: DesignTokens.caption.copyWith(
                      color: DesignTokens.textGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project?'),
        content: Text(
          'Are you sure you want to delete "${widget.project.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete();
            },
            style: TextButton.styleFrom(foregroundColor: DesignTokens.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      return '${(difference.inDays / 30).floor()} months ago';
    }
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: DesignTokens.iconSm, color: DesignTokens.textGray),
            const SizedBox(width: DesignTokens.spacingSm),
            Text(
              label,
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.textGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Text(value, style: DesignTokens.subtitle2),
      ],
    );
  }
}
