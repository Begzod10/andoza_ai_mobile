package com.tamir_uy.tamir_uy_mobile_flutter.arscan

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.opengl.Matrix
import android.view.View
import java.util.Locale

/** Projects world points to screen pixels with ARCore's camera matrices. */
class ScreenProjector(private val view: FloatArray, private val proj: FloatArray, private val w: Int, private val h: Int) {
    private val vp = FloatArray(16).also { Matrix.multiplyMM(it, 0, proj, 0, view, 0) }

    /** `null` when the point is behind the camera. */
    fun project(p: Vec3): Pair<Float, Float>? {
        val v = floatArrayOf(p.x, p.y, p.z, 1f)
        val out = FloatArray(4)
        Matrix.multiplyMV(out, 0, vp, 0, v, 0)
        if (out[3] <= 0f) return null
        val nx = out[0] / out[3]
        val ny = out[1] / out[3]
        return Pair((nx + 1f) / 2f * w, (1f - ny) / 2f * h)
    }
}

/** What the overlay draws this frame (screen pixels). */
data class OverlayState(
    val corners: List<Pair<Float, Float>?> = emptyList(),
    val labels: List<Triple<Float, Float, String>> = emptyList(),
    val reticleOnFloor: Boolean = false,
    val snapping: Boolean = false,
    val closed: Boolean = false,
    val heightAxis: Pair<Pair<Float, Float>, Pair<Float, Float>>? = null,
    val heightLabel: String? = null,
)

/** Transparent view over the camera: outline, corner dots, lengths and the aim reticle. */
class ArOverlayView(context: Context) : View(context) {
    private val density = resources.displayMetrics.density
    private val line = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.WHITE; strokeWidth = 3f * density; style = Paint.Style.STROKE }
    private val dot = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.rgb(40, 80, 208) }
    private val ring = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.WHITE; style = Paint.Style.STROKE; strokeWidth = 2.5f * density }
    private val text = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.WHITE; textSize = 14f * density; textAlign = Paint.Align.CENTER; setShadowLayer(4f, 0f, 0f, Color.BLACK) }
    private val axis = Paint(Paint.ANTI_ALIAS_FLAG).apply { color = Color.rgb(249, 115, 22); strokeWidth = 3f * density }

    var state = OverlayState()
        set(value) { field = value; postInvalidateOnAnimation() }

    override fun onDraw(canvas: Canvas) {
        val s = state
        val pts = s.corners
        for (i in 0 until pts.size - 1) {
            val a = pts[i] ?: continue
            val b = pts[i + 1] ?: continue
            canvas.drawLine(a.first, a.second, b.first, b.second, line)
        }
        if (s.closed && pts.size >= 3) {
            val a = pts.last(); val b = pts.first()
            if (a != null && b != null) canvas.drawLine(a.first, a.second, b.first, b.second, line)
        }
        for (p in pts) if (p != null) canvas.drawCircle(p.first, p.second, 7f * density, dot)
        for ((x, y, label) in s.labels) canvas.drawText(label, x, y, text)
        s.heightAxis?.let { (a, b) -> canvas.drawLine(a.first, a.second, b.first, b.second, axis) }
        s.heightLabel?.let { canvas.drawText(it, width / 2f, height / 2f - 40f * density, text) }

        // Aim reticle in the centre: white ring, blue when it would snap.
        val cx = width / 2f; val cy = height / 2f
        ring.color = when {
            s.snapping -> Color.rgb(40, 80, 208)
            s.reticleOnFloor -> Color.WHITE
            else -> Color.argb(110, 255, 255, 255)
        }
        canvas.drawCircle(cx, cy, 18f * density, ring)
        canvas.drawCircle(cx, cy, 2.5f * density, ring)
    }

    companion object {
        fun metres(m: Float): String = String.format(Locale.US, "%.2f m", m)
    }
}
