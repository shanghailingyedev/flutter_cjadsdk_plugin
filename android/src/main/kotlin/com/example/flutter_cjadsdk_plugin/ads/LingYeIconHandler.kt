import android.content.Context
import android.graphics.Point
import android.view.View
import android.view.WindowManager
import cj.mobile.CJIcon
import cj.mobile.listener.CJIconListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class LingYeIconHandler {

    var iconAd: CJIcon? = null
    var params: Map<String, Any>? = null

    companion object {
        @Volatile
        private var instance: LingYeIconHandler? = null
        fun getInstance(): LingYeIconHandler {
            return instance ?: synchronized(this) {
                instance ?: LingYeIconHandler().also { instance = it }
            }
        }
    }

    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method: String = call.method
        val flutterParams: Map<String, Any>? = call.arguments as? Map<String, Any>
        params = flutterParams
        when (method) {
            LingYeAdSdkMethodNames.loadIconAd -> {
                loadAndShowIcon()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun loadAndShowIcon() {
        iconAd = CJIcon()
        val activity = LingYeTools.getActivity()
        val adId = params?.get("adId")
        val isShowClose = (params?.get("isShowClose") == 1)
        val map: MutableMap<String, Any> = HashMap()
        iconAd?.setIsShowClose(isShowClose)?.setIsShowFullPage(true)?.setIsVerticalPage(true)?.loadAd(activity, adId.toString(), object : CJIconListener {
            override fun loadSuccess(p0: View?) {
                LingYeTools.getIconContentView()?.view?.visibility = View.VISIBLE
                LingYeTools.getIconContentView()?.view?.addView(p0)
                map.put("code", 0)
                map.put("message", "icon加载成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.iconAdLoadSuccess,
                    map
                )
            }

            override fun onShow() {
                map.put("code", 0)
                map.put("message", "icon展示成功")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.iconAdOnShow,
                    map
                )
            }

            override fun onError(p0: String?, p1: String?) {
                map["code"] = -1
                map["message"] = p0+p1
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.iconAdLoadFailed,
                    map
                )
            }

            override fun onClick() {
                map.put("code", 0)
                map.put("message", "icon触发点击")
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.iconAdOnClick,
                    map
                )
            }

            override fun onClose() {
                map.put("code", 0)
                map.put("message", "icon关闭")
                LingYeTools.getIconContentView()?.view?.removeAllViews()
                LingYeTools.getIconContentView()?.view?.visibility = View.GONE
                LingYeBaseRegister.getInstance().sendMessageToFlutter(
                    LingYeAdSdkCallBackMethodNames.iconAdOnClose,
                    map
                )
            }

        })
    }

}