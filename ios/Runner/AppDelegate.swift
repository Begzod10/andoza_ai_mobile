import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    // Native RoomPlan scan channel (andoza/roomscan). Attached to the implicit
    // engine's messenger — this template has no window.rootViewController
    // FlutterViewController at launch to hang it off of.
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "RoomScanPlugin") {
      RoomScanPlugin.register(messenger: registrar.messenger())
    }
  }
}
