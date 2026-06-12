import Foundation
import Flutter

class LingYeNativeHandler: NSObject {

    
    static let shared: LingYeNativeHandler = LingYeNativeHandler()
    
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
        print("---进来信息流了----");
    }
    
}
