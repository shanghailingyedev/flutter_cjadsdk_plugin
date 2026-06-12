import android.util.Log
import android.view.View
import android.view.ViewGroup
import cj.mobile.CJNativeExpress
import cj.mobile.listener.CJNativeExpressListener
import com.example.flutter_cjadsdk_plugin.common.LingYeLocalData
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LingYeNativeHandler {

    var nativeAd: CJNativeExpress? = null
    var params: Map<String, Any>? = null

    companion object {
        @Volatile
        private var instance: LingYeNativeHandler? = null
        fun getInstance(): LingYeNativeHandler {
            return instance ?: synchronized(this) {
                instance ?: LingYeNativeHandler().also { instance = it }
            }
        }
    }

    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method: String = call.method
        val flutterParams: Map<String, Any>? = call.arguments as? Map<String, Any>
        Log.e("cj-log", "开始调用CC" + flutterParams.toString())
        params = flutterParams
        when (method) {
            LingYeAdSdkMethodNames.loadNativeAd -> {
                loadAndShowNativeAd()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun loadAndShowNativeAd() {
        nativeAd = CJNativeExpress()
        val activity = LingYeTools.getActivity()
        val adId = params?.get("adId") as? String
        val map: MutableMap<String, Any> = HashMap()

        var content = activity?.findViewById<ViewGroup>(android.R.id.content)
        if (activity == null || content == null) {
            map["code"] = -1
            map["message"] = "activity或者content为空，请检查请求时机"
            LingYeBaseRegister.getInstance().sendMessageToFlutter(
                LingYeAdSdkCallBackMethodNames.splashAdLoadFailed,
                map
            )
            return
        }

        nativeAd?.loadAd(activity, 300, 1, adId, object : CJNativeExpressListener {
            override fun onShow(p0: View?) {
                map["height"] = (p0 as View).height
                map.put("code", 0)
                map.put("message", "信息流已经展示")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.nativeAdOnShow,
                    map
                )
            }

            override fun onError(p0: String?, p1: String?) {
                map.put("code", -1)
                map.put("message", p0 + p1)
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.nativeAdLoadFailed,
                    map
                )
            }

            override fun onClick(p0: View?) {
                map.put("code", 0)
                map.put("message", "信息流触发点击")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.nativeAdOnClick,
                    map
                )
            }

            override fun onClose(p0: View?) {
                map.put("code", 0)
                map.put("message", "信息流触发关闭")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.nativeAdOnClose,
                    map
                )
            }

            override fun loadSuccess(p0: View?) {
                map.put("code", 0)
                map.put("message", "信息流加载成功")
                if (p0 != null) {
                    LingYeLocalData.getInstance().addNativeAdForId(params?.get("nativeId").toString(), p0)
                }
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.nativeAdLoadSuccess,
                    map
                )
            }
        })
    }

}