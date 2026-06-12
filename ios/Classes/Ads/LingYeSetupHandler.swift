import Foundation
import Flutter
import CJMobileAd

class LingYeSetupHandler: NSObject {

    static let shared: LingYeSetupHandler = LingYeSetupHandler()
    
    var initParams: [String: Any] = [:]

    func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        initParams = call.arguments as? [String: Any] ?? [:]
        if call.method == LingYeAdSdkMethodNames.initSDKFun {
            initSDK()
            result(true)
        }
        result(nil)
    }

    func initSDK() {
        LingYeTools.shared.lyLog(msg: "SDK开始初始化")
        guard let appId = initParams["appId"] as? String else {
            LingYeTools.shared.lyLog(msg: "appId不能为空")
            return
        }
        CJADManager.openDebugLog()
        CJADManager.configure(appId) { success, error in
            LingYeTools.shared.lyLog(msg: "SDK初始化状态回传")
            LingYeBaseRegister.shared.sendToFlutter(method: self.setupCallback(success: success), arguments: self.setupCallbackArguments(success: success, error: error as? NSError))
        };
        
    }
    
}

extension LingYeSetupHandler {
    
    func setupCallback(success: Bool) -> String {
        return success ? LingYeAdSdkCallBackMethodNames.setupSuccess : LingYeAdSdkCallBackMethodNames.setupFailed
    }
    
    func setupCallbackArguments(success: Bool, error: NSError?) -> [String: Any] {
        let code = success ? 0 : error?.code
        let message = success ? "初始化成功" : error.debugDescription
        return ["code": code ?? 0, "message": message];
    }
    
}
