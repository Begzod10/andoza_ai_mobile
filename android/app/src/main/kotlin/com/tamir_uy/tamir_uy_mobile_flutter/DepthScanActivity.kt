package com.tamir_uy.tamir_uy_mobile_flutter

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.opengl.GLES20
import android.opengl.GLSurfaceView
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.widget.Button
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView
import com.google.ar.core.ArCoreApk
import com.google.ar.core.Config
import com.google.ar.core.Plane
import com.google.ar.core.Session
import com.google.ar.core.TrackingState
import com.google.ar.core.exceptions.CameraNotAvailableException
import com.google.ar.core.exceptions.UnavailableApkTooOldException
import com.google.ar.core.exceptions.UnavailableArcoreNotInstalledException
import com.google.ar.core.exceptions.UnavailableDeviceNotCompatibleException
import com.google.ar.core.exceptions.UnavailableSdkTooOldException
import com.google.ar.core.exceptions.UnavailableUserDeclinedInstallationException
import java.util.Locale
import javax.microedition.khronos.egl.EGLConfig
import javax.microedition.khronos.opengles.GL10

/**
 * Real ARCore room-scanning screen.
 *
 * Runs a live AR [Session], renders the camera background, detects horizontal
 * and vertical planes, and accumulates room dimensions in [RoomMeasurer].
 * The user taps "Tayyor" (Done) to finish with RESULT_OK + the measurements,
 * or backs out to cancel (RESULT_CANCELED).
 *
 * Extends plain [Activity] (not AppCompatActivity) to avoid pulling an extra
 * androidx dependency.
 */
class DepthScanActivity : Activity(), GLSurfaceView.Renderer {

    companion object {
        private const val CAMERA_PERMISSION_CODE = 4201
    }

    private lateinit var surfaceView: GLSurfaceView
    private lateinit var statusText: TextView

    private var session: Session? = null
    private var installRequested = false

    private val backgroundRenderer = BackgroundRenderer()
    private val measurer = RoomMeasurer()
    private val mainHandler = Handler(Looper.getMainLooper())

    private var startTimeMs = 0L
    @Volatile private var trackingPlaneCount = 0

    // Cached display geometry for session.setDisplayGeometry().
    private var viewportWidth = 0
    private var viewportHeight = 0
    private var viewportChanged = false

    // Set once we've handed off a result, to avoid double-finishing.
    private var finished = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startTimeMs = System.currentTimeMillis()

        val root = FrameLayout(this)
        root.setBackgroundColor(Color.BLACK)

        surfaceView = GLSurfaceView(this).apply {
            preserveEGLContextOnPause = true
            setEGLContextClientVersion(2)
            setEGLConfigChooser(8, 8, 8, 8, 16, 0)
            setRenderer(this@DepthScanActivity)
            renderMode = GLSurfaceView.RENDERMODE_CONTINUOUSLY
        }
        root.addView(
            surfaceView,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
        )

        root.addView(buildOverlay())
        setContentView(root)

