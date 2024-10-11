// ignore_for_file: file_names

import 'package:flutter/services.dart';

class LocationForegroundService {
  static const MethodChannel _channel = MethodChannel('foreground_service');

  static Future<void> startForegroundService() async {
    await _channel.invokeMethod('startForegroundService');
  }

  static Future<void> stopForegroundService() async {
    await _channel.invokeMethod('stopForegroundService');
  }
}
