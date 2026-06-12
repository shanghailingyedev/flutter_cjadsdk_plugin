
import 'package:flutter/services.dart';

import 'flutter_cjadsdk_plugin_platform_interface.dart';

class FlutterCjadsdkPlugin {

  static const MethodChannel _channel = MethodChannel('flutter_cjadsdk_plugin');

  // 保存MethodCall注册
  static final Map<String, Future<dynamic> Function(MethodCall)> _handlers = {};

  // 初始化结果
  static bool _isInitialized = false;

  /// 注册原生调用Flutter时的回调
  static void addMethodCallHandler(String key, Future<dynamic> Function(MethodCall call) handler) {
    _handlers[key] = handler;
    print(handler);
    if (!_isInitialized) {
      _isInitialized = true;
      _channel.setMethodCallHandler((MethodCall call) async {
        final List<Function> targets = _handlers.values.toList();
        for (var handle in targets) {
          print(handle);
          try {
            await handle(call);
          } catch (e) {
            print('cj-log SDK setupError: $e');
          }
        }
      });
    }
  }

  /// 移除回调
  static void removeMethodCallHandler(String key) {
    _handlers.remove(key);
  }

  static Future<T?> invokeMethod<T>(String method, [dynamic arguments]) {
    return _channel.invokeMethod<T>(method, arguments);
  }

  static Future<Future> invokeMapMethod(String interstitialGetMediaExtraInfo) async {
    return _channel.invokeMethod(interstitialGetMediaExtraInfo);
  }


  // Future<String?> getPlatformVersion() {
  //   return FlutterCjadsdkPluginPlatform.instance.getPlatformVersion();
  // }
}
