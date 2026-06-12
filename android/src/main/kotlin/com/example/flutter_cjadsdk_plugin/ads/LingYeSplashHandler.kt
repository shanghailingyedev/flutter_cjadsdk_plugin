import android.view.ViewGroup
import cj.mobile.CJSplash
import cj.mobile.listener.CJSplashListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LingYeSplashHandler {

    var splashAd: CJSplash? = null
    var params: Map<String, Any>? = null

    companion object {
        @Volatile
        private var instance: LingYeSplashHandler? = null
        fun getInstance(): LingYeSplashHandler {
            return instance ?: synchronized(this) {
                instance ?: LingYeSplashHandler().also { instance = it }
            }
        }
    }

    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method: String = call.method
        val flutterParams: Map<String, Any>? = call.arguments as? Map<String, Any>
        params = flutterParams
        when (method) {
            LingYeAdSdkMethodNames.loadAndShowSplashAd -> {
                loadAndShowSplashAd()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun loadAndShowSplashAd() {
        splashAd = CJSplash()
        val activity = LingYeTools.getActivity()
        val adId = params?.get("adId")
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


        val handle = BottomViewHandle()
        val model = LingYeBottomModel()
        params?.let { model.setupAdConfig(it) }
        handle.setupBottom(model)

        splashAd?.loadAd(activity, adId.toString(), handle.getWidth(), handle.getHeight(), object : CJSplashListener {
            override fun onShow() {
                map.put("code", 0)
                map.put("message", "展示成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.splashAdOnShow,
                    map
                )
            }

            override fun onError(s: String, s1: String) {
                map["code"] = -1
                map["message"] = s+s1
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.splashAdLoadFailed,
                    map
                )
            }

            override fun onLoad() {
                map.put("code", 0)
                map.put("message", "加载成功")
                (activity.window?.decorView as ViewGroup?)!!.removeView(handle.content)
                (activity.window?.decorView as? ViewGroup)!!.addView(handle.content)
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.splashAdLoadSuccess,
                    map
                )
                splashAd?.showAd(activity, handle.splashContent)
            }

            override fun onClick() {
                map.put("code", 0)
                map.put("message", "触发点击")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.splashAdOnClick,
                    map
                )
            }

            override fun onClose() {
                map.put("code", 0)
                map.put("message", "触发关闭")
                (activity.window?.decorView as ViewGroup?)!!.removeView(handle.content)
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.splashAdOnClose,
                    map
                )
            }
        })
    }

}