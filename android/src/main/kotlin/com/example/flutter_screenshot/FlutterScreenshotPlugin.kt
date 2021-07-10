package com.example.flutter_screenshot

import android.app.Activity
import android.graphics.Bitmap
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.renderer.FlutterRenderer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.ByteArrayOutputStream


/** FlutterScreenshotPlugin */
class FlutterScreenshotPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var renderer: Any? = null



    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_screenshot")
        channel.setMethodCallHandler(this)
        renderer = flutterPluginBinding.flutterEngine.renderer
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "getScreenshot" -> result.success(takeScreenshot());
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        this.activity = null;
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.activity = null;
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activity = binding.activity;
    }

    override fun onDetachedFromActivity() {
        this.activity = null;
    }

    private fun takeScreenshot(): ByteArray? {
        var bitmap: Bitmap? = null
        val view = activity!!.window.decorView.rootView;
        val stream = ByteArrayOutputStream()
        var compressedByteArray: ByteArray? = null


        if (renderer?.javaClass == FlutterView::class.java) {
            bitmap = (renderer as FlutterView?)!!.attachedFlutterEngine?.renderer?.bitmap
        } else if (renderer?.javaClass == FlutterRenderer::class.java) {
            bitmap = (renderer as FlutterRenderer?)!!.bitmap
        }


        bitmap?.compress(Bitmap.CompressFormat.PNG, 100, stream)
        compressedByteArray = stream.toByteArray()
        bitmap?.recycle()

        return compressedByteArray
    }
}
