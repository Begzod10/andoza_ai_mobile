package com.tamir_uy.tamir_uy_mobile_flutter.arscan

import android.app.Activity
import android.content.Intent
import android.os.Handler
import android.os.Looper
import com.google.ar.core.ArCoreApk
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONObject

/**
 * `MethodChannel("andoza/arscan")`: `checkSupport` and `scanFloorPlan`, which
 * opens [ArScanActivity] and completes with its JSON result
 * (see docs/superpowers/specs/2026-10-11-arcore-room-scan-design.md).
 */
class ArScanChannel(private val activity: Activity) {

    companion object {
        private const val CHANNEL = "andoza/arscan"
        const val REQUEST_CODE = 0x5CA1
    }

    private var pending: MethodChannel.Result? = null
    private val main = Handler(Looper.getMainLooper())

    fun setup(engine: FlutterEngine) {
        MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkSupport" -> checkSupport(result, attempts = 0)
                "scanFloorPlan" -> {
                    @Suppress("UNCHECKED_CAST")
                    val strings = (call.argument<Map<String, String>>("strings") ?: emptyMap())
                    scan(strings, result)
                }
                "openAppSettings" -> {
                    activity.startActivity(
                        Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                            .setData(android.net.Uri.fromParts("package", activity.packageName, null))
                    )
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    /** ARCore's first answer is often a transient "checking"; ask again briefly. */
    private fun checkSupport(result: MethodChannel.Result, attempts: Int) {
        val availability = try {
            ArCoreApk.getInstance().checkAvailability(activity)
        } catch (e: Exception) {
            result.success(mapOf("supported" to false, "reason" to "unsupported_device"))
            return
        }
        if (availability.isTransient && attempts < 10) {
            main.postDelayed({ checkSupport(result, attempts + 1) }, 200)
            return
        }
        val reason = when (availability) {
            ArCoreApk.Availability.SUPPORTED_INSTALLED -> "ok"
            ArCoreApk.Availability.SUPPORTED_NOT_INSTALLED,
            ArCoreApk.Availability.SUPPORTED_APK_TOO_OLD -> "arcore_not_installed"
            ArCoreApk.Availability.UNSUPPORTED_DEVICE_NOT_CAPABLE -> "unsupported_device"
            // Still checking / timed out / error (e.g. offline): retryable, not a verdict.
            else -> "check_failed"
        }
        result.success(mapOf("supported" to (reason == "ok"), "reason" to reason))
    }

    private fun scan(strings: Map<String, String>, result: MethodChannel.Result) {
        if (pending != null) {
            result.error("busy", "A scan is already running", null)
            return
        }
        pending = result
        try {
            val intent = Intent(activity, ArScanActivity::class.java)
                .putExtra(ArScanActivity.EXTRA_STRINGS, HashMap(strings))
            activity.startActivityForResult(intent, REQUEST_CODE)
        } catch (e: Exception) {
            pending = null
            result.error("session_failed", e.message ?: "Could not open the scanner", null)
        }
    }

    fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != REQUEST_CODE) return false
        val result = pending ?: return true
        pending = null
        val json = data?.getStringExtra(ArScanActivity.EXTRA_RESULT)
        val error = data?.getStringExtra(ArScanActivity.EXTRA_ERROR)
        when {
            resultCode == Activity.RESULT_OK && json != null -> result.success(toMap(JSONObject(json)))
            error != null -> result.error(error, data.getStringExtra(ArScanActivity.EXTRA_ERROR_MESSAGE) ?: error, null)
            else -> result.success(null) // the user backed out
        }
        return true
    }

    private fun toMap(o: JSONObject): Map<String, Any?> = o.keys().asSequence().associateWith { k -> unwrap(o.get(k)) }

    private fun unwrap(v: Any?): Any? = when (v) {
        is JSONObject -> toMap(v)
        is JSONArray -> (0 until v.length()).map { unwrap(v.get(it)) }
        is Int -> v
        is Number -> v.toDouble()
        JSONObject.NULL -> null
        else -> v
    }
}
