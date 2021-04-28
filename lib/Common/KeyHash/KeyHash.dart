import 'package:device_apps/device_apps.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class KeyHash {

  static const _platform = const MethodChannel('com.wing.forutonafront');

  static Future<String?> getKeyHash() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print(packageName);

    final String? result = await _platform.invokeMethod("getKeyHash",packageName);
    return result;
  }
}