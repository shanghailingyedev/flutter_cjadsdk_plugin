import Foundation
import Flutter
import CJMobileAd

class LingYeInterstitialHandler: NSObject {
    
    
    static let shared: LingYeInterstitialHandler = LingYeInterstitialHandler()
    
    var initParams: [String: Any] = [:]
    var interstitialAd: CJInterstitialAd?

    func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        initParams = call.arguments as? [String: Any] ?? [:]
        if call.method == LingYeAdSdkMethodNames.loadAndShowInterstitialAd {
            loadAndShowInterstitialAd()
            result(true)
        }
        result(nil)
    }

    func loadAndShowInterstitialAd() {
        interstitialAd = CJInterstitialAd(resourceId: initParams["adId"] as? String ?? "")
        interstitialAd?.delegate = self
        interstitialAd?.loadData()
    }
    
}


extension LingYeInterstitialHandler: CJInterstitialAdDelegate {
    
    func interstitialAdDidLoad(_ interstitialAd: CJInterstitialAd, resourceId: String) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.interstitialAdLoadSuccess, arguments: ["code": 0, "message": "插屏加载成功"])
        interstitialAd.show(fromRootViewController: LingYeTools.shared.currentViewController() ?? UIViewController());
    }
    
    func interstitialAdLoadFailed(_ interstitialAd: CJInterstitialAd, error: any Error) {
        let msg = error.localizedDescription
        let code = -1
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.interstitialAdLoadFailed, arguments: ["code": code, "message": msg])
    }
    
    func interstitialAd(onShow interstitialAd: CJInterstitialAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.interstitialAdOnShow, arguments: ["code": 0, "message": "插屏展示成功"])
    }
    
    func interstitialAd(onClicked interstitialAd: CJInterstitialAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.interstitialAdOnClick, arguments: ["code": 0, "message": "插屏触发点击"])
    }
    
    func interstitialAd(onClosed interstitialAd: CJInterstitialAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.interstitialAdOnClose, arguments: ["code": 0, "message": "插屏触发关闭"])
    }
    
    func interstitialAdChannel(onClicked interstitialAd: CJInterstitialAd, extraParams params: [AnyHashable : Any]) {}
    
    func interstitialAdChannel(onShow interstitialAd: CJInterstitialAd, extraParams params: [AnyHashable : Any]) {}
    
    
}
