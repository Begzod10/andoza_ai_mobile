import 'package:riverpod/riverpod.dart';

enum MeasurementMethod { camera, manual }

class Measurement {
  const Measurement({
    this.id,
    required this.roomName,
    required this.width,
    required this.length,
    required this.height,
    this.furniture = const [],
    this.photos = const [],
    this.createdAt,
  });

  final String? id;
  final String? roomName;
  final double? width;
  final double? length;
  final double? height;
  final List<String> furniture;
  final List<String> photos;
  final DateTime? createdAt;

  factory Measurement.empty() => const Measurement(
        roomName: null,
        width: null,
        length: null,
        height: null,
      );

  double? get area => width != null && length != null ? width! * length! : null;
  double? get volume =>
      width != null && length != null && height != null
          ? width! * length! * height!
          : null;

  Measurement copyWith({
    String? id,
    String? roomName,
    double? width,
    double? length,
    double? height,
    List<String>? furniture,
    List<String>? photos,
    DateTime? createdAt,
  }) {
    return Measurement(
      id: id ?? this.id,
      roomName: roomName ?? this.roomName,
      width: width ?? this.width,
      length: length ?? this.length,
      height: height ?? this.height,
      furniture: furniture ?? this.furniture,
      photos: photos ?? this.photos,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// Measurement notifier - manages measurement state
class MeasurementNotifier extends StateNotifier<Measurement> {
  MeasurementNotifier() : super(Measurement.empty());

  void setRoomName(String name) {
    state = state.copyWith(roomName: name);
  }

  void setDimensions(double width, double length, double height) {
    state = state.copyWith(width: width, length: length, height: height);
  }

  void setWidth(double width) {
    state = state.copyWith(width: width);
  }

  void setLength(double length) {
    state = state.copyWith(length: length);
  }

  void setHeight(double height) {
    state = state.copyWith(height: height);
  }

  void addFurniture(String furnitureId) {
    state = state.copyWith(furniture: [...state.furniture, furnitureId]);
  }

  void removeFurniture(String furnitureId) {
    state = state.copyWith(
      furniture: state.furniture.where((f) => f != furnitureId).toList(),
    );
  }

  void addPhoto(String photoPath) {
    state = state.copyWith(photos: [...state.photos, photoPath]);
  }

  void reset() {
    state = Measurement.empty();
  }
}

// Provider for measurement state
final measurementProvider =
    StateNotifierProvider<MeasurementNotifier, Measurement>((ref) {
  return MeasurementNotifier();
});

// Computed: Check if measurement is complete
final measurementCompleteProvider = Provider<bool>((ref) {
  final measurement = ref.watch(measurementProvider);
  return measurement.roomName != null &&
      measurement.width != null &&
      measurement.length != null &&
      measurement.height != null;
});

// Computed: Formatted area
final measurementAreaProvider = Provider<String>((ref) {
  final measurement = ref.watch(measurementProvider);
  final area = measurement.area;
  return area != null ? '${area.toStringAsFixed(2)} m²' : 'N/A';
});

// Computed: Formatted volume
final measurementVolumeProvider = Provider<String>((ref) {
  final measurement = ref.watch(measurementProvider);
  final volume = measurement.volume;
  return volume != null ? '${volume.toStringAsFixed(2)} m³' : 'N/A';
});

// Measurement method selection (camera or manual)
final measurementMethodProvider = StateProvider<MeasurementMethod?>((ref) => null);
