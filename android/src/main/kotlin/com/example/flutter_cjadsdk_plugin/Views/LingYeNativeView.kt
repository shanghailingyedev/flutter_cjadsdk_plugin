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


class LingYeNativeView(
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
        addAdViewToContent()


    }
    private fun createContentView(params: Map<String, Any>?): FrameLayout {
        val nativeWidth: Double? = params?.get("width") as? Double
        return FrameLayout(context).apply {
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
            )
            val screenWidthPx = LingYeTools.getScreenSize().x
            if (nativeWidth == null) {
                val adViewParams = FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    FrameLayout.LayoutParams.WRAP_CONTENT
                ).apply {
                    gravity = Gravity.CENTER
                }
                tag = adViewParams
            } else {
                val nativeWidthPx = nativeWidth.toInt().dpToPx(context)
                val adViewWidth = nativeWidthPx.coerceAtMost(screenWidthPx)
                val adViewParams = FrameLayout.LayoutParams(
                    adViewWidth,
                    FrameLayout.LayoutParams.WRAP_CONTENT
                ).apply {
                    gravity = Gravity.CENTER
                }
                tag = adViewParams
            }
        }
    }

    private fun addAdViewToContent() {
        val nativeId = this.nativeId ?: return
        runCatching {
            Log.e("cj-log", "success to add ad view for nativeId: $nativeId")
            val nativeView = LingYeLocalData.getInstance().getAdView(nativeId)
            val params = contentView.tag as? FrameLayout.LayoutParams
            Log.e("cj-log", "success to add ad view for nativeId: $params")
            Log.e("cj-log", "success to add ad view for nativeId: $nativeView")
            if (nativeView != null && params != null) {
                Log.e("cj-log", "进来了")
                (nativeView.parent as? FrameLayout)?.removeView(nativeView)
                nativeView.layoutParams = params
                contentView.addView(nativeView)
                observeNativeViewSize(nativeView)
            }
        }.onFailure {
            Log.e("CJMobile", "Failed to add ad view for nativeId: $nativeId", it)
        }
    }

    private fun observeNativeViewSize(nativeView: View) {
        // 避免重复添加监听
        nativeView.viewTreeObserver.addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {
            override fun onGlobalLayout() {

                val width = nativeView.width
                val height = nativeView.height
                Log.e("cj-log", "回调高度的地方")
                if (width > 0 && height > 0) {
                    Log.e("cj-log", "回调高度的地方1")
                    val map: MutableMap<String, Any> = HashMap()
                    map.put("width", width.pxToDp(context))
                    map.put("height", height.pxToDp(context))
                    nativeId?.let { map.put("nativeId", it) }
                    LingYeBaseRegister.getInstance().sendMessageToFlutter(LingYeAdSdkCallBackMethodNames.nativeAdLoadUpdateSize, map)
                    nativeView.viewTreeObserver.removeOnGlobalLayoutListener(this)
                }
            }
        })
    }

    override fun getView(): View {
        return contentView
    }

    override fun dispose() {
        contentView.removeAllViews()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        TODO("Not yet implemented")
    }
}