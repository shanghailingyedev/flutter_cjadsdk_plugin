package com.example.flutter_cjadsdk_plugin.ads

import android.content.Context
import android.util.Log
import com.example.flutter_cjadsdk_plugin.Views.LingYeNativeView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class LingYeNativeFactory {

    class NativeFactory(binaryMessenger: BinaryMessenger, instance: StandardMessageCodec) :
        PlatformViewFactory(StandardMessageCodec.INSTANCE) {
        private val mBinaryMessenger: BinaryMessenger = binaryMessenger
        override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
            Log.e("cj-log",  "LingYeNativeFactory---原生信息流"+ args.toString());
            return LingYeNativeView(context, viewId, mBinaryMessenger, args)
        }
    }
}