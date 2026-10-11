package com.tamir_uy.tamir_uy_mobile_flutter.arscan

import kotlin.math.abs
import kotlin.math.hypot

/** A world-space point in metres (ARCore pose translation). */
data class Vec3(val x: Float, val y: Float, val z: Float)

enum class AddResult { ADDED, CLOSED, REJECTED_NOT_TRACKING }

/**
 * The floor outline being captured, kept free of ARCore types so it can be
 * unit-tested on the JVM. The activity feeds it hit-test points and, every
 * frame, the anchors' refreshed positions; it decides snapping/closing and the
 * ceiling height. All cleaning-up (squaring, merging) happens in Dart.
 */
class FloorPlanCapture(val snapDistanceM: Float = 0.20f) {

    private val points = mutableListOf<Vec3>()

    /** Height of the floor plane — the first corner's Y; later corners are pinned to it. */
    var floorY: Float? = null
        private set

    val corners: List<Vec3> get() = points.toList()

    /**
     * True once the user snapped back onto the first corner. The last point is
     * then the snapping tap itself (the loop's closure error), not a corner.
     */
    var isClosed: Boolean = false
        private set

    var trackingLossCount: Int = 0

    fun canAddCorner(tracking: Boolean): Boolean = tracking && !isClosed

    fun wouldSnap(p: Vec3): Boolean =
        !isClosed && points.size >= 3 &&
            hypot(p.x - points[0].x, p.z - points[0].z) <= snapDistanceM

    fun addCorner(p: Vec3): AddResult {
        if (isClosed) return AddResult.REJECTED_NOT_TRACKING
        val y = floorY ?: p.y.also { floorY = it }
        val snap = wouldSnap(p)
        points.add(Vec3(p.x, y, p.z))
        if (snap) {
            isClosed = true
            return AddResult.CLOSED
        }
        return AddResult.ADDED
    }

    fun undo(): Boolean {
        if (points.isEmpty()) return false
        points.removeAt(points.size - 1)
        isClosed = false
        if (points.isEmpty()) floorY = null
        return true
    }

    /**
     * Refresh corners from their anchors (ARCore improves its map as the user
     * walks). `null` = the anchor stopped tracking: that corner is dropped and
     * the outline has to be closed again.
     */
    fun updatePositions(positions: List<Vec3?>) {
        if (positions.size != points.size) return
        val y = floorY ?: return
        val kept = positions.filterNotNull().map { Vec3(it.x, y, it.z) }
        if (kept.size != points.size) isClosed = false
        points.clear()
        points.addAll(kept)
    }

    /**
     * Ceiling height where the camera ray passes closest to the vertical axis
     * standing on the first corner. `null` if the ray runs parallel to the
     * axis, points away from it, or lands outside 1.8–4.5 m.
     */
    fun heightFromRay(origin: Vec3, dir: Vec3): Float? {
        val base = points.firstOrNull() ?: return null
        val floor = floorY ?: return null
        // Axis: base + t·(0,1,0). Ray: origin + s·dir. Closest points between two lines.
        val w0x = base.x - origin.x
        val w0y = floor - origin.y
        val w0z = base.z - origin.z
        val b = dir.y
        val c = dir.x * dir.x + dir.y * dir.y + dir.z * dir.z
        val d = w0y
        val e = dir.x * w0x + dir.y * w0y + dir.z * w0z
        val denom = c - b * b
        if (abs(denom) < 1e-6f) return null
        val t = (b * e - c * d) / denom
        val s = (e - b * d) / denom
        if (s <= 0f) return null
        return t.takeIf { it in MIN_HEIGHT_M..MAX_HEIGHT_M }
    }

    fun toResult(height: Float, heightMeasured: Boolean, durationSec: Int): Map<String, Any> = mapOf(
        "corners" to points.map { listOf(it.x.toDouble(), it.z.toDouble()) },
        "height" to height.toDouble(),
        "heightMeasured" to heightMeasured,
        "closed" to isClosed,
        "trackingLossCount" to trackingLossCount,
        "durationSec" to durationSec,
    )

    companion object {
        const val MIN_HEIGHT_M = 1.8f
        const val MAX_HEIGHT_M = 4.5f
    }
}
