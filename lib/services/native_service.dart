
import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('com.example.weather_app/native');

  static Future<String> getPlatformVersion() async {
    try {
      final String version = await platform.invokeMethod('getPlatformVersion');
      return version;
    } on PlatformException catch (e) {
      return "Failed to get platform version: '${e.message}'.";
    }
  }
}