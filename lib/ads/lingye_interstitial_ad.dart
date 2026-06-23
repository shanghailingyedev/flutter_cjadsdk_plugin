import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';


class LingyeInterstitialAd {

  String? adId;
  CommonAdCallBack? eventCallBack;

  LingyeInterstitialAd({required this.adId, this.eventCallBack}) { 
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
          case LingyeAdCallBackEventName.interstitialAdLoadSuccess:
            eventCallBack?.onAdLoadSuccess?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.interstitialAdLoadFailed:
            eventCallBack?.onAdLoadFailure?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.interstitialAdOnShow:
            eventCallBack?.onAdShow?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.interstitialAdOnClick:
            eventCallBack?.onAdClick?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.interstitialAdOnClose:
            eventCallBack?.onAdClose?.call(code, msg);
            break;
        }
      },
    );
  }


    ///开屏广告加载调用
  void loadAndShow() async {
    await FlutterCjadsdkPlugin.invokeMethod(
      LingyeAdNativeFutureName.interstitialFuncName,
      {
        "adId": adId
      });
  }


}