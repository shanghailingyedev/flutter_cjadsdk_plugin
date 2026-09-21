import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cjadsdk_plugin/ads/lingye.native_ad.dart';
import 'package:flutter_cjadsdk_plugin/common/common_header.dart';
import 'package:flutter_cjadsdk_plugin/inits/lingye_setup_ad_config.dart';

class LingYeNativeWidget extends StatefulWidget {
  final String adId;
  final int realWidth;


  late LingyeNativeAd _adNative;

  LingYeNativeWidget(this.adId, this.realWidth, {super.key});

  @override
  State<StatefulWidget> createState() => _NativeWidgetState();
}

class _NativeWidgetState extends State<LingYeNativeWidget>
    with AutomaticKeepAliveClientMixin {
  /// 创建参数
  late Map<String, dynamic> creationParams;

  /// 宽高
  double width = 0, height = 0;
  bool widgetNeedClose = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    width = widget.realWidth.toDouble();
    Future.delayed(Duration(seconds: 3), () {
      final adCallBack = CommonAdCallBack(
      onAdLoadSuccess: (code, message) {
        debugPrint("cj-log-信息流加载成功");
      },
      onAdLoadFailure: (code, message) {
        debugPrint("cj-log-信息流加载失败$message");
      },
      onAdShow: (code, message,) {
        debugPrint("cj-log-信息流展示成功");
      },
      onAdViewHeightChange: (height) => setState(() {
        this.height = height.toDouble();
      }),
      onAdClick: (code, message) {
        debugPrint("cj-log-信息流触发点击");
      },
      onAdClose: (code, message) {
        debugPrint("cj-log-信息流触发关闭");
      });
      final config = LingYeNativeParams();
      config.adId = this.widget.adId; 
      config.width = width.toInt();
      debugPrint("cj-log-触发----iiiiii");
      LingyeNativeAd(params: config, eventCallBack: adCallBack).loadAndShow();
    });

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_initialized) {
      _initialized = true;
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    }

    if (width <= 0 || height <= 0 || widgetNeedClose) {
      return const SizedBox.shrink();
    }
    Widget view;
    view = Platform.isIOS ? const UiKitView(viewType: 'flutter_cjadsdk_plugin/native_contentView') : const AndroidView(viewType: 'flutter_cjadsdk_plugin/native_contentView');

    /// 有宽高信息了（渲染成功了）设置对应宽高
    return SizedBox.fromSize(
      size: Size(width, height),
      child: view,
    );
  }

  @override
  bool get wantKeepAlive => true;

  String? get nativeId => null;

  Future<void> callBack(MethodCall call) async {}

  void _onPlatformViewCreated(int id) {
 
  }
}
