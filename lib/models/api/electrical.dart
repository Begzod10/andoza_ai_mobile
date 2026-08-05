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
}

/// A placed electrical device (`DeviceOut`). [wallIndex] is 0–3 (A–D),
/// [x]/[y] are positions along/up the wall, [count] groups identical devices.
@freezed
class ElectricalDeviceOut with _$ElectricalDeviceOut {
  const factory ElectricalDeviceOut({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
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
class ElectricalDeviceCreate with _$ElectricalDeviceCreate {
  const factory ElectricalDeviceCreate({
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
class ElectricalPlan with _$ElectricalPlan {
  const factory ElectricalPlan({
    @JsonKey(name: 'room_id') required String roomId,
    @Default(<ElectricalDeviceOut>[]) List<ElectricalDeviceOut> devices,
    @JsonKey(name: 'wiring_meters') double? wiringMeters,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ElectricalPlan;

  factory ElectricalPlan.fromJson(Map<String, dynamic> json) =>
      _$ElectricalPlanFromJson(json);
}
