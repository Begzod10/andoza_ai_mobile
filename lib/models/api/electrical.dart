import 'package:freezed_annotation/freezed_annotation.dart';

part 'electrical.freezed.dart';
part 'electrical.g.dart';

/// Electrical device type (`app/schemas/electrical.py::DeviceType`).
enum ElectricalDeviceType {
  @JsonValue('socket')
  socket,
  @JsonValue('switch')
  switch_,
  @JsonValue('light')
  light,
  @JsonValue('panel')
  panel,
  @JsonValue('box')
  box,

  /// Fallback for any device type the backend adds that this client predates.
  /// Deserialization maps unknown strings here instead of throwing.
  unknown,
}

/// A placed electrical device (`DeviceOut`). [wallIndex] is the 0-based index
/// of the wall in polygon order — 0..n-1, not just 0-3: a scanned or drawn room
/// has N walls (see migration 1786000003, which widened the CHECK constraint).
/// [x]/[y] are positions along/up the wall, [count] groups identical devices.
@freezed
abstract class ElectricalDeviceOut with _$ElectricalDeviceOut {
  const factory ElectricalDeviceOut({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)
    required ElectricalDeviceType type,
    String? variant,
    @JsonKey(name: 'wall_index') required int wallIndex,
    required double x,
    required double y,
    @Default(1) int count,
  }) = _ElectricalDeviceOut;

  factory ElectricalDeviceOut.fromJson(Map<String, dynamic> json) =>
      _$ElectricalDeviceOutFromJson(json);
}

/// A device in a plan-replace request (`DeviceCreate`).
@freezed
abstract class ElectricalDeviceCreate with _$ElectricalDeviceCreate {
  const factory ElectricalDeviceCreate({
    @JsonKey(unknownEnumValue: ElectricalDeviceType.unknown)
    required ElectricalDeviceType type,
    String? variant,
    @JsonKey(name: 'wall_index') required int wallIndex,
    required double x,
    required double y,
    @Default(1) int count,
  }) = _ElectricalDeviceCreate;

  factory ElectricalDeviceCreate.fromJson(Map<String, dynamic> json) =>
      _$ElectricalDeviceCreateFromJson(json);
}

/// The full electrical plan for a room (`GET/PUT /rooms/{id}/electrical`).
@freezed
abstract class ElectricalPlan with _$ElectricalPlan {
  const factory ElectricalPlan({
    @JsonKey(name: 'room_id') required String roomId,
    @Default(<ElectricalDeviceOut>[]) List<ElectricalDeviceOut> devices,
    @JsonKey(name: 'wiring_meters') double? wiringMeters,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ElectricalPlan;

  factory ElectricalPlan.fromJson(Map<String, dynamic> json) =>
      _$ElectricalPlanFromJson(json);
}
