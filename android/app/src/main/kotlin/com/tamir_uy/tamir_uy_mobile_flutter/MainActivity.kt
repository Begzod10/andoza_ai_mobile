package com.tamir_uy.tamir_uy_mobile_flutter

import android.content.Intent
import com.tamir_uy.tamir_uy_mobile_flutter.arscan.ArScanChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    private var arScan: ArScanChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // The ARCore floor-plan scanner (andoza/arscan); its result comes back
        // through onActivityResult below.
        arScan = ArScanChannel(this).also { it.setup(flutterEngine) }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        arScan?.handleActivityResult(requestCode, resultCode, data)
    }
}
