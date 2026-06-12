import Flutter
import UIKit

public class FlutterCjadsdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      LingYeBaseRegister.shared.registrar(register: registrar);
      registrar.register(LingYeNativeViewFactory(), withId: LingYeAdSdNativeViewNames.iconContentRegisterKey)
  }

//  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//    switch call.method {
//    case "getPlatformVersion":
//      result("iOS " + UIDevice.current.systemVersion)
//    default:
//      result(FlutterMethodNotImplemented)
//    }
//  }
}
