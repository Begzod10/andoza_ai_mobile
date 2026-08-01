package com.tamir_uy.tamir_uy_mobile_flutter

import com.google.ar.core.Plane
import com.google.ar.core.TrackingState

/**
 * Accumulates room dimension estimates across AR frames.
 *
 * Geometry model:
 *  - Room [width] / [length] come from the largest-by-area horizontal plane
 *    (typically the floor), using its extentX / extentZ.
 *  - Room [height] comes from the tallest vertical plane's vertical (world-Y)
 *    extent; if no vertical plane is ever seen, [finalizedHeight] falls back to
 *    [DEFAULT_HEIGHT].
 *
 * The pure math ([addHorizontalPlane] / [addVerticalPlane]) is kept separate
 * from the ARCore adapter ([ingest]) so the logic is unit-testable without a
 * live AR session.
 */
class RoomMeasurer {

    companion object {
        /** Fallback ceiling height (meters) when no vertical plane is detected. */
        const val DEFAULT_HEIGHT = 2.8
    }

    var width = 0.0
        private set
    var length = 0.0
        private set
    var height = 0.0
        private set
    var pointCount = 0
        private set

    private var bestHorizontalArea = 0.0

    /** Feed one horizontal-plane observation (floor/ceiling). */
    fun addHorizontalPlane(extentX: Float, extentZ: Float) {
        val area = extentX.toDouble() * extentZ.toDouble()
        if (area > bestHorizontalArea) {
            bestHorizontalArea = area
            width = extentX.toDouble()
            length = extentZ.toDouble()
        }
    }

    /** Feed one vertical-plane observation; keeps the tallest as room height. */
    fun addVerticalPlane(verticalExtent: Float) {
        val v = verticalExtent.toDouble()
        if (v > height) {
            height = v
        }
    }

    /** Accumulate raw point-cloud size for reporting confidence/coverage. */
    fun addPoints(count: Int) {
        pointCount += count
    }

    /** Height to report: measured, or the default if nothing vertical was seen. */
    fun finalizedHeight(): Double = if (height > 0.0) height else DEFAULT_HEIGHT

    /**
     * ARCore adapter: classify a tracking plane and route it to the pure helpers.
     * Ignores non-tracking or subsumed planes.
     */
    fun ingest(plane: Plane) {
        if (plane.trackingState != TrackingState.TRACKING) return
        if (plane.subsumedBy != null) return

        when (plane.type) {
            Plane.Type.HORIZONTAL_UPWARD_FACING,
            Plane.Type.HORIZONTAL_DOWNWARD_FACING ->
                addHorizontalPlane(plane.extentX, plane.extentZ)

            Plane.Type.VERTICAL ->
                addVerticalPlane(verticalExtentOf(plane))

            else -> {
                // Future ARCore plane types: ignore.
            }
        }
    }

    /**
     * World-space vertical (Y) extent of a vertical plane's boundary polygon.
     *
     * The polygon is a FloatBuffer of local (x, z) pairs in the plane's tangent
     * space; we lift each to 3D (x, 0, z), transform by the plane center pose
     * (via its 4x4 column-major matrix), and take max(worldY) - min(worldY).
     */
    private fun verticalExtentOf(plane: Plane): Float {
        val polygon = plane.polygon ?: return 0f
        val vertexCount = polygon.limit() / 2
        if (vertexCount < 2) return 0f

        // Column-major 4x4 transform from the plane's center pose.
        val matrix = FloatArray(16)
        plane.centerPose.toMatrix(matrix, 0)

        var minY = Float.MAX_VALUE
        var maxY = -Float.MAX_VALUE
        polygon.rewind()
        for (i in 0 until vertexCount) {
            val x = polygon.get(2 * i)
            val z = polygon.get(2 * i + 1)
            // worldY = M[row=1] · (x, 0, z, 1)  ->  m[1]*x + m[9]*z + m[13]
            val worldY = matrix[1] * x + matrix[9] * z + matrix[13]
            if (worldY < minY) minY = worldY
            if (worldY > maxY) maxY = worldY
        }
        polygon.rewind()
        return if (maxY >= minY) maxY - minY else 0f
    }
}
