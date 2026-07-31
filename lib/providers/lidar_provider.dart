import 'package:riverpod/riverpod.dart';
import '../services/lidar_service.dart';

// LiDAR Service provider
final lidarServiceProvider = Provider<LidarService>((ref) {
  return LidarService();
});

// Check if LiDAR is available
final lidarAvailableProvider = FutureProvider<bool>((ref) async {
  final lidarService = ref.watch(lidarServiceProvider);
  return lidarService.isLidarAvailable();
});

// LiDAR scanning state
enum LidarScanState { idle, scanning, processing, complete, error }

class LidarScanNotifier extends StateNotifier<LidarScanState> {
  LidarScanNotifier(this._lidarService) : super(LidarScanState.idle);

  final LidarService _lidarService;
  LidarScan? _lastScan;
  String? _error;

  LidarScan? get lastScan => _lastScan;
  String? get error => _error;

  Future<void> startScan() async {
    state = LidarScanState.scanning;
    try {
      await _lidarService.startScan();
    } catch (e) {
      _error = e.toString();
      state = LidarScanState.error;
    }
  }

  Future<void> stopScan() async {
    state = LidarScanState.processing;
    try {
      await _lidarService.stopScan();
      _lastScan = await _lidarService.getScanData();
      state = LidarScanState.complete;
    } catch (e) {
      _error = e.toString();
      state = LidarScanState.error;
    }
  }

  Future<Map<String, double>?> getMeasurements() async {
    try {
      return await _lidarService.getMeasurements();
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  void reset() {
    state = LidarScanState.idle;
    _lastScan = null;
    _error = null;
  }
}

// LiDAR scanning state provider
final lidarScanProvider =
    StateNotifierProvider<LidarScanNotifier, LidarScanState>((ref) {
      final lidarService = ref.watch(lidarServiceProvider);
      return LidarScanNotifier(lidarService);
    });
