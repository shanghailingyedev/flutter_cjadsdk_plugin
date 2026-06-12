import android.content.Context
import android.graphics.Point
import android.view.WindowManager
import cj.mobile.CJRewardVideo
import cj.mobile.listener.CJRewardListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LingYeRewardHandler {

    var params: Map<String, Any>? = null
    companion object {
        @Volatile
        private var instance: LingYeRewardHandler? = null
        fun getInstance(): LingYeRewardHandler {
            return instance ?: synchronized(this) {
                instance ?: LingYeRewardHandler().also { instance = it }
            }
        }
    }

    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method: String = call.method
        val flutterParams: Map<String, Any>? = call.arguments as? Map<String, Any>
        params = flutterParams
        when (method) {
            LingYeAdSdkMethodNames.loadAndShowRewardVideoAd -> {
                loadAndShowRewardVideoAd()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun loadAndShowRewardVideoAd() {
        val activity = LingYeTools.getActivity()
        val adId = params?.get("adId")
        val windowManager: WindowManager? = activity?.getSystemService(Context.WINDOW_SERVICE) as? WindowManager
        val display = windowManager?.defaultDisplay
        val size = Point()
        display?.getRealSize(size)
        val map: MutableMap<String, Any> = HashMap()

        CJRewardVideo.getInstance().setIsPreLoad(false).setMainActivity(activity).loadAd(adId.toString())
        CJRewardVideo.getInstance().setListener(object : CJRewardListener {
            override fun onShow() {
                map.put("code", 0)
                map.put("message", "激励视频展示成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.rewardVideoAdOnShow,
                    map
                )
            }

            override fun onError(s: String, s1: String) {
                map["code"] = -1
                map["message"] = s+s1
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.rewardVideoAdLoadFailed,
                    map
                )
            }

            override fun onClick() {
                map.put("code", 0)
                map.put("message", "激励视频展示成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.rewardVideoAdOnClick,
                    map
                )
            }

            override fun onClose() {
                map.put("code", 0)
                map.put("message", "激励视频触发关闭")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.rewardVideoAdOnClose,
                    map
                )
            }

            override fun onVideoEnd() {
            }

            override fun onLoad() {
                map.put("code", 0)
                map.put("message", "激励视频加载成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.rewardVideoAdLoadSuccess,
                    map
                )
                CJRewardVideo.getInstance().showAd(activity)
            }

            override fun onVideoStart() {

            }
            override fun onReward(s: String) {
                map.put("code", 0)
                map.put("message", "激励视频达成奖励")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.rewardVideoAdBeRewarded,
                    map
                )
            }
        })
    }

}