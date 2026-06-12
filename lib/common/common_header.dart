//  注册各种类型handler

class LingyeAdRegisterHandlerKey {

  static const setupAdhandler = "setup_ad_handler"; // 初始化handler
  static const splashAdhandler = "splash_ad_handler"; // 开屏handler
  static const interstitialAdhandler = "interstitial_ad_handler"; // 插屏handler
  static const nativeAdhandler = "native_ad_handler"; // 信息流handler
  static const rewardVideoAdhandler = "reward_ad_handler"; // 激励视频handler

}

// 原生方法名
class LingyeAdNativeFutureName {

  static const setupFuncName = "cjSdkSetup"; // 广告sdk初始化
  static const preReward = "preReward"; // 广告sdk初始化
  static const splashFuncName = "cjLoadAndShowSplashMethod"; // 广告sdk初始化
  static const rewardVideoFuncName = "cjLoadAndShowRewardVideoMethod"; // 广告sdk初始化
  static const interstitialFuncName = "cjLoadAndShowInterstitialAdMethod"; // 广告sdk初始化
  static const nativeFuncName = "cjLoadAndShowNativeAdMethod"; // 广告sdk初始化
  static const iconFuncName = "cjLoadAndShowIconMethod"; // 广告sdk初始化

}

// 回调事件名
class LingyeAdCallBackEventName {
  
  // 初始化相关回调
  static const setupSuccess = "setupSuccess"; // 初始化成功
  static const setupFailed  = "setupFailed";   // 初始化失败

  // 开屏广告位回调
  static const splashAdLoadSuccess = "splashAdLoadSuccess";  // 加载成功
  static const splashAdLoadFailed  = "splashAdLoadFailed";   // 加载失败
  static const splashAdOnShow      = "splashAdOnShow";       // 已经显示
  static const splashAdOnClick     = "splashAdOnClick";      // 点击事件
  static const splashAdOnClose     = "splashAdOnClose";      // 关闭事件

  // 激励视频相关回调
  static const rewardVideoAdBeRewarded  = "rewardVideoAdBeRewarded";  // 达成奖励
  static const rewardVideoAdLoadSuccess = "rewardVideoAdLoadSuccess";  // 加载成功
  static const rewardVideoAdLoadFailed  = "rewardVideoAdLoadFailed";   // 加载失败
  static const rewardVideoAdOnShow      = "rewardVideoAdOnShow";       // 已经显示
  static const rewardVideoAdOnClick     = "rewardVideoAdOnClick";      // 点击事件
  static const rewardVideoAdOnClose     = "rewardVideoAdOnClose";      // 关闭事件

  // 插屏视频相关回调
  static const interstitialAdLoadSuccess = "interstitialAdLoadSuccess";   // 加载成功
  static const interstitialAdLoadFailed  = "interstitialAdLoadFailed";    // 加载失败
  static const interstitialAdOnShow      = "interstitialAdOnShow";        // 已经显示
  static const interstitialAdOnClick     = "interstitialAdOnClick";       // 点击事件
  static const interstitialAdOnClose     = "interstitialAdOnClose";       // 关闭事件

  // 全屏视频相关回调
  static const fullscreenVideoAdLoadSuccess = "fullscreenVideoAdLoadSuccess";   // 加载成功
  static const fullscreenVideoAdLoadFailed  = "fullscreenVideoAdLoadFailed";    // 加载失败
  static const fullscreenVideoAdOnShow      = "fullscreenVideoAdOnShow";        // 已经显示
  static const fullscreenVideoAdOnClick     = "fullscreenVideoAdOnClick";       // 点击事件
  static const fullscreenVideoAdOnClose     = "fullscreenVideoAdOnClose";       // 关闭事件

  // 信息流相关回调
  static const nativeAdLoadSuccess = "nativeAdLoadSuccess";   // 加载成功
  static const nativeAdLoadFailed  = "nativeAdLoadFailed";    // 加载失败
  static const nativeAdOnShow      = "nativeAdOnShow";        // 已经显示
  static const nativeAdOnClick     = "nativeAdOnClick";       // 点击事件
  static const nativeAdOnClose     = "nativeAdOnClose";       // 关闭事件

  // ICON广告位回调
  static const iconAdLoadSuccess = "iconAdLoadSuccess";  // 加载成功
  static const iconAdLoadFailed  = "iconAdLoadFailed";   // 加载失败
  static const iconAdOnShow      = "iconAdOnShow";       // 已经显示
  static const iconAdOnClick     = "iconAdOnClick";      // 点击事件
  static const iconAdOnClose     = "iconAdOnClose";      // 关闭事件
}

typedef LingyeAdCallBackFun = void Function(int code, String message);

class CommonAdCallBack {
  LingyeAdCallBackFun? onAdLoadSuccess;
  LingyeAdCallBackFun? onAdLoadFailure;
  LingyeAdCallBackFun? onAdShow;
  LingyeAdCallBackFun? onAdClick;
  LingyeAdCallBackFun? onAdClose;
  LingyeAdCallBackFun? onAdReward;
  CommonAdCallBack({this.onAdLoadSuccess, this.onAdLoadFailure, this.onAdShow, this.onAdClick, this.onAdClose, this.onAdReward});
}

class CommonInitCallBack {
  final LingyeAdCallBackFun? success;
  final LingyeAdCallBackFun? failed;
  CommonInitCallBack({this.success, this.failed});
}
