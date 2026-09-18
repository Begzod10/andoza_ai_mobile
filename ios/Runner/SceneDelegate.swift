import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {

  /// Registers the app's own platform channels once the scene's
  /// FlutterViewController exists.
  ///
  /// The LiDAR channel needs a real view controller (it presents the ARKit
  /// scanner modally), so it is wired here rather than in AppDelegate — under
  /// the scene-based lifecycle the FlutterViewController belongs to the scene,
  /// not the app delegate.
  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)

    if let controller = window?.rootViewController as? FlutterViewController {
      LidarMethodChannel.setup(with: controller)
    }
  }
}
