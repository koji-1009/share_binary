package com.dr1009.app.share_binary

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import java.io.FileOutputStream

/** ShareBinaryPlugin */
class ShareBinaryPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.dr1009.app/share_binary")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "shareBinary" -> {
                val bytes = call.argument<ByteArray>("bytes") as ByteArray
                val fileName = call.argument<String>("filename") as String
                val chooserTitle = call.argument<String>("chooserTitle") ?: ""

                val tempDir = File(applicationContext.cacheDir, "share_binary")
                if (!tempDir.exists()) {
                    tempDir.mkdir()
                }

                val file = File(tempDir, fileName)
                FileOutputStream(file).use { output ->
                    output.write(bytes)
                }
                val uri = FileProvider.getUriForFile(
                    /* context = */ applicationContext,
                    /* authority = */ "${applicationContext.packageName}.share_binary.provider",
                    /* file = */ file,
                )

                val intent = Intent.createChooser(
                    /* target = */
                    Intent(Intent.ACTION_VIEW)
                        .setData(uri)
                        .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
                    /* title = */ chooserTitle,
                )
                activity?.startActivity(intent)

                result.success(null)
            }

            "shareUri" -> {
                val uri = call.argument<String>("uri") as String
                val chooserTitle = call.argument<String>("chooserTitle") ?: ""

                val intent = Intent.createChooser(
                    /* target = */
                    Intent(Intent.ACTION_VIEW)
                        .setData(Uri.parse(uri))
                        .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
                    /* title = */ chooserTitle,
                )
                activity?.startActivity(intent)

                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }
}
