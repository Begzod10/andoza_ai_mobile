import Flutter
import UIKit
import os.log

/// Native side of the `andoza/roomscan` MethodChannel.
///
/// Everything RoomPlan-specific lives behind `if #available(iOS 16, *)` and in
/// `RoomScanViewController` (which is `@available(iOS 16.0, *)`), so this file
/// compiles against the app's iOS 13.0 deployment target and the app still
/// launches on iOS 13–15 — the scan methods just report "unsupported".
///
/// Registered from `AppDelegate.didInitializeImplicitFlutterEngine` (the app uses
/// the new implicit-engine + SceneDelegate template, so there is no classic
/// `window.rootViewController` FlutterViewController to attach to at launch).
final class RoomScanPlugin: NSObject {
  static let channelName = "andoza/roomscan"
  private static let log = OSLog(subsystem: "uz.andoza.roomscan", category: "plugin")

  /// Held strongly while a scan is on screen so the VC is not deallocated
  /// mid-capture; released in the completion handler. `AnyObject` avoids naming
  /// the iOS 16-only type outside an availability check.
  private var activeController: AnyObject?
  /// Guards against a second `scanRoom` while one is already presented.
  private var isPresenting = false

  static func register(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: messenger)
    let instance = RoomScanPlugin()
    channel.setMethodCallHandler { call, result in
      instance.handle(call, result: result)
    }
    os_log("registered %{public}@ channel", log: log, type: .info, channelName)
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isSupported":
      result(Self.isSupportedPayload())
    case "scanRoom":
      scanRoom(result: result)
    case "scanObject":
      // Object Capture arrives in Phase 6.
      os_log("scanObject called — not implemented yet", log: Self.log, type: .info)
      result(FlutterError(code: "not_implemented",
                          message: "Obyektni skanerlash keyinroq qo'shiladi",
                          details: nil))
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// `{supported: Bool, reason: "no_lidar" | "ios_too_old" | null}`
  private static func isSupportedPayload() -> [String: Any] {
    if #available(iOS 16, *) {
      if RoomCaptureSession.isSupported {
        os_log("isSupported = true", log: log, type: .info)
        return ["supported": true, "reason": NSNull()]
      } else {
        os_log("isSupported = false (no LiDAR)", log: log, type: .info)
        return ["supported": false, "reason": "no_lidar"]
      }
    } else {
      os_log("isSupported = false (iOS < 16)", log: log, type: .info)
      return ["supported": false, "reason": "ios_too_old"]
    }
  }

  private func scanRoom(result: @escaping FlutterResult) {
    guard !isPresenting else {
      os_log("scanRoom rejected — a scan is already active", log: Self.log, type: .error)
      result(FlutterError(code: "busy", message: "Skaner allaqachon ochiq", details: nil))
      return
    }

    guard #available(iOS 16, *) else {
      result(FlutterError(code: "scan_failed", message: "RoomPlan iOS 16 yoki undan yangi versiyani talab qiladi", details: nil))
      return
    }

    guard RoomCaptureSession.isSupported else {
      os_log("scanRoom rejected — device unsupported", log: Self.log, type: .error)
      result(FlutterError(code: "scan_failed", message: "Qurilma RoomPlan'ni qo'llab-quvvatlamaydi", details: nil))
      return
    }

    guard let host = Self.topViewController() else {
      os_log("scanRoom rejected — no host view controller", log: Self.log, type: .error)
      result(FlutterError(code: "scan_failed", message: "Ekranni topib bo'lmadi", details: nil))
      return
    }

    isPresenting = true
    let controller = RoomScanViewController { [weak self] outcome in
      guard let self = self else { return }
      self.isPresenting = false
      self.activeController = nil
      switch outcome {
      case .success(let payload):
        os_log("scanRoom success", log: Self.log, type: .info)
        result(payload)
      case .cancelled:
        os_log("scanRoom cancelled by user", log: Self.log, type: .info)
        result(nil)
      case .failed(let message):
        os_log("scanRoom failed: %{public}@", log: Self.log, type: .error, message)
        result(FlutterError(code: "scan_failed", message: message, details: nil))
      }
    }
    activeController = controller
    controller.modalPresentationStyle = .fullScreen
    host.present(controller, animated: true) {
      os_log("presented RoomScanViewController", log: Self.log, type: .info)
    }
  }

  /// Top-most view controller of the active foreground window scene — the
  /// SceneDelegate template means we can't use `AppDelegate.window`.
  private static func topViewController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = (scenes.first { $0.activationState == .foregroundActive } as? UIWindowScene)
      ?? (scenes.first as? UIWindowScene)
    let window = windowScene?.windows.first { $0.isKeyWindow } ?? windowScene?.windows.first
    var top = window?.rootViewController
    while let presented = top?.presentedViewController {
      top = presented
    }
    return top
  }
}
