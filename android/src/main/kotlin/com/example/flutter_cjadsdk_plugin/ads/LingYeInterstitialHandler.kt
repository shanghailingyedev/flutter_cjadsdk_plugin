import android.content.Context
import android.graphics.Point
import android.util.DisplayMetrics
import android.view.ViewGroup
import android.view.WindowManager
import cj.mobile.CJInterstitial
import cj.mobile.CJSplash
import cj.mobile.listener.CJInterstitialListener
import cj.mobile.listener.CJSplashListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LingYeInterstitialHandler {

    var interstitialAd: CJInterstitial? = null
    var params: Map<String, Any>? = null

    companion object {
        @Volatile
        private var instance: LingYeInterstitialHandler? = null
        fun getInstance(): LingYeInterstitialHandler {
            return instance ?: synchronized(this) {
                instance ?: LingYeInterstitialHandler().also { instance = it }
            }
        }
    }

    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method: String = call.method
        val flutterParams: Map<String, Any>? = call.arguments as? Map<String, Any>
        params = flutterParams
        when (method) {
            LingYeAdSdkMethodNames.loadAndShowInterstitialAd -> {
                loadAndShowInterstitialAd()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun loadAndShowInterstitialAd() {
        interstitialAd = CJInterstitial()
        val activity = LingYeTools.getActivity()
        val adId = params?.get("adId")
        val windowManager: WindowManager? = activity?.getSystemService(Context.WINDOW_SERVICE) as? WindowManager
        val display = windowManager?.defaultDisplay
        val size = Point()
        display?.getRealSize(size)
        val map: MutableMap<String, Any> = HashMap()
        interstitialAd?.loadAd(activity, adId.toString(), object : CJInterstitialListener {
            override fun onShow() {
                map.put("code", 0)
                map.put("message", "插屏展示成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.interstitialAdOnShow,
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
                map.put("message", "插屏加载成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.interstitialAdLoadSuccess,
                    map
                )
                interstitialAd?.showAd(activity)
            }

            override fun onClick() {
                map.put("code", 0)
                map.put("message", "插屏触发点击")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.interstitialAdOnClick,
                    map
                )
            }

            override fun onClose() {
                map.put("code", 0)
                map.put("message", "插屏触发关闭")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.interstitialAdOnClose,
                    map
                )
            }
        })
    }

}