package com.example.flutter_cjadsdk_plugin.Views

import LingYeBaseRegister
import LingYeTools
import android.content.Context
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.ViewTreeObserver
import android.widget.FrameLayout
import com.example.flutter_cjadsdk_plugin.FlutterCjadsdkPlugin
import com.example.flutter_cjadsdk_plugin.common.LingYeLocalData
import com.example.flutter_cjadsdk_plugin.common.dpToPx
import com.example.flutter_cjadsdk_plugin.common.pxToDp
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


class LingYeIconView(
    private val context: Context,
    viewId: Int,
    binaryMessenger: BinaryMessenger,
    args: Any?
) : PlatformView, MethodChannel.MethodCallHandler {
    private var contentView: FrameLayout
    private var nativeId: String? = null

    init {
        val params: Map<String, Any>? = args as? Map<String, Any>
        params?.get("nativeId")?.let { nativeId = it.toString() }
        contentView = createContentView(params)
    }
    private fun createContentView(params: Map<String, Any>?): FrameLayout {
        contentView = FrameLayout(context)
        return contentView
    }


    override fun getView(): FrameLayout {
        return contentView
    }

    override fun dispose() {
        contentView.removeAllViews()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    }
}