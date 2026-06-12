package com.example.flutter_cjadsdk_plugin.ads

import LingYeTools
import android.content.Context
import android.util.Log
import com.example.flutter_cjadsdk_plugin.Views.LingYeIconView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class LingYeIconFactory {

    class NativeFactory(binaryMessenger: BinaryMessenger, instance: StandardMessageCodec) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
        private val mBinaryMessenger: BinaryMessenger = binaryMessenger
        override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
            Log.e("cj-log",  "LingYeIconFactory---Icon"+ args.toString());
            val iconView = LingYeIconView(context, 1, mBinaryMessenger, args)
            LingYeTools.setIconContentView(iconView);
            return iconView
        }
    }
}