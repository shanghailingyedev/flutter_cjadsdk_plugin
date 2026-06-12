/// 广告SDK提供方法名
class LingYeAdSdkMethodNames {
    companion object {
        // 信息流原生view注册key
        const val nativeContentRegisterKey = "flutter_cjadsdk_plugin/native_contentView"
        const val iconContentRegisterKey = "flutter_cjadsdk_plugin/icon_contentView"
        // SDK初始化
        const val initSDKFun = "cjSdkSetup"
        const val loadAndShowSplashAd = "cjLoadAndShowSplashMethod"
        const val loadAndShowInterstitialAd = "cjLoadAndShowInterstitialAdMethod"
        const val loadAndShowRewardVideoAd = "cjLoadAndShowRewardVideoMethod"
        const val loadNativeAd = "cjLoadAndShowNativeAdMethod"
        const val loadIconAd = "cjLoadAndShowIconMethod"
    }
}

/// 回传方法名
class LingYeAdSdkCallBackMethodNames {

    companion object {
        // 初始化相关回调
        const val setupSuccess: String = "setupSuccess"; // 初始化成功
        const val setupFailed  = "setupFailed";  // 初始化失败

        // 开屏相关回调
        const val splashAdLoadSuccess = "splashAdLoadSuccess"; // 加载成功
        const val splashAdLoadFailed  = "splashAdLoadFailed";   // 加载失败
        const val splashAdOnShow      = "splashAdOnShow";       // 已经显示
        const val splashAdOnClick     = "splashAdOnClick";      // 点击事件
        const val splashAdOnClose     = "splashAdOnClose";     // 关闭事件


        // 激励视频相关回调
        const val rewardVideoAdBeRewarded  = "rewardVideoAdBeRewarded";   // 达成奖励
        const val rewardVideoAdLoadSuccess = "rewardVideoAdLoadSuccess";  // 加载成功
        const val rewardVideoAdLoadFailed  = "rewardVideoAdLoadFailed";   // 加载失败
        const val rewardVideoAdOnShow      = "rewardVideoAdOnShow";       // 已经显示
        const val rewardVideoAdOnClick     = "rewardVideoAdOnClick";      // 点击事件
        const val rewardVideoAdOnClose     = "rewardVideoAdOnClose";      // 关闭事件

        // 插屏视频相关回调
        const val interstitialAdLoadSuccess = "interstitialAdLoadSuccess";   // 加载成功
        const val interstitialAdLoadFailed  = "interstitialAdLoadFailed";    // 加载失败
        const val interstitialAdOnShow      = "interstitialAdOnShow";        // 已经显示
        const val interstitialAdOnClick     = "interstitialAdOnClick";       // 点击事件
        const val interstitialAdOnClose     = "interstitialAdOnClose";       // 关闭事件

        // 信息流相关回调
        const val nativeAdLoadSuccess = "nativeAdLoadSuccess";   // 加载成功
        const val nativeAdLoadUpdateSize = "nativeAdLoadUpdateSize";  // 更新宽高
        const val nativeAdLoadFailed  = "nativeAdLoadFailed";    // 加载失败
        const val nativeAdOnShow      = "nativeAdOnShow";        // 已经显示
        const val nativeAdOnClick     = "nativeAdOnClick";       // 点击事件
        const val nativeAdOnClose     = "nativeAdOnClose";       // 关闭事件


        // Icon相关回调
        const val iconAdLoadSuccess = "iconAdLoadSuccess";   // 加载成功
        const val iconAdLoadUpdateSize = "iconAdLoadUpdateSize";  // 更新宽高
        const val iconAdLoadFailed  = "iconAdLoadFailed";    // 加载失败
        const val iconAdOnShow      = "iconAdOnShow";        // 已经显示
        const val iconAdOnClick     = "iconAdOnClick";       // 点击事件
        const val iconAdOnClose     = "iconAdOnClose";       // 关闭事件
    }
}



