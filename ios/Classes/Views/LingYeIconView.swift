//
//  LingYeIconView.swift
//  flutter_cjadsdk_plugin
//
//  Created by 熊俊 on 2026/6/5.
//

import UIKit
import Flutter

class LingYeIconView: NSObject, FlutterPlatformView {
    
    let contentView = UIView()
    
    
    
    func view() -> UIView {
        return contentView
    }

}

class LingYeNativeViewFactory: NSObject,FlutterPlatformViewFactory {
    
    func initWithMessage(messenger: FlutterBinaryMessenger) {
        
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> any FlutterPlatformView {
        LingYeTools.shared.iconView = LingYeIconView();
        return LingYeTools.shared.iconView!;
    }
    
    
    
}
