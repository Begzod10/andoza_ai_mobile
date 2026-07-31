import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters.dart';

part 'electrical_model.freezed.dart';
part 'electrical_model.g.dart';

/// Type of pipe in a plumbing line
enum PipeType {
  @JsonValue('HOT')
  hot,
  @JsonValue('COLD')
  cold,
}

/// Color temperature for lighting fixtures
enum ColorTemp {
  @JsonValue('WARM')
  warm,
  @JsonValue('NEUTRAL')
  neutral,
  @JsonValue('COLD')
  cold,
  @JsonValue('RGB')
  rgb,
}

/// Type of electrical device placed within a room's electrical layout.
enum DeviceType {
  @JsonValue('OUTLET')
  outlet,
  @JsonValue('SWITCH')
  lightSwitch,
  @JsonValue('LIGHT')
  light,
  @JsonValue('BREAKER')
  breaker,
}

/// A single electrical device (outlet, switch, light or breaker) placed
/// on a wall at a given canvas [position].
@freezed
class ElectricalDevice with _$ElectricalDevice {
  const factory ElectricalDevice({
    required String id,
    required DeviceType type,
    @OffsetConverter() required Offset position,
    required String wallId,
    double? amps,
    @Default(100) double heightCm,
    @Default(1) int gangCount,
    String? colorOption,
    ColorTemp? colorTemp,
  }) = _ElectricalDevice;

  factory ElectricalDevice.fromJson(Map<String, dynamic> json) =>
      _$ElectricalDeviceFromJson(json);
}

/// A single wire run between two points on the electrical layout canvas.
@freezed
class WireSegment with _$WireSegment {
  const factory WireSegment({
    required String id,
    @OffsetConverter() required Offset from,
    @OffsetConverter() required Offset to,
    required int gauge,
  }) = _WireSegment;

  factory WireSegment.fromJson(Map<String, dynamic> json) =>
      _$WireSegmentFromJson(json);
}

/// A single pipe segment in a plumbing line (hot/cold water or drain).
@freezed
class PipeSegment with _$PipeSegment {
  const factory PipeSegment({
    required String id,
    @OffsetConverter() required Offset from,
    @OffsetConverter() required Offset to,
    required PipeType type,
  }) = _PipeSegment;

  factory PipeSegment.fromJson(Map<String, dynamic> json) =>
      _$PipeSegmentFromJson(json);
}

/// A junction box connecting one or more [WireSegment]s at a point on
/// the electrical layout canvas.
@freezed
class JunctionBox with _$JunctionBox {
  const factory JunctionBox({
    required String id,
    @OffsetConverter() required Offset position,
    required int capacity,
    required int connections,
  }) = _JunctionBox;

  factory JunctionBox.fromJson(Map<String, dynamic> json) =>
      _$JunctionBoxFromJson(json);
}

/// The complete electrical layout designed for a single room: devices,
/// the wiring connecting them, junction boxes, and plumbing.
@freezed
class ElectricalLayout with _$ElectricalLayout {
  const factory ElectricalLayout({
    required String id,
    required String roomId,
    @Default(<ElectricalDevice>[]) List<ElectricalDevice> devices,
    @Default(<WireSegment>[]) List<WireSegment> wires,
    @Default(<JunctionBox>[]) List<JunctionBox> junctionBoxes,
    @Default(<PipeSegment>[]) List<PipeSegment> pipes,
  }) = _ElectricalLayout;

  factory ElectricalLayout.fromJson(Map<String, dynamic> json) =>
      _$ElectricalLayoutFromJson(json);
}
