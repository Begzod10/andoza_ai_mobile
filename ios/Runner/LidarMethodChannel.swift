import ARKit
import Flutter
import UIKit

/// Handles the `com.tamir_uy/lidar` MethodChannel on iOS.
///
/// Mirrors the Android `LidarMethodChannel` contract exactly, so the Dart side
/// (`LidarService` / `LiDARScanningScreen`) needs no platform branching:
///  - `isLidarAvailable` → true only on AR-capable hardware; false on the
///    Simulator, where Dart falls back to its scan simulation.
///  - `scanRoom` → presents `DepthScanViewController` and completes with
///    `width` / `length` / `height` / `pointCount` / `durationMs`, or fails
///    with CANCELLED / PERMISSION_DENIED / UNSUPPORTED / SCAN_FAILED.
///  - `startScan` / `stopScan` / `getScanData` / `getMeasurements` are the
///    legacy methods, kept graceful so nothing breaks.
final class LidarMethodChannel {

    static let channelName = "com.tamir_uy/lidar"

    /// Retained for the lifetime of the app; the channel holds the handler.
    private static var instance: LidarMethodChannel?

    private weak var controller: FlutterViewController?

    /// The in-flight `scanRoom` result, completed from the scan controller.
    private var pendingResult: FlutterResult?

    /// Last successful scan's dimensions, returned by `getMeasurements`.
    private var lastWidth: Double = 0
    private var lastLength: Double = 0
    private var lastHeight: Double = 0

    static func setup(with controller: FlutterViewController) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: controller.binaryMessenger
        )

        let instance = LidarMethodChannel()
        instance.controller = controller
        self.instance = instance

        channel.setMethodCallHandler { call, result in
            instance.onMethodCall(call, result: result)
        }
    }

    private func onMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isLidarAvailable":
            result(LidarMethodChannel.isArSupported())

        case "scanRoom":
            handleScanRoom(result: result)

        // ---- Legacy methods: kept graceful so nothing breaks. ----
        case "startScan", "stopScan":
            result(nil)

        case "getScanData":
            result([
                "points": [Any](),
                // Dart parses this with DateTime.parse -> must be ISO-8601.
                "timestamp": ISO8601DateFormatter().string(from: Date()),
                "duration": 0,
            ])

        case "getMeasurements":
            result([
                "width": lastWidth,
                "length": lastLength,
                "height": lastHeight,
            ])

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    /// True only on hardware that can actually run world tracking. The
    /// Simulator and pre-ARKit devices report false, which is the correct
    /// graceful-degradation signal for Dart.
    ///
    /// Note this is deliberately *not* gated on LiDAR specifically: plane
    /// detection measures a room on any ARKit device, and LiDAR simply makes
    /// it converge faster (`DepthScanViewController` enables scene
    /// reconstruction when the device has it).
    private static func isArSupported() -> Bool {
        ARWorldTrackingConfiguration.isSupported
    }

    private func handleScanRoom(result: @escaping FlutterResult) {
        guard let controller else {
            result(FlutterError(code: "SCAN_FAILED", message: "No host controller is available", details: nil))
            return
        }
        guard LidarMethodChannel.isArSupported() else {
            result(FlutterError(code: "UNSUPPORTED", message: "ARKit is not supported on this device", details: nil))
            return
        }
        // Guard against concurrent scans.
        guard pendingResult == nil else {
            result(FlutterError(code: "SCAN_FAILED", message: "A scan is already in progress", details: nil))
            return
        }

        pendingResult = result

        let scanner = DepthScanViewController { [weak self] outcome in
            guard let self, let pending = self.pendingResult else { return }
            self.pendingResult = nil
            self.complete(pending, with: outcome)
        }

        controller.present(scanner, animated: true)
    }

    private func complete(_ result: @escaping FlutterResult, with outcome: DepthScanOutcome) {
        switch outcome {
        case let .success(width, length, height, pointCount, durationMs):
            lastWidth = width
            lastLength = length
            lastHeight = height
            result([
                "width": width,
                "length": length,
                "height": height,
                "pointCount": pointCount,
                "durationMs": durationMs,
            ])

        case let .failure(code, message):
            result(FlutterError(code: code, message: message, details: nil))
        }
    }
}
