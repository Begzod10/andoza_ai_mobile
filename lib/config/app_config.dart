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

  // LiDAR Configuration
  static const bool lidarEnabled = String.fromEnvironment(
    'LIDAR_ENABLED',
    defaultValue: 'true',
  ) == 'true';

  // Debug Configuration
  static const bool debugLogging = String.fromEnvironment(
    'DEBUG_LOGGING',
    defaultValue: 'true',
  ) == 'true';

  // App Configuration
  static const String appName = 'Tamir.Uy Mobile';
  static const String appVersion = '0.1.0';
}
