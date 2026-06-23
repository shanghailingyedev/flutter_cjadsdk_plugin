
import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';

import '../inits/lingye_setup_ad_config.dart';

class LingyeSeviceIconAd {

  LingYeIconConfigParams? params;
  CommonAdCallBack? eventCallBack;

  LingyeSeviceIconAd({required this.params, this.eventCallBack}) { 
        setMethodCallHandler();
  }

  void setMethodCallHandler() {
    FlutterCjadsdkPlugin.removeMethodCallHandler(LingyeAdRegisterHandlerKey.interstitialAdhandler);
    FlutterCjadsdkPlugin.addMethodCallHandler(LingyeAdRegisterHandlerKey.interstitialAdhandler,
      (call) async {
        print("flutter---进来了$call.method");
        final code = call.arguments["code"] as int;
        final msg = call.arguments["message"] as String;
        switch (call.method) {
          case LingyeAdCallBackEventName.iconAdLoadSuccess:
            eventCallBack?.onAdLoadSuccess?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.iconAdLoadFailed:
            eventCallBack?.onAdLoadFailure?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.iconAdOnShow:
            eventCallBack?.onAdShow?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.iconAdOnClick:
            eventCallBack?.onAdClick?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.iconAdOnClose:
            eventCallBack?.onAdClose?.call(code, msg);
            break;
        }
      },
    );
  }


    ///开屏广告加载调用
  void loadAndShow() async {
    await FlutterCjadsdkPlugin.invokeMethod(
      LingyeAdNativeFutureName.iconFuncName,
      params?.toMap()
    );
  }


}