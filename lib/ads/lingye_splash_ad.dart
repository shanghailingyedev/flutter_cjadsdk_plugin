import 'dart:ffi';

import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';
import 'package:flutter_cjadsdk_plugin/inits/lingye_setup_ad_config.dart';

class LingyeSplashAd {

  LingYeSplashConfigParams? adConfig;
  CommonAdCallBack? eventCallBack;

  LingyeSplashAd({required this.adConfig, this.eventCallBack}) { 
        setMethodCallHandler();
  }

  void setMethodCallHandler() {
    FlutterCjadsdkPlugin.removeMethodCallHandler(LingyeAdRegisterHandlerKey.splashAdhandler);
    FlutterCjadsdkPlugin.addMethodCallHandler(LingyeAdRegisterHandlerKey.splashAdhandler,
      (call) async {
        print("flutter---进来了$call.method");
        final code = call.arguments["code"] as int;
        final msg = call.arguments["message"] as String;
        switch (call.method) {
          case LingyeAdCallBackEventName.splashAdLoadSuccess:
            eventCallBack?.onAdLoadSuccess?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.splashAdLoadFailed:
            eventCallBack?.onAdLoadFailure?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.splashAdOnShow:
            eventCallBack?.onAdShow?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.splashAdOnClick:
            eventCallBack?.onAdClick?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.splashAdOnClose:
            eventCallBack?.onAdClose?.call(code, msg);
            break;
        }
      },
    );
  }

    ///开屏广告加载调用
  void loadAndShow() async {
    var adId = adConfig?.adId;
    
     print("flutter---进来1123了$adId");
    await FlutterCjadsdkPlugin.invokeMethod(
      LingyeAdNativeFutureName.splashFuncName,
      adConfig?.toMap()
    );
  }


}