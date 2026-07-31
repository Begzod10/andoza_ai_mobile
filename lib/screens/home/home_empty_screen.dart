import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

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

  ProjectItem({
    required this.id,
    required this.name,
    required this.location,
    required this.roomCount,
    required this.createdAt,
  });
}

/// Home Screen Empty State (A1)
/// Initial screen when user has no projects
class HomeEmptyScreen extends ConsumerWidget {
  const HomeEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: const HomeEmptyBody(),
    );
  }
}

/// Empty-state body content, shared between the standalone [HomeEmptyScreen]
/// route and [HomeWithProjectsScreen] (which supplies its own AppBar/nav).
class HomeEmptyBody extends StatelessWidget {
  const HomeEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingLg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Empty State Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: DesignTokens.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
                ),
                child: Center(
                  child: Icon(
                    Icons.layers_outlined,
                    size: DesignTokens.iconXxl,
                    color: DesignTokens.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              // Title
              Text(
                'No Projects Yet',
                style: DesignTokens.heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              // Description
              Text(
                'Start scanning your rooms with 3D LiDAR and 360° photos. Create your first project to begin.',
                style: DesignTokens.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacingXxl),
              // CTA Button
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/setup/room-selection');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignTokens.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: DesignTokens.iconMd,
                        color: DesignTokens.white,
                      ),
                      const SizedBox(width: DesignTokens.spacingMd),
                      Text('Create New Project', style: DesignTokens.button),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              // Secondary CTA
              TextButton(
                onPressed: () {
                  // Handle import project
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open_outlined,
                      size: DesignTokens.iconMd,
                      color: DesignTokens.primaryBlue,
                    ),
                    const SizedBox(width: DesignTokens.spacingSm),
                    Text(
                      'Import Existing Project',
                      style: DesignTokens.body1.copyWith(
                        color: DesignTokens.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
