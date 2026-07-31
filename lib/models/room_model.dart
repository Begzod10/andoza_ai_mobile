import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

/// Identifies which wall of a captured room a [Wall] record represents.
enum WallType {
  @JsonValue('WALL_A')
  wallA,
  @JsonValue('WALL_B')
  wallB,
  @JsonValue('WALL_C')
  wallC,
  @JsonValue('WALL_D')
  wallD,
}

/// Shared opening type for both [Door] and [Window] fixtures.
enum OpeningType {
  @JsonValue('SINGLE')
  single,
  @JsonValue('DOUBLE')
  dual,
  @JsonValue('SLIDING')
  sliding,
}

/// Overall footprint of a captured room: width, height and length.
@freezed
class RoomDimensions with _$RoomDimensions {
  const factory RoomDimensions({
    required double width,
    required double height,
    required double length,
  }) = _RoomDimensions;

  factory RoomDimensions.fromJson(Map<String, dynamic> json) =>
      _$RoomDimensionsFromJson(json);
}

/// Height and length captured for a single [Wall].
@freezed
class WallMeasurements with _$WallMeasurements {
  const factory WallMeasurements({
    required double height,
    required double length,
  }) = _WallMeasurements;

  factory WallMeasurements.fromJson(Map<String, dynamic> json) =>
      _$WallMeasurementsFromJson(json);
}

/// A single scanned wall belonging to a [Room].
@freezed
class Wall with _$Wall {
  const factory Wall({
    required String id,
    required WallType type,
    required WallMeasurements measurements,
    String? texture,
  }) = _Wall;

  factory Wall.fromJson(Map<String, dynamic> json) => _$WallFromJson(json);
}

/// A door opening located on a wall, positioned as a fraction of the
/// wall's length via [position] (expected range: 0.0-1.0).
@freezed
class Door with _$Door {
  const factory Door({
    required String id,
    required String wallId,
    required double position,
    required double width,
    required double height,
    required OpeningType type,
  }) = _Door;

  factory Door.fromJson(Map<String, dynamic> json) => _$DoorFromJson(json);
}

/// A window opening located on a wall, positioned as a fraction of the
/// wall's length via [position] (expected range: 0.0-1.0).
@freezed
class Window with _$Window {
  const factory Window({
    required String id,
    required String wallId,
    required double position,
    required double width,
    required double height,
    required OpeningType type,
  }) = _Window;

  factory Window.fromJson(Map<String, dynamic> json) => _$WindowFromJson(json);
}

/// A fully captured room, including its walls and any doors/windows
/// attached to those walls.
@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String name,
    required RoomDimensions dimensions,
    @Default(<Wall>[]) List<Wall> walls,
    @Default(<Door>[]) List<Door> doors,
    @Default(<Window>[]) List<Window> windows,
    required DateTime createdAt,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
