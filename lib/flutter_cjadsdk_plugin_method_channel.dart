import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_cjadsdk_plugin_platform_interface.dart';

/// An implementation of [FlutterCjadsdkPluginPlatform] that uses method channels.
class MethodChannelFlutterCjadsdkPlugin extends FlutterCjadsdkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_cjadsdk_plugin');

  // @override
  // Future<String?> getPlatformVersion() async {
  //   final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
  //   return version;
  // }
}
