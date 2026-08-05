class AppConfig {
  // API Configuration
  // Note: Android emulator uses 10.0.2.2 to refer to host's localhost
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://10.0.2.2:8000/api/v1',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  /// Origin of the web "Studio" (React/Three.js) that the app embeds in a
  /// WebView for 3D room editing. Default targets the emulator host loopback;
  /// override with `--dart-define=STUDIO_BASE_URL=http://<lan-ip>:5173` for a
  /// physical device. The frontend must be served with a VITE_API_URL that is
  /// reachable from the device (see plans/studio-port-plan.md, Phase 7A).
  static const String studioBaseUrl = String.fromEnvironment(
    'STUDIO_BASE_URL',
    defaultValue: 'http://10.0.2.2:5173',
  );

  // LiDAR Configuration
  static const bool lidarEnabled =
      String.fromEnvironment('LIDAR_ENABLED', defaultValue: 'true') == 'true';

  // Debug Configuration
  static const bool debugLogging =
      String.fromEnvironment('DEBUG_LOGGING', defaultValue: 'true') == 'true';

  // App Configuration
  static const String appName = 'Andoza AI Mobile';
  static const String appVersion = '0.1.0';
}
