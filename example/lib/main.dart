import 'package:flutter/material.dart';
import 'package:flutter_app_manager/flutter_app_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _installedApps = [];

  @override
  void initState() {
    super.initState();
    _loadInstalledApps();
  }

  Future<void> _loadInstalledApps() async {
    final apps = await FlutterAppManager.getInstalledApps();
    setState(() {
      _installedApps = apps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Installed Apps'),
        ),
        body: ListView.builder(
          itemCount: _installedApps.length,
          itemBuilder: (context, index) {
            final app = _installedApps[index];
            return ListTile(
              title: Text(app['name'] ?? ''),
              subtitle: Text(app['packageName'] ?? ''),
              onTap: () => FlutterAppManager.openApp(app['packageName'] ?? ''),
            );
          },
        ),
      ),
    );
  }
}
