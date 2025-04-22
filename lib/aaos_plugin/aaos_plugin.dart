import 'package:flutter/services.dart';

class AaosPlugin {
  static const MethodChannel methodChannel = MethodChannel('aaos_plugin');

  Future<String?> get platformVersion async {
    final String? version =
        await methodChannel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Stream> listenCarData() async {
    EventChannel eventChannel = const EventChannel('CarData');
    return eventChannel.receiveBroadcastStream();
  }
}
