import ARKit
import simd

/// Accumulates room dimension estimates across AR frames.
///
/// iOS counterpart of the Android `RoomMeasurer`; the geometry model and the
/// reported numbers are deliberately identical so both platforms feed the same
/// `width` / `length` / `height` contract back to Dart:
///  - Room `width` / `length` come from the largest-by-area horizontal plane
///    (typically the floor), using its extent along X / Z.
///  - Room `height` comes from the tallest vertical plane's world-Y extent; if
///    no vertical plane is ever seen, `finalizedHeight()` falls back to
///    `defaultHeight`.
///
/// The pure math (`addHorizontalPlane` / `addVerticalPlane`) is kept separate
/// from the ARKit adapter (`ingest`) so the logic is testable without a live
/// AR session.
final class RoomMeasurer {

    /// Fallback ceiling height (meters) when no vertical plane is detected.
    static let defaultHeight: Double = 2.8

    private(set) var width: Double = 0
    private(set) var length: Double = 0
    private(set) var height: Double = 0
    private(set) var pointCount: Int = 0

    private var bestHorizontalArea: Double = 0

    /// Feed one horizontal-plane observation (floor/ceiling).
    func addHorizontalPlane(extentX: Float, extentZ: Float) {
        let area = Double(extentX) * Double(extentZ)
        if area > bestHorizontalArea {
            bestHorizontalArea = area
            width = Double(extentX)
            length = Double(extentZ)
        }
    }

    /// Feed one vertical-plane observation; keeps the tallest as room height.
    func addVerticalPlane(verticalExtent: Float) {
        let v = Double(verticalExtent)
        if v > height {
            height = v
        }
    }

    /// Accumulate raw point-cloud size for reporting confidence/coverage.
    func addPoints(count: Int) {
        pointCount += count
    }

    /// Height to report: measured, or the default if nothing vertical was seen.
    func finalizedHeight() -> Double {
        height > 0 ? height : RoomMeasurer.defaultHeight
    }

    /// ARKit adapter: classify a plane anchor and route it to the pure helpers.
    func ingest(_ plane: ARPlaneAnchor) {
        switch plane.alignment {
        case .horizontal:
            let (x, z) = RoomMeasurer.extent(of: plane)
            addHorizontalPlane(extentX: x, extentZ: z)
        case .vertical:
            addVerticalPlane(verticalExtent: RoomMeasurer.verticalExtent(of: plane))
        @unknown default:
            // Future ARKit alignments: ignore.
            break
        }
    }

    /// Plane extent along its local X / Z axes, across SDK versions.
    private static func extent(of plane: ARPlaneAnchor) -> (Float, Float) {
        if #available(iOS 16.0, *) {
            return (plane.planeExtent.width, plane.planeExtent.height)
        } else {
            return (plane.extent.x, plane.extent.z)
        }
    }

    /// World-space vertical (Y) extent of a vertical plane's boundary polygon.
    ///
    /// `geometry.boundaryVertices` are in the anchor's local space; each is
    /// transformed by the anchor transform and we take `maxY - minY`. This
    /// mirrors the Android implementation, which lifts the ARCore polygon's
    /// (x, z) pairs through the plane's center pose for the same reason: a
    /// vertical plane's local extent is not axis-aligned with world Y unless
    /// the wall happens to be perfectly upright.
    private static func verticalExtent(of plane: ARPlaneAnchor) -> Float {
        let vertices = plane.geometry.boundaryVertices
        guard vertices.count >= 2 else { return 0 }

        let transform = plane.transform
        var minY = Float.greatestFiniteMagnitude
        var maxY = -Float.greatestFiniteMagnitude

        for vertex in vertices {
            let world = transform * simd_float4(vertex.x, vertex.y, vertex.z, 1)
            minY = min(minY, world.y)
            maxY = max(maxY, world.y)
        }

        return maxY >= minY ? maxY - minY : 0
    }
}
