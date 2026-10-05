import 'design_selection_model.dart';

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

  /// Thumbnail of [studioRoomId]'s 3D Studio scene, captured client-side and
  /// uploaded by the Studio (web or app). Null when the room has never been
  /// opened in the Studio yet, or has no room at all — callers fall back to
  /// the stylized placeholder illustration.
  final String? thumbnailUrl;

  /// [studioRoomId]'s floor area in m², server-computed. Null when there's no
  /// room yet, or the room hasn't been captured/measured.
  final double? floorArea;

  /// Count of items in [studioRoomId]'s furniture layout — an approximation
  /// of "how many 3D models are placed", not a verified 1:1 model count (the
  /// backend's `furniture_layout` is an opaque JSON blob). Null when there's
  /// no room yet.
  final int? furnitureCount;

  ProjectItem({
    required this.id,
    required this.name,
    required this.location,
    required this.roomCount,
    required this.createdAt,
    this.roomCondition,
    this.renovationStage = RenovationStage.suvoq,
    this.studioRoomId,
    this.thumbnailUrl,
    this.floorArea,
    this.furnitureCount,
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