        // Request camera permission up-front; session creation waits for it in
        // onResume(). If denied, we cancel with PERMISSION_DENIED.
        if (!hasCameraPermission()) {
            requestPermissions(arrayOf(Manifest.permission.CAMERA), CAMERA_PERMISSION_CODE)
        }
    }

    // ---------------------------------------------------------------------
    // Overlay UI
    // ---------------------------------------------------------------------

    private fun buildOverlay(): View {
        val overlay = FrameLayout(this)
        overlay.layoutParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.MATCH_PARENT
        )

        // Close ("✕") button, top-start.
        val closeButton = TextView(this).apply {
            text = "✕"
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 24f)
            setPadding(dp(16), dp(16), dp(16), dp(16))
            setOnClickListener { cancelScan() }
        }
        overlay.addView(
            closeButton,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.TOP or Gravity.START
            )
        )

        // Bottom column: live status + "Tayyor" button.
        val bottom = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER_HORIZONTAL
            setPadding(dp(24), dp(16), dp(24), dp(32))
        }

        statusText = TextView(this).apply {
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 16f)
            gravity = Gravity.CENTER
            setShadowLayer(6f, 0f, 0f, Color.BLACK)
            text = "Xonani skanerlash uchun kamerani aylantiring"
        }
        bottom.addView(statusText)

        val doneButton = Button(this).apply {
            text = "Tayyor"
            val lp = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
            lp.topMargin = dp(16)
            layoutParams = lp
            setOnClickListener { finishWithResult() }
        }
        bottom.addView(doneButton)

        overlay.addView(
            bottom,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.BOTTOM
            )
        )

        return overlay
    }

    private fun updateOverlay() {
        val w = measurer.width
        val l = measurer.length
        val h = measurer.finalizedHeight()
        val planes = trackingPlaneCount
        val text = String.format(
            Locale.US,
            "%.2f × %.2f × %.2f m\nTekisliklar: %d",
            w, l, h, planes
        )
        mainHandler.post {
            if (!finished) statusText.text = text
        }
    }

    // ---------------------------------------------------------------------
    // Permissions
    // ---------------------------------------------------------------------

    private fun hasCameraPermission(): Boolean =
        checkSelfPermission(Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == CAMERA_PERMISSION_CODE) {
            if (!hasCameraPermission()) {
                failAndFinish("PERMISSION_DENIED", "Camera permission denied")
            }
            // If granted, onResume() runs next and creates the session.
        }
    }

    // ---------------------------------------------------------------------
    // Lifecycle
    // ---------------------------------------------------------------------

    override fun onResume() {
        super.onResume()
        if (finished) return

        // Wait for the camera permission decision before touching ARCore.
        if (!hasCameraPermission()) return

        if (session == null) {
            if (!ensureSessionCreated()) return
        }

        try {
            session?.resume()
        } catch (e: CameraNotAvailableException) {
            session?.close()
            session = null
            failAndFinish("SCAN_FAILED", "Camera not available")
            return
        }
        surfaceView.onResume()
    }

    override fun onPause() {
        super.onPause()
        if (session != null) {
            // Pause the GL surface first so it stops using the session.
            surfaceView.onPause()
            session?.pause()
        }
    }

    override fun onDestroy() {
        session?.close()
        session = null
        super.onDestroy()
    }

    /** Creates and configures the ARCore [Session]. Returns false if it can't. */
    private fun ensureSessionCreated(): Boolean {
        try {
            when (ArCoreApk.getInstance().requestInstall(this, !installRequested)) {
                ArCoreApk.InstallStatus.INSTALL_REQUESTED -> {
                    // ARCore is installing; retry on the next onResume().
                    installRequested = true
                    return false
                }
                ArCoreApk.InstallStatus.INSTALLED -> {
                    // Proceed to create the session.
                }
            }

            val newSession = Session(this)
            val config = Config(newSession).apply {
                planeFindingMode = Config.PlaneFindingMode.HORIZONTAL_AND_VERTICAL
                // Depth improves plane/point quality but is optional.
                depthMode = if (newSession.isDepthModeSupported(Config.DepthMode.AUTOMATIC)) {
                    Config.DepthMode.AUTOMATIC
                } else {
                    Config.DepthMode.DISABLED
                }
                updateMode = Config.UpdateMode.LATEST_CAMERA_IMAGE
            }
            newSession.configure(config)
            session = newSession
            return true
        } catch (e: UnavailableUserDeclinedInstallationException) {
            failAndFinish("UNSUPPORTED", "ARCore installation declined")
        } catch (e: UnavailableArcoreNotInstalledException) {
            failAndFinish("UNSUPPORTED", "ARCore is not installed")
        } catch (e: UnavailableApkTooOldException) {
            failAndFinish("UNSUPPORTED", "ARCore is too old, please update")
        } catch (e: UnavailableSdkTooOldException) {
            failAndFinish("UNSUPPORTED", "App's ARCore SDK is too old")
        } catch (e: UnavailableDeviceNotCompatibleException) {
            failAndFinish("UNSUPPORTED", "This device does not support ARCore")
        } catch (e: Exception) {
            failAndFinish("SCAN_FAILED", e.message ?: "Failed to create AR session")
        }
        return false
    }

    // ---------------------------------------------------------------------
    // GLSurfaceView.Renderer
    // ---------------------------------------------------------------------

    override fun onSurfaceCreated(gl: GL10?, config: EGLConfig?) {
        GLES20.glClearColor(0f, 0f, 0f, 1f)
        try {
            backgroundRenderer.createOnGlThread()
        } catch (e: Exception) {
            // TODO(real-device): a GL init failure here yields a black background
            // but plane detection still runs; validate visuals on hardware.
        }
    }

    override fun onSurfaceChanged(gl: GL10?, width: Int, height: Int) {
        GLES20.glViewport(0, 0, width, height)
        viewportWidth = width
        viewportHeight = height
        viewportChanged = true
    }

    override fun onDrawFrame(gl: GL10?) {
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT or GLES20.GL_DEPTH_BUFFER_BIT)

        val currentSession = session ?: return
        if (finished) return

        try {
            // Push display geometry to ARCore when the viewport changes.
            if (viewportChanged && viewportWidth > 0 && viewportHeight > 0) {
                @Suppress("DEPRECATION")
                val rotation = windowManager.defaultDisplay.rotation
                currentSession.setDisplayGeometry(rotation, viewportWidth, viewportHeight)
                viewportChanged = false
            }

            // Bind the camera texture and pull the latest frame.
            currentSession.setCameraTextureName(backgroundRenderer.textureId)
            val frame = currentSession.update()

            backgroundRenderer.draw(frame)

            // Count point-cloud points (x, y, z, confidence -> 4 floats each).
            try {
                val pointCloud = frame.acquirePointCloud()
                val floats = pointCloud.points.remaining()
                measurer.addPoints(floats / 4)
                pointCloud.release()
            } catch (e: Exception) {
                // Point cloud not available this frame; ignore.
            }

            // Feed updated planes into the measurer.
            for (plane in frame.getUpdatedTrackables(Plane::class.java)) {
                measurer.ingest(plane)
            }

            // Count all currently-tracking, non-subsumed planes for the overlay.
            var count = 0
            for (plane in currentSession.getAllTrackables(Plane::class.java)) {
                if (plane.trackingState == TrackingState.TRACKING && plane.subsumedBy == null) {
                    count++
                }
            }
            trackingPlaneCount = count

            updateOverlay()
        } catch (e: CameraNotAvailableException) {
            mainHandler.post { failAndFinish("SCAN_FAILED", "Camera not available") }
        } catch (e: Throwable) {
            // Never let the GL thread crash the app; a bad frame is recoverable.
            // TODO(real-device): log/inspect these on hardware.
        }
    }

    // ---------------------------------------------------------------------
    // Result handling
    // ---------------------------------------------------------------------

    override fun onBackPressed() {
        cancelScan()
    }

    private fun cancelScan() {
        if (finished) return
        finished = true
        setResult(RESULT_CANCELED)
        finish()
    }

    private fun finishWithResult() {
        if (finished) return
        finished = true
        val durationMs = (System.currentTimeMillis() - startTimeMs).toInt()
        val data = Intent().apply {
            putExtra("width", measurer.width)
            putExtra("length", measurer.length)
            putExtra("height", measurer.finalizedHeight())
            putExtra("pointCount", measurer.pointCount)
            putExtra("durationMs", durationMs)
        }
        setResult(RESULT_OK, data)
        finish()
    }

    private fun failAndFinish(code: String, message: String) {
        if (finished) return
        finished = true
        val data = Intent().apply {
            putExtra("errorCode", code)
            putExtra("errorMessage", message)
        }
        setResult(RESULT_CANCELED, data)
        finish()
    }

    private fun dp(value: Int): Int =
        (value * resources.displayMetrics.density).toInt()
}
