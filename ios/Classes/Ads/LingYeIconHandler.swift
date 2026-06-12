//
//  LingYeIconHandler.swift
//  flutter_cjadsdk_plugin
//
//  Created by 熊俊 on 2026/6/5.
//

import UIKit
import Flutter
import CJMobileAd

class LingYeIconHandler: NSObject {
    
    static let shared: LingYeIconHandler = LingYeIconHandler()
    var initParams: [String: Any] = [:]
    var serviceAd: CJServiceAd?
    
    func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        initParams = call.arguments as? [String: Any] ?? [:]
        if call.method == LingYeAdSdkMethodNames.loadIconAd {
            loadAndShowIconAd()
            result(true)
        }
        result(nil)
    }
    
    func loadAndShowIconAd() {
        let adId = initParams["adId"] as? String ?? ""
        let size = CGSize(width: initParams["width"] as? Int ?? 0, height: initParams["height"] as? Int ?? 0)
        serviceAd = CJServiceAd(slotId: adId, size: size, refreshTime: 60, rootViewController: LingYeTools.shared.currentViewController() ?? UIViewController())
        serviceAd?.isShowClose = (initParams["isShowClose"] as? Int ?? 0 == 1);
        serviceAd?.delegate = self;
        serviceAd?.loadData()
    }
}

extension LingYeIconHandler: CJServiceAdDelegate {
    
    func iconExpressAdDidLoad(_ serviceAd: Any, views serviceView: UIView) {
        if ((LingYeTools.shared.iconView?.view()) != nil) {
            serviceView.backgroundColor = .clear;
            LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.iconAdLoadSuccess, arguments: ["code": 0, "message": "icon加载成功"])
            LingYeTools.shared.iconView?.view().frame = serviceView.bounds;
            LingYeTools.shared.iconView?.view().addSubview(serviceView);
            
        } else {
            LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.iconAdLoadFailed, arguments: ["code": 0, "message": "icon容器意外位nil"]);
        }
    }
    
    func iconExpressAd(onShow serviceView: Any) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.iconAdOnShow, arguments: ["code": 0, "message": "icon展示成功"])
    }
    
    func iconExpressAdLoadFailed(_ serviceAd: Any, error: any Error) {
        var msg = "icon加载失败"
        if (error.localizedDescription.count > 0) {
            msg = error.localizedDescription
        }
        let code = -1
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.iconAdLoadFailed, arguments: ["code": code, "message": msg])
    }
    
    func iconExpressAd(onClicked serviceAd: Any) {
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.iconAdOnClick, arguments: ["code": 0, "message": "icon广告触发点击"])
    }
    
    func iconExpressAd(onClosed serviceAd: Any) {
        if ((LingYeTools.shared.iconView?.view().superview) != nil) {
            LingYeTools.shared.iconView?.view().removeFromSuperview()
        }
        LingYeBaseRegister.shared.sendToFlutter(method: LingYeAdSdkCallBackMethodNames.iconAdOnClose, arguments: ["code": 0, "message": "icon广告关闭"])
    }
    
}
