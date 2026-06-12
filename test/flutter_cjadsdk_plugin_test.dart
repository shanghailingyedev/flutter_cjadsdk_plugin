import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin_platform_interface.dart';
import 'package:flutter_cjadsdk_plugin/flutter_cjadsdk_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCjadsdkPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterCjadsdkPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterCjadsdkPluginPlatform initialPlatform = FlutterCjadsdkPluginPlatform.instance;

  test('$MethodChannelFlutterCjadsdkPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCjadsdkPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterCjadsdkPlugin flutterCjadsdkPlugin = FlutterCjadsdkPlugin();
    MockFlutterCjadsdkPluginPlatform fakePlatform = MockFlutterCjadsdkPluginPlatform();
    FlutterCjadsdkPluginPlatform.instance = fakePlatform;

    // expect(await flutterCjadsdkPlugin.getPlatformVersion(), '42');
  });
}
