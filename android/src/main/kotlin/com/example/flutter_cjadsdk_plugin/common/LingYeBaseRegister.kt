import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class LingYeBaseRegister private constructor() : MethodCallHandler {

    private var channel: MethodChannel? = null

    companion object {
        private var sInstance: LingYeBaseRegister? = null
        fun getInstance(): LingYeBaseRegister {
            return sInstance ?: synchronized(this) {
                sInstance ?: LingYeBaseRegister().also { sInstance = it }
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.e("cj-log", "开始调用事件： " + call.method)
        when(call.method){
            LingYeAdSdkMethodNames.initSDKFun -> {
                LingYeSetupHandler.getInstance().handleMethodCall(call, result)
            }
            LingYeAdSdkMethodNames.loadAndShowSplashAd -> {
                LingYeSplashHandler.getInstance().handleMethodCall(call, result)
            }
            LingYeAdSdkMethodNames.loadAndShowInterstitialAd -> {
                LingYeInterstitialHandler.getInstance().handleMethodCall(call, result)
            }
            LingYeAdSdkMethodNames.loadAndShowRewardVideoAd -> {
                LingYeRewardHandler.getInstance().handleMethodCall(call, result)
            }
            LingYeAdSdkMethodNames.loadIconAd -> {
                LingYeIconHandler.getInstance().handleMethodCall(call, result)
            }
        }
    }

    fun init(binaryMessenger: BinaryMessenger) {
        if (channel == null) {
            channel = MethodChannel(binaryMessenger, "flutter_cjadsdk_plugin")
            channel?.setMethodCallHandler(this)
        }
    }

    fun sendMessageToFlutter(method: String, args: Any?) {
        LingYeTools.runOnThread {
            channel?.invokeMethod(method, args)
        }
    }


}