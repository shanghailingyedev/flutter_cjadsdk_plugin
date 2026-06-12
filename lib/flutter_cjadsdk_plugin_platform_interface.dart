import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_cjadsdk_plugin_method_channel.dart';

abstract class FlutterCjadsdkPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterCjadsdkPluginPlatform.
  FlutterCjadsdkPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCjadsdkPluginPlatform _instance = MethodChannelFlutterCjadsdkPlugin();

  /// The default instance of [FlutterCjadsdkPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCjadsdkPlugin].
  static FlutterCjadsdkPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCjadsdkPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterCjadsdkPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Future<String?> getPlatformVersion() {
  //   throw UnimplementedError('platformVersion() has not been implemented.');
  // }
}
