import Foundation
import Flutter
import CJMobileAd

class LingYeRewardVideoHandler: NSObject {
    
    static let shared: LingYeRewardVideoHandler = LingYeRewardVideoHandler()
    var initParams: [String: Any] = [:]
    var rewardVideoAd: CJRewardVideoAd?
    
    func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        initParams = call.arguments as? [String: Any] ?? [:]
        if call.method == LingYeAdSdkMethodNames.loadAndShowRewardVideoAd {
            loadAndShowRewardVideo()
            result(true)
        }
        result(nil)
    }

    func loadAndShowRewardVideo() {
        LingYeTools.shared.lyLog(msg: "开始调用激励视频")
        rewardVideoAd = CJRewardVideoAd(resourceId: initParams["adId"] as? String ?? "", userId: "", extend: "")
        rewardVideoAd?.delegate = self
        rewardVideoAd?.loadData()
    }
    
}

extension LingYeRewardVideoHandler: CJRewardVideoAdDelegate {
    
    func rewardVideo(onRewarded rewardAd: CJRewardVideoAd, requestId: String) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.rewardVideoAdBeRewarded, arguments: ["code": 0, "message": "激励视频达成奖励成功"])
    }
    
    func rewardVideoAdDidLoad(_ rewardAd: CJRewardVideoAd, resourceId: String) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.rewardVideoAdLoadSuccess, arguments: ["code": 0, "message": "激励视频加载成功"])
        rewardVideoAd?.show(fromRootViewController: LingYeTools.shared.currentViewController() ?? UIViewController())
    }
    
    func rewardVideoAd(onShow rewardAd: CJRewardVideoAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.rewardVideoAdOnShow, arguments: ["code": 0, "message": "激励视频展示成功"])
    }
    
    func rewardVideoAdLoadFailed(_ rewardAd: CJRewardVideoAd, error: any Error) {
        let msg = error.localizedDescription
        let code = -1
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.rewardVideoAdLoadFailed, arguments: ["code": code, "message": msg])
    }
    
    func rewardVideoAd(onClicked rewardAd: CJRewardVideoAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.rewardVideoAdOnClick, arguments: ["code": 0, "message": "激励视频触发点击"])
    }
    
    func rewardVideoAd(onClosed rewardAd: CJRewardVideoAd) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.rewardVideoAdOnClose, arguments: ["code": 0, "message": "激励视频触发关闭"])
    }
    
    func rewardVideoAdChannel(onClicked rewardAd: CJRewardVideoAd, extraParams params: [AnyHashable : Any]) {
        
    }
    
    func rewardVideoAdChannel(onShow rewardAd: CJRewardVideoAd, extraParams params: [AnyHashable : Any]) {
    }
}
