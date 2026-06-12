/// 广告SDK提供方法名
enum LingYeAdSdkMethodNames {
    // SDK初始化
    static let initSDKFun = "cjSdkSetup"
    static let loadAndShowSplashAd = "cjLoadAndShowSplashMethod"
    static let loadAndShowInterstitialAd = "cjLoadAndShowInterstitialAdMethod"
    static let loadAndShowRewardVideoAd = "cjLoadAndShowRewardVideoMethod"
    static let loadNativeAd = "cjLoadAndShowNativeAdMethod"
    static let loadIconAd = "cjLoadAndShowIconMethod"
}

/// 回传方法名
class LingYeAdSdkCallBackMethodNames: NSObject {
    
    // 初始化相关回调
    static let setupSuccess: String = "setupSuccess"; // 初始化成功
    static let setupFailed  = "setupFailed";  // 初始化失败
    
    // 开屏相关回调
    static let splashAdLoadSuccess = "splashAdLoadSuccess"; // 加载成功
    static let splashAdLoadFailed  = "splashAdLoadFailed";   // 加载失败
    static let splashAdOnShow      = "splashAdOnShow";       // 已经显示
    static let splashAdOnClick     = "splashAdOnClick";      // 点击事件
    static let splashAdOnClose     = "splashAdOnClose";     // 关闭事件
    
    
    // 激励视频相关回调
    static let rewardVideoAdBeRewarded  = "rewardVideoAdBeRewarded";   // 达成奖励
    static let rewardVideoAdLoadSuccess = "rewardVideoAdLoadSuccess";  // 加载成功
    static let rewardVideoAdLoadFailed  = "rewardVideoAdLoadFailed";   // 加载失败
    static let rewardVideoAdOnShow      = "rewardVideoAdOnShow";       // 已经显示
    static let rewardVideoAdOnClick     = "rewardVideoAdOnClick";      // 点击事件
    static let rewardVideoAdOnClose     = "rewardVideoAdOnClose";      // 关闭事件

    // 插屏视频相关回调
    static let interstitialAdLoadSuccess = "interstitialAdLoadSuccess";   // 加载成功
    static let interstitialAdLoadFailed  = "interstitialAdLoadFailed";    // 加载失败
    static let interstitialAdOnShow      = "interstitialAdOnShow";        // 已经显示
    static let interstitialAdOnClick     = "interstitialAdOnClick";       // 点击事件
    static let interstitialAdOnClose     = "interstitialAdOnClose";       // 关闭事件

    // 信息流相关回调
    static let nativeAdLoadSuccess = "nativeAdLoadSuccess";   // 加载成功
    static let nativeAdLoadFailed  = "nativeAdLoadFailed";    // 加载失败
    static let nativeAdOnShow      = "nativeAdOnShow";        // 已经显示
    static let nativeAdOnClick     = "nativeAdOnClick";       // 点击事件
    static let nativeAdOnClose     = "nativeAdOnClose";       // 关闭事件
    
    // Icon相关回调
    static let iconAdLoadSuccess    = "iconAdLoadSuccess";   // 加载成功
    static let iconAdLoadUpdateSize = "iconAdLoadUpdateSize";  // 更新宽高
    static let iconAdLoadFailed     = "iconAdLoadFailed";    // 加载失败
    static let iconAdOnShow         = "iconAdOnShow";        // 已经显示
    static let iconAdOnClick        = "iconAdOnClick";       // 点击事件
    static let iconAdOnClose        = "iconAdOnClose";       // 关闭事件
}

/// 原生注册viewkey
class LingYeAdSdNativeViewNames: NSObject {
    static let nativeContentRegisterKey = "flutter_cjadsdk_plugin/native_contentView"
    static let iconContentRegisterKey = "flutter_cjadsdk_plugin/icon_contentView"
}

