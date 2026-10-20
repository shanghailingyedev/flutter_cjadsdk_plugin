//
//  LingYeTools.swift
//  flutter_cjadsdk_plugin
//
//  Created by 熊俊 on 2026/3/31.
//
import UIKit

class LingYeTools: NSObject {
    
    var iconView: LingYeIconView?
    
    var nativeView: LingYeIconView?
    
    static let shared: LingYeTools = LingYeTools()
    
    func lyLog(msg: String) {
        print("cj-log-native" + msg)
    }
    
    /// 获取当前控制器
    /// - Returns: 当前控制器
    func currentViewController() -> UIViewController? {
        var topController = lyGetCurrentWindow()?.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        // 处理导航控制器
        if let navigationController = topController as? UINavigationController {
            topController = navigationController.visibleViewController
        }
        // 处理标签控制器
        if let tabBarController = topController as? UITabBarController {
            topController = tabBarController.selectedViewController
        }
        return topController
    }
    
    /// 获取当前window
    /// - Returns: 当前window
    func lyGetCurrentWindow() -> UIWindow? {
        // iOS 15.0 及以上：UIWindowScene 直接提供了 keyWindow 属性
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first(where: { $0.activationState == .foregroundActive })?
                .keyWindow
        } 
        // iOS 13.0 - 14.x：需要遍历 windows 数组查找 isKeyWindow
        else if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first(where: { $0.activationState == .foregroundActive })?
                .windows
                .first(where: { $0.isKeyWindow })
        } 
        // iOS 12 及以下：使用已废弃但有效的 keyWindow 属性
        else {
            return UIApplication.shared.keyWindow
        }
    }

    func lyHexString(hexString: String) -> UIColor? {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        let a = CGFloat(1.0) // Alpha默认为1.0，可以根据需要调整
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
}


