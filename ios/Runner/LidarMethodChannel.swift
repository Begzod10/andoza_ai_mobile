import Flutter
import ARKit

class LidarMethodChannel {
    static let channelName = "com.tamir_uy/lidar"

    private var arSession: ARSession?
    private var lidarPointCloud: [LidarPoint] = []
    private var scanStartTime: Date?

    static func setup(with controller: FlutterViewController) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: controller.binaryMessenger
        )

        let instance = LidarMethodChannel()

        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "isLidarAvailable":
                result(instance.isLidarAvailable())
            case "startScan":
                do {
                    try instance.startScan()
                    result(nil)
                } catch {
                    result(FlutterError(
                        code: "START_SCAN_ERROR",
                        message: error.localizedDescription,
                        details: nil
                    ))
                }
            case "stopScan":
                do {
                    try instance.stopScan()
                    result(nil)
                } catch {
                    result(FlutterError(
                        code: "STOP_SCAN_ERROR",
                        message: error.localizedDescription,
                        details: nil
                    ))
                }
            case "getScanData":
                do {
                    let data = try instance.getScanData()
                    result(data)
                } catch {
                    result(FlutterError(
                        code: "GET_SCAN_ERROR",
                        message: error.localizedDescription,
                        details: nil
                    ))
                }
            case "getMeasurements":
                do {
                    let measurements = try instance.getMeasurements()
                    result(measurements)
                } catch {
                    result(FlutterError(
                        code: "GET_MEASUREMENTS_ERROR",
                        message: error.localizedDescription,
                        details: nil
                    ))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func isLidarAvailable() -> Bool {
        // Check if device supports ARKit LiDAR
        if #available(iOS 14.0, *) {
            return ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth)
        }
        return false
    }

    private func startScan() throws {
        // TODO: Initialize ARKit session with LiDAR depth
        arSession = ARSession()
        scanStartTime = Date()
        lidarPointCloud = []
    }

    private func stopScan() throws {
        // TODO: Stop ARKit session and process depth data
        arSession?.pause()
    }

    private func getScanData() throws -> [String: Any] {
        // TODO: Convert ARFrame depth data to point cloud
        let duration = Date().timeIntervalSince(scanStartTime ?? Date())

        return [
            "points": lidarPointCloud.map { point in
                ["x": point.x, "y": point.y, "z": point.z, "confidence": point.confidence]
            },
            "timestamp": ISO8601DateFormatter().string(from: Date()),
            "duration": Int(duration * 1000)
        ]
    }

    private func getMeasurements() throws -> [String: Double] {
        // TODO: Calculate room dimensions from point cloud
        return [
            "width": 0.0,
            "length": 0.0,
            "height": 0.0
        ]
    }
}

struct LidarPoint {
    let x: Double
    let y: Double
    let z: Double
    let confidence: Double
}
