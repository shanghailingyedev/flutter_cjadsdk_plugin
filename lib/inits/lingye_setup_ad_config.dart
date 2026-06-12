import 'dart:ffi';

class LingyeSetupAdConfig {

  // 媒体appId（双端）
  String? appId;
  // 用户userId（双端）
  String? userId;


  // Android oaid
  String? oaid;
  // 是否允许获取应用列表（默认true）
  int? isCanUseAppList;
  // 是否需要隐私合规（默认false）
  int? privacyCompliance;
  // 传给原生map
  Map<String, dynamic> toMap() {
    return {
      "appId": appId,
      "userId": userId,
      "oaid": oaid,
      "isCanUseAppList": isCanUseAppList,
      "privacyCompliance": privacyCompliance,
    };
  }
  LingyeSetupAdConfig(this.appId);
}

class LingYeSplashConfigParams {
  String? adId;

  // logo区域总高度
  double bottomHeight = 0;
  String bottomViewBGColor = "";

  // 配置logo区域
  String logoImageName = "";
  // 图片上边距（默认图片和文字整体居中）
  double logoImageMarginTop = 0;
  double logoImageWidth = 64;
  double logoImageHeight = 64;


  // logo下方的标题（没有可以不传）
  String text = "";
  // 和图片间距
  double textMarginTop = 16.0;
  double textFont = 14.0;
  // 文字RGB和透明度（A）
  String textColor = "";

  LingYeSplashConfigParams();

  Map<String, dynamic> toMap() {
  return {
    "adId": adId,
    "bottomHeight": bottomHeight,
    "bottomViewBGColor": bottomViewBGColor,
    "logoImageName": logoImageName,
    "logoImageMarginTop": logoImageMarginTop,
    "logoImageWidth": logoImageWidth,
    "logoImageHeight": logoImageHeight,
    "text": text,
    "textMarginTop": textMarginTop,
    "textFont": textFont,
    "textColor": textColor,
  };
}
}

class LingYeIconConfigParams {

    String? adId; // 广告位ID

    int? isShowClose; // 是否展示关闭按钮（默认不展示，0: 不展示 1: 展示）

    // size 默认60
    int width = 60; 
    int height = 60;

    Map<String, dynamic> toMap() {
      return {
        "adId": adId,
        "isShowClose": isShowClose,
        "width": width,
        "height": height
      };
  }
}