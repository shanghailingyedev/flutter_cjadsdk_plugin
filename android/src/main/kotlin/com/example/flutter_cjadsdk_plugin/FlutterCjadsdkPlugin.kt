package com.example.flutter_cjadsdk_plugin

import LingYeBaseRegister
import LingYeTools
import androidx.annotation.NonNull
import com.example.flutter_cjadsdk_plugin.common.LingYeNativeRegister

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference

/** FlutterCjadsdkPlugin */
class FlutterCjadsdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    LingYeNativeRegister.getInstance().initHandler(flutterPluginBinding)
    LingYeBaseRegister.getInstance().init(flutterPluginBinding.binaryMessenger)
  }


  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    LingYeTools.setActivityWeakRef(binding.activity)
//     TODO("Not yet implemented")
  }

  override fun onDetachedFromActivityForConfigChanges() {
//     TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
//     TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
//     TODO("Not yet implemented")
  }
}
