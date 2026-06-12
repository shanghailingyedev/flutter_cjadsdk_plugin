import Foundation
import Flutter

class LingYeBaseRegister: NSObject {

    var registrar: FlutterPluginRegistrar?
    var channel: FlutterMethodChannel?
    static let shared: LingYeBaseRegister = LingYeBaseRegister()
    override init() {
        super.init()
    }
    
    func registrar(register: FlutterPluginRegistrar) -> Void {
        self.registrar = register
        
        channel = FlutterMethodChannel(name: "flutter_cjadsdk_plugin", binaryMessenger: register.messenger())
        channel?.setMethodCallHandler { methodCall, result in
            print("事件" + methodCall.method)
            switch methodCall.method {
            case LingYeAdSdkMethodNames.initSDKFun:
                LingYeSetupHandler.shared.handleMethodCall(methodCall, result: result)
            case LingYeAdSdkMethodNames.loadAndShowSplashAd:
                 LingYeSplashHandler.shared.handleMethodCall(methodCall, result: result)
            case LingYeAdSdkMethodNames.loadAndShowInterstitialAd:
                LingYeInterstitialHandler.shared.handleMethodCall(methodCall, result: result)
            case LingYeAdSdkMethodNames.loadAndShowRewardVideoAd:
                LingYeRewardVideoHandler.shared.handleMethodCall(methodCall, result: result)
            case LingYeAdSdkMethodNames.loadNativeAd:
                LingYeNativeHandler.shared.handleMethodCall(methodCall, result: result)
            case LingYeAdSdkMethodNames.loadIconAd:
                LingYeIconHandler.shared.handleMethodCall(methodCall, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    func sendToFlutter(method: String, arguments: Any) {
        DispatchQueue.main.async {
            self.channel?.invokeMethod(method, arguments: arguments)
        }
    }
    
}
