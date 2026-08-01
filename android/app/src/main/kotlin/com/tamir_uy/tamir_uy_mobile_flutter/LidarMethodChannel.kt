package com.tamir_uy.tamir_uy_mobile_flutter

import android.app.Activity
import android.content.Context
import android.content.Intent
import com.google.ar.core.ArCoreApk
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.time.Instant

/**
 * Handles the `com.tamir_uy/lidar` MethodChannel.
 *
 * On real ARCore-capable hardware [scanRoom] launches [DepthScanActivity] and
 * completes with the measured room dimensions. On an emulator (no AR support)
 * [isLidarAvailable] returns false and [scanRoom] fails with `UNSUPPORTED`,
 * which is the correct graceful-degradation behavior.
 */
class LidarMethodChannel(private val context: Context) {

    companion object {
        private const val CHANNEL = "com.tamir_uy/lidar"

        /** Arbitrary, non-colliding request code for the scan activity. */
        const val REQUEST_CODE = 0x5CA0
    }

    private var activity: Activity? = null
    private var channel: MethodChannel? = null

    /** The in-flight `scanRoom` result, completed from [handleActivityResult]. */
    private var pendingResult: MethodChannel.Result? = null

    /** Last successful scan's dimensions, returned by `getMeasurements`. */
    private var lastWidth = 0.0
    private var lastLength = 0.0
    private var lastHeight = 0.0

    fun setupChannel(flutterEngine: FlutterEngine, activity: Activity) {
        this.activity = activity
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result -> onMethodCall(call, result) }
        }
    }

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "isLidarAvailable" -> result.success(isArCoreSupported())

            "scanRoom" -> handleScanRoom(result)

            // ---- Legacy methods: kept graceful so nothing breaks. ----
            "startScan" -> result.success(null)
            "stopScan" -> result.success(null)
            "getScanData" -> result.success(
                mapOf(
                    "points" to emptyList<Any>(),
                    // Dart parses this with DateTime.parse -> must be ISO-8601.
                    "timestamp" to Instant.now().toString(),
                    "duration" to 0
                )
            )
            "getMeasurements" -> result.success(
                mapOf(
                    "width" to lastWidth,
                    "length" to lastLength,
                    "height" to lastHeight
                )
            )

            else -> result.notImplemented()
        }
    }

    /**
     * True only if ARCore reports the device as supported. UNKNOWN/UNSUPPORTED
     * and any exception (e.g. emulator, ARCore missing) map to false.
     */
    private fun isArCoreSupported(): Boolean {
        return try {
            // checkAvailability can return a transient "checking" state on the
            // first call; we treat anything that is not explicitly supported as
            // false. The Dart side re-queries, and DepthScanActivity does its own
            // requestInstall() guard, so a transient false here is safe.
            ArCoreApk.getInstance().checkAvailability(context).isSupported
        } catch (e: Exception) {
            false
        }
    }

    private fun handleScanRoom(result: MethodChannel.Result) {
        val act = activity
        if (act == null) {
            result.error("SCAN_FAILED", "No host activity is available", null)
            return
        }
        if (!isArCoreSupported()) {
            result.error("UNSUPPORTED", "ARCore is not supported on this device", null)
            return
        }
        // Guard against concurrent scans.
        if (pendingResult != null) {
            result.error("SCAN_FAILED", "A scan is already in progress", null)
            return
        }

        pendingResult = result
        try {
            act.startActivityForResult(
                Intent(act, DepthScanActivity::class.java),
                REQUEST_CODE
            )
        } catch (e: Exception) {
            pendingResult = null
            result.error("SCAN_FAILED", e.message ?: "Failed to launch scanner", null)
        }
    }

    /**
     * Completes the pending `scanRoom` result. Returns true if this request code
     * belonged to us (whether or not there was a pending result to complete).
     */
    fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != REQUEST_CODE) return false

        val result = pendingResult ?: return true
        pendingResult = null

        when (resultCode) {
            Activity.RESULT_OK -> {
                if (data == null) {
                    result.error("SCAN_FAILED", "Scanner returned no data", null)
                    return true
                }
                val width = data.getDoubleExtra("width", 0.0)
                val length = data.getDoubleExtra("length", 0.0)
                val height = data.getDoubleExtra("height", 0.0)
                val pointCount = data.getIntExtra("pointCount", 0)
                val durationMs = data.getIntExtra("durationMs", 0)

                lastWidth = width
                lastLength = length
                lastHeight = height

                result.success(
                    mapOf(
                        "width" to width,
                        "length" to length,
                        "height" to height,
                        "pointCount" to pointCount,
                        "durationMs" to durationMs
                    )
                )
            }
            else -> {
                // DepthScanActivity may attach a specific failure code; otherwise
                // a plain RESULT_CANCELED means the user backed out.
                val code = data?.getStringExtra("errorCode")
                val message = data?.getStringExtra("errorMessage")
                when (code) {
                    "PERMISSION_DENIED" ->
                        result.error("PERMISSION_DENIED", message ?: "Camera permission denied", null)
                    "UNSUPPORTED" ->
                        result.error("UNSUPPORTED", message ?: "ARCore unsupported", null)
                    "SCAN_FAILED" ->
                        result.error("SCAN_FAILED", message ?: "Scan failed", null)
                    else ->
                        result.error("CANCELLED", message ?: "Scan was cancelled", null)
                }
            }
        }
        return true
    }
}
