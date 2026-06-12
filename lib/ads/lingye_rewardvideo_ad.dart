import 'dart:ffi';

import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';

import '../common/common_header.dart';
import '../flutter_cjadsdk_plugin.dart';

class LingyeRewardvideoAd {

  String? adId;
  CommonAdCallBack? eventCallBack;

  LingyeRewardvideoAd({required this.adId, this.eventCallBack}) { 
        setMethodCallHandler();
  }

  void setMethodCallHandler() {
    FlutterCjadsdkPlugin.removeMethodCallHandler(LingyeAdRegisterHandlerKey.rewardVideoAdhandler);
    FlutterCjadsdkPlugin.addMethodCallHandler(LingyeAdRegisterHandlerKey.rewardVideoAdhandler,
      (call) async {
        print("flutter---进2$call.method");
        final code = call.arguments["code"] as int;
        final msg = call.arguments["message"] as String;
        switch (call.method) {
          case LingyeAdCallBackEventName.rewardVideoAdLoadSuccess:
            eventCallBack?.onAdLoadSuccess?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.rewardVideoAdLoadFailed:
            eventCallBack?.onAdLoadFailure?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.rewardVideoAdOnShow:
            eventCallBack?.onAdShow?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.rewardVideoAdOnClick:
            eventCallBack?.onAdClick?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.rewardVideoAdOnClose:
            eventCallBack?.onAdClose?.call(code, msg);
            break;
          case LingyeAdCallBackEventName.rewardVideoAdBeRewarded:
            eventCallBack?.onAdReward?.call(code, msg);
            break;
        }
      },
    );
  }


    ///激励广告加载调用
  void loadAndShow() async {
    await FlutterCjadsdkPlugin.invokeMethod(
      LingyeAdNativeFutureName.rewardVideoFuncName,
      {
        "adId": adId
      });
  }


}