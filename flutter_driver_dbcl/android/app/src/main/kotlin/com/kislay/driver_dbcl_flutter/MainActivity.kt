package com.kislay.driver_dbcl_flutter

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.kislay.driver_dbcl/ai"
    private var aiBridge: AiBridge? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        aiBridge = AiBridge(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "processFrame" -> {
                    val y = call.argument<ByteArray>("y")
                    val u = call.argument<ByteArray>("u")
                    val v = call.argument<ByteArray>("v")
                    val width = call.argument<Int>("width") ?: 0
                    val height = call.argument<Int>("height") ?: 0
                    val rotation = call.argument<Int>("rotation") ?: 0
                    val detectFace = call.argument<Boolean>("detectFace") ?: false

                    if (y != null && u != null && v != null) {
                        try {
                            val res = aiBridge?.processFrame(y, u, v, width, height, rotation, detectFace)
                            if (res != null) {
                                result.success(mapOf(
                                    "ear" to res.ear,
                                    "handNearEar" to res.handNearEar,
                                    "faceVisible" to res.faceVisible,
                                    "embedding" to res.embedding
                                ))
                            } else {
                                result.error("ERROR", "Process failed", null)
                            }
                        } catch (e: Exception) {
                            result.error("EXCEPTION", e.message, null)
                        }
                    } else {
                        result.error("INVALID_ARGS", "Planes missing", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        aiBridge?.close()
        super.onDestroy()
    }
}
