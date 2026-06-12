import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';
import 'package:flutter_cjadsdk_plugin/common/lingye_ad_export.dart';
import 'package:flutter_cjadsdk_plugin/inits/lingye_setup_ad_config.dart';
import 'package:flutter_cjadsdk_plugin/ads/lingye_icon_ad.dart';
import 'package:flutter_cjadsdk_plugin_example/testConfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final List<Map<String, String>> _menus = [
    {'text': '初始化'},
    {'text': '开屏'},
    {'text': '插屏'},
    {'text': '激励视频'},
    {'text': '信息流', 'route': 'nativeAdPage'},
    {'text': 'ICON'},
    {'text': 'ICON View'}
  ];

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';
  final _flutterCjadsdkPlugin = FlutterCjadsdkPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _initSDK();
    });
  }



    /// 初始化 SDK 逻辑抽取
  void _initSDK() {
    final config = LingyeSetupAdConfig(appId);
    config.oaid = "sdghkjashdkajshdkas";
    config.isCanUseAppList = 0;
    config.privacyCompliance = 0;

    final initCallBack = CommonInitCallBack(
      success: (code, message) {
        debugPrint("cj-log-领页SDK初始化成功");
      },
      failed: (code, message) {
        debugPrint("cj-log-领页SDK初始化失败");
      },
    );
    LingyeSetupAd.init(config, initCallBack);
  }

  void _loadAndShowSplashAd() {
    final adCallBack = CommonAdCallBack(
      onAdLoadSuccess: (code, message) {
        debugPrint("cj-log-开屏加载成功");
      },
      onAdLoadFailure: (code, message) {
        debugPrint("cj-log-开屏加载失败$message");
      },
      onAdShow: (code, message) {
        debugPrint("cj-log-开屏展示成功");
      },
      onAdClick: (code, message) {
        debugPrint("cj-log-开屏触发点击");
      },
      onAdClose: (code, message) {
        debugPrint("cj-log-开屏触发关闭");
      },
    );
    debugPrint("cj-log-开始请求了");
    final splashParams = LingYeSplashConfigParams();
    splashParams.adId = splashId;
    splashParams.bottomHeight = 240;
    splashParams.logoImageName = "logo";
    splashParams.bottomViewBGColor = "#FFB6C1";
    splashParams.logoImageMarginTop = 16;
    splashParams.logoImageHeight = 64;
    splashParams.logoImageWidth = 64;
    splashParams.text = "上海领页SDK";
    splashParams.textMarginTop = 16;
    splashParams.textFont = 16;
    splashParams.textColor = "#0000CD";
    LingyeSplashAd(adConfig: splashParams, eventCallBack: adCallBack).loadAndShow();
  }

  _loadAndShowInterstitialAd() {
      final adCallBack = CommonAdCallBack(
      onAdLoadSuccess: (code, message) {
        debugPrint("cj-log-插屏加载成功");
      },
      onAdLoadFailure: (code, message) {
        debugPrint("cj-log-插屏加载失败$message");
      },
      onAdShow: (code, message) {
        debugPrint("cj-log-插屏展示成功");
      },
      onAdClick: (code, message) {
        debugPrint("cj-log-插屏触发点击");
      },
      onAdClose: (code, message) {
        debugPrint("cj-log-插屏触发关闭");
      },
    );
    debugPrint("cj-log-开始请求了");
    LingyeInterstitialAd(adId: interstitialId, eventCallBack:adCallBack).loadAndShow();
  }

  _loadAndShowRewardVideoAd() {
      final adCallBack = CommonAdCallBack(
      onAdLoadSuccess: (code, message) {
        debugPrint("cj-log-激励加载成功");
      },
      onAdLoadFailure: (code, message) {
        debugPrint("cj-log-激励加载失败$message");
      },
      onAdShow: (code, message) {
        debugPrint("cj-log-激励展示成功");
      },
      onAdClick: (code, message) {
        debugPrint("cj-log-激励触发点击");
      },
      onAdClose: (code, message) {
        debugPrint("cj-log-激励触发关闭");
      },
      onAdReward: (code, message) {
        debugPrint("cj-log-达成奖励");
      });
    debugPrint("cj-log-开始请求了");
    LingyeRewardvideoAd(adId: rewardVideoId, eventCallBack:adCallBack).loadAndShow();
  }

  _loadAndShowIconView() {
      final adCallBack = CommonAdCallBack(
      onAdLoadSuccess: (code, message) {
        debugPrint("cj-log-ICON加载成功");
      },
      onAdLoadFailure: (code, message) {
        debugPrint("cj-log-ICON加载失败$message");
      },
      onAdShow: (code, message) {
        debugPrint("cj-log-ICON展示成功");
      },
      onAdClick: (code, message) {
        debugPrint("cj-log-ICON触发点击");
      },
      onAdClose: (code, message) {
        debugPrint("cj-log-ICON触发关闭");
      });
      final config = LingYeIconConfigParams();
      config.adId = iconId;
      config.isShowClose = 1;
      config.width = 60;
      config.height = 60;
      LingyeSeviceIconAd(params: config, eventCallBack: adCallBack).loadAndShow();
  }

  

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   platformVersion =
    //       await _flutterCjadsdkPlugin.getPlatformVersion() ?? 'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  void handleAdTypeEvent(int type) {
    debugPrint("进来了----$type");
    switch (type) {
      case 0:
      {
        _initSDK();
      }
        break;
      case 1:
      {
        _loadAndShowSplashAd();
      }
        break;
      case 2:
      {
        _loadAndShowInterstitialAd();
      }
        break;
      case 3:
      {
        _loadAndShowRewardVideoAd();
      }
        break;
      case 4:
        break;
      case 5: 
      {
        _loadAndShowIconView();
      }
      break;
      default:
    }

  }

  Widget getIconView(){
  var view = Container(
      height: 60,
      width: 60,
      color: Colors.red,
      child: Platform.isIOS ? const UiKitView(viewType: 'flutter_cjadsdk_plugin/icon_contentView') : const AndroidView(viewType: 'flutter_cjadsdk_plugin/icon_contentView')
    );   
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 水平居中
      children: <Widget>[
        view
      ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter插件-领页SDK"),
        ),
        body: Center(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            itemCount: _menus.length,
             separatorBuilder: (_, __) => const SizedBox(height: 32),
             itemBuilder: (context, index) {
              if (index == 6) {
                return  getIconView();
              }
              return MaterialButton (
                 color: Colors.black,
                 textColor: Colors.white,
                 child: Text(_menus[index]["text"]!),
                 onPressed: () {
                  handleAdTypeEvent(index);
                 },
                );
              },
            ),
        ),
      ),
    );
  }
}
