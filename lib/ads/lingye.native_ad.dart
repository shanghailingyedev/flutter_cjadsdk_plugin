
import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';

import '../inits/lingye_setup_ad_config.dart';

class LingyeNativeAd {

  LingYeNativeParams? params;
  CommonAdCallBack? eventCallBack;

  LingyeNativeAd({required this.params, this.eventCallBack}) { 
        setMethodCallHandler();
  }

  void setMethodCallHandler() {
    FlutterCjadsdkPlugin.removeMethodCallHandler(LingyeAdRegisterHandlerKey.nativeAdhandler);
    FlutterCjadsdkPlugin.addMethodCallHandler(LingyeAdRegisterHandlerKey.nativeAdhandler,
      (call) async {
        print("flutter---进来了$call.method");
        final code = call.arguments["code"] as int;
        final height = call.arguments["height"] as int;
        final msg = call.arguments["message"] as String;

        switch (call.method) {
          case LingyeAdCallBackEventName.nativeAdLoadSuccess:
            eventCallBack?.onAdLoadSuccess?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.nativeAdLoadFailed:
            eventCallBack?.onAdLoadFailure?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.nativeAdOnShow:
          {
            print("flutter---曝光事件$code----$height----$msg");
            eventCallBack?.onAdShow?.call(code, msg);
            eventCallBack?.onAdViewHeightChange?.call(height);
          }
            break;
          case LingyeAdCallBackEventName.nativeAdOnClick:
            eventCallBack?.onAdClick?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.nativeAdOnClose:
            eventCallBack?.onAdClose?.call(code, msg);
            break;
        }
      },
    );
  }


    ///开屏广告加载调用
  void loadAndShow() async {
    await FlutterCjadsdkPlugin.invokeMethod(
      LingyeAdNativeFutureName.nativeFuncName,
      params?.toMap()
    );
  }


}