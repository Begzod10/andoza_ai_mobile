import 'dart:math' as math;
import 'dart:ui';
import 'package:riverpod/riverpod.dart';
import '../models/electrical_model.dart';

/// Local-only electrical layout state for the active room (Batch D) — no
/// backend endpoint exists for this yet, same rationale as
/// design_provider.dart/room_provider.dart's local setters.
class ElectricalLayoutNotifier extends StateNotifier<ElectricalLayout?> {
  ElectricalLayoutNotifier() : super(null);

  void startForRoom(String roomId) {
    state = ElectricalLayout(id: '${roomId}_electrical', roomId: roomId);
  }

  /// Places the electrical box — must happen before any other device can
  /// be added, per spec's D1 rule ("Avval elektr qutisini joylashtiring").
  void placeBox(Offset position, String wallId) {
    if (state == null) return;
    addDevice(
      ElectricalDevice(
        id: 'box',
        type: DeviceType.breaker,
        position: position,
        wallId: wallId,
      ),
    );
  }

  bool get hasBox =>
      state?.devices.any((d) => d.type == DeviceType.breaker) ?? false;

  void addDevice(ElectricalDevice device) {
    if (state == null) return;
    state = state!.copyWith(devices: [...state!.devices, device]);
  }

  void updateDevice(ElectricalDevice device) {
    if (state == null) return;
    final index = state!.devices.indexWhere((d) => d.id == device.id);
    if (index == -1) return;
    state = state!.copyWith(
      devices: [
        ...state!.devices.sublist(0, index),
        device,
        ...state!.devices.sublist(index + 1),
      ],
    );
  }

  void removeDevice(String id) {
    if (state == null) return;
    state = state!.copyWith(
      devices: state!.devices.where((d) => d.id != id).toList(),
    );
  }

  void addPipe(PipeSegment pipe) {
    if (state == null) return;
    state = state!.copyWith(pipes: [...state!.pipes, pipe]);
  }

  /// Recomputes every wire as a direct run from the electrical box to each
  /// non-box device — a real computed graph, not decorative, per spec's
  /// D8/D9 requirement.
  void recomputeWires() {
    if (state == null) return;
    final box = state!.devices
        .where((d) => d.type == DeviceType.breaker)
        .firstOrNull;
    if (box == null) {
      state = state!.copyWith(wires: const []);
      return;
    }

    final wires = <WireSegment>[
      for (final device in state!.devices)
        if (device.id != box.id)
          WireSegment(
            id: 'wire_${device.id}',
            from: box.position,
            to: device.position,
            gauge: device.type == DeviceType.outlet ? 25 : 15,
          ),
    ];
    state = state!.copyWith(wires: wires);
  }
}

final electricalLayoutProvider =
    StateNotifierProvider<ElectricalLayoutNotifier, ElectricalLayout?>(
      (ref) => ElectricalLayoutNotifier(),
    );

/// Total wire length in meters, computed from the actual wire graph's
/// endpoint distances (canvas units treated as centimeters, matching
/// [ElectricalDevice.heightCm]'s unit — converted to meters here).
double computeTotalWireLengthMeters(ElectricalLayout layout) {
  return layout.wires.fold<double>(0, (sum, wire) {
    final dx = wire.to.dx - wire.from.dx;
    final dy = wire.to.dy - wire.from.dy;
    return sum + math.sqrt(dx * dx + dy * dy) / 100;
  });
}

double computeWireLengthMetersFor(ElectricalLayout layout, DeviceType type) {
  final deviceIds = layout.devices
      .where((d) => d.type == type)
      .map((d) => d.id)
      .toSet();
  return layout.wires
      .where((w) => deviceIds.any((id) => w.id == 'wire_$id'))
      .fold<double>(0, (sum, wire) {
        final dx = wire.to.dx - wire.from.dx;
        final dy = wire.to.dy - wire.from.dy;
        return sum + math.sqrt(dx * dx + dy * dy) / 100;
      });
}
