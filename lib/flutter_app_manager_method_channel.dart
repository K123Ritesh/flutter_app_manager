import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_app_manager_platform_interface.dart';

/// An implementation of [FlutterAppManagerPlatform] that uses method channels.
class MethodChannelFlutterAppManager extends FlutterAppManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_app_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
