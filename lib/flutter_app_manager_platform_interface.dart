import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_app_manager_method_channel.dart';

abstract class FlutterAppManagerPlatform extends PlatformInterface {
  /// Constructs a FlutterAppManagerPlatform.
  FlutterAppManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppManagerPlatform _instance = MethodChannelFlutterAppManager();

  /// The default instance of [FlutterAppManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAppManager].
  static FlutterAppManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAppManagerPlatform] when
  /// they register themselves.
  static set instance(FlutterAppManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
