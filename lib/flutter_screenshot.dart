import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class FlutterScreenshot {
  static const MethodChannel _channel =
      const MethodChannel('flutter_screenshot');

  static Future<Uint8List?> get getScreenshot async {
    final Uint8List? imageBinary = await _channel.invokeMethod('getScreenshot');
    return imageBinary;
  }
}
