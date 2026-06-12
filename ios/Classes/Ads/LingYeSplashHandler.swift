import Foundation
import Flutter
import CJMobileAd

class LingYeSplashHandler: NSObject {

    static let shared: LingYeSplashHandler = LingYeSplashHandler()
    
    var model: BottomModel?
    
    var splashAd: CJSplashAd?

    func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        model = BottomModel(adConfig: call.arguments as? [String : Any] ?? [:])
        if call.method == LingYeAdSdkMethodNames.loadAndShowSplashAd {
            loadAndShowSplashAd()
            result(true)
        }
        result(nil)
    }

    func loadAndShowSplashAd() {
        LingYeTools.shared.lyLog(msg: "开始调用开屏")
        DispatchQueue.main.async {
            let bottomView = LingYeBottomView.init(bottomModel: self.model)
            self.splashAd = CJSplashAd(resourceId: self.model?.adId as? String ?? "", rootViewController: LingYeTools.shared.currentViewController() ?? UIViewController(), customLogoView: bottomView)
            self.splashAd?.delegate = self
            self.splashAd?.loadData()
        }
    }
    
}

extension LingYeSplashHandler: CJSplashAdDelegate {
    
    func splashAdDidLoad(_ splashAd: CJSplashAd, resourceId: String) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.splashAdLoadSuccess, arguments: ["code": 0, "message": "开屏加载成功"])
        splashAd.show(to: LingYeTools.shared.lyGetCurrentWindow() ?? UIWindow())
    }
    
    func splashAdLoadFailed(_ splashAd: CJSplashAd, error: any Error) {
        let msg = error.localizedDescription
        let code = -1
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.splashAdLoadFailed, arguments: ["code": code, "message": msg])
    }
    
    func splashAd(onShow splashAd: CJSplashAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.splashAdOnShow, arguments: ["code": 0, "message": "开屏展示成功"])
    }
    
    func splashAd(onClicked splashAd: CJSplashAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.splashAdOnClick, arguments: ["code": 0, "message": "开屏触发点击"])
    }
    
    func splashAd(onClosed splashAd: CJSplashAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.splashAdOnClose, arguments: ["code": 0, "message": "开屏触发关闭"])
    }
}
