package com.tamir_uy.tamir_uy_mobile_flutter

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    private var lidarChannel: LidarMethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // The channel needs this Activity to launch DepthScanActivity and to
        // receive its result via onActivityResult (below).
        lidarChannel = LidarMethodChannel(this).also { channel ->
            channel.setupChannel(flutterEngine, this)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        // Forward to the channel so it can complete a pending `scanRoom` result.
        lidarChannel?.handleActivityResult(requestCode, resultCode, data)
    }
}
