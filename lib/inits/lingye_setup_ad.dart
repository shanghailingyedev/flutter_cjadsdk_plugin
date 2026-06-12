import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';
import 'package:flutter_cjadsdk_plugin/inits/lingye_setup_ad_config.dart';

class LingyeSetupAd {

  LingyeSetupAd();
  static Future<void> init(LingyeSetupAdConfig sdkConfig,CommonInitCallBack initCallBack) async {
    FlutterCjadsdkPlugin.removeMethodCallHandler(LingyeAdRegisterHandlerKey.setupAdhandler);
    FlutterCjadsdkPlugin.addMethodCallHandler(LingyeAdRegisterHandlerKey.setupAdhandler,
      (call) async {
        print("flutter---进来了$call.method");
        final code = call.arguments["code"] as int;
        final msg = call.arguments["message"] as String;
        switch (call.method) {
          case LingyeAdCallBackEventName.setupSuccess:
            initCallBack.success?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.setupFailed:
            initCallBack.failed?.call(code, msg);
            break;
        }
      });
    // 调用原生
    await FlutterCjadsdkPlugin.invokeMethod(
      LingyeAdNativeFutureName.setupFuncName,
      sdkConfig.toMap()
    );
  }


  
}