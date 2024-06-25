import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_manager/flutter_app_manager.dart';
import 'package:flutter_app_manager/flutter_app_manager_platform_interface.dart';
import 'package:flutter_app_manager/flutter_app_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAppManagerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAppManagerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAppManagerPlatform initialPlatform =
      FlutterAppManagerPlatform.instance;

  test('$MethodChannelFlutterAppManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAppManager>());
  });

  test('getPlatformVersion', () async {
    FlutterAppManager flutterAppManagerPlugin = FlutterAppManager();
    MockFlutterAppManagerPlatform fakePlatform =
        MockFlutterAppManagerPlatform();
    FlutterAppManagerPlatform.instance = fakePlatform;

    expect(await flutterAppManagerPlugin.getPlatformVersion(), '42');
  });
}
