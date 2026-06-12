import android.app.Application
import android.content.Context
import android.util.Log
import cj.mobile.CJMobileAd
import cj.mobile.listener.CJInitListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
class LingYeSetupHandler {

    var params: Map<String, Any>? = null

    companion object {
        @Volatile
        private var instance: LingYeSetupHandler? = null
        fun getInstance(): LingYeSetupHandler {
            return instance ?: synchronized(this) {
                instance ?: LingYeSetupHandler().also { instance = it }
            }
        }
    }

    fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method: String = call.method
        val flutterParams: Map<String, Any>? = call.arguments as? Map<String, Any>
        params = flutterParams
        when (method) {
            LingYeAdSdkMethodNames.initSDKFun -> {
                initSDK()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    fun initSDK() {
        val application: Context? = LingYeTools.getApplicationContext()
        CJMobileAd.privacyCompliance(application as Application?, true)
        //防止上架后台读取应用后台（vivo）
        CJMobileAd.isCanUseAppList(false)
        if (params?.get("appId") !== null) {
            val map: MutableMap<String, Any> = HashMap()
            CJMobileAd.init(application, params?.get("appId") as? String, object : CJInitListener {
                override fun initFailed(errorMsg: String) {
                    map.put("code", -1)
                    map.put("message", errorMsg)
                    LingYeBaseRegister.getInstance().sendMessageToFlutter(
                        LingYeAdSdkCallBackMethodNames.setupFailed,
                        map
                    )
                }
                override fun initSuccess() {
                    map.put("code", 0)
                    map.put("message", "初始化成功")
                    LingYeBaseRegister.getInstance().sendMessageToFlutter(
                        LingYeAdSdkCallBackMethodNames.setupSuccess,
                        map
                    )
                }
            })
        } else {

        }
    }

}