import 'package:flutter/services.dart';

class FlutterAppManager {
  static const MethodChannel _channel = MethodChannel('flutter_app_manager');
  Future<String?> getPlatformVersion() async {
    return '1.0.0';
  }

  static Future<List<Map<String, String>>> getInstalledApps() async {
    final List<dynamic> result =
        await _channel.invokeMethod('getInstalledApps');
    return _convertToListOfStringMaps(result);
  }

  static List<Map<String, String>> _convertToListOfStringMaps(
      List<dynamic> data) {
    return data.map((item) => _convertToStringMap(item)).toList();
  }

  static Map<String, String> _convertToStringMap(dynamic item) {
    if (item is! Map) {
      return {};
    }
    return Map<String, String>.fromEntries(
      item.entries.map(
        (entry) => MapEntry(
          entry.key.toString(),
          entry.value?.toString() ?? '',
        ),
      ),
    );
  }

  static Future<bool> openApp(String packageName) async {
    try {
      final bool result =
          await _channel.invokeMethod('openApp', {'packageName': packageName});
      return result;
    } catch (e) {
      return false;
    }
  }
}
