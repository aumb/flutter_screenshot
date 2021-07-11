import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:js' as js;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the FlutterScreenshot plugin.
class FlutterScreenshotPlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_screenshot',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = FlutterScreenshotPlugin();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getScreenshot':
        return await getPlatformVersion();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'flutter_screenshot for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<Uint8List> getPlatformVersion() async {
    final body = html.document.querySelector("#capture");
    // final userMedia = await html.window.navigator.mediaDevices?.getUserMedia({
    //   'audio': false,
    //   'video': true,
    // });
    // print(userMedia);
    final blobPromise = await js.context.callMethod('screenshot');

    // final blob = blobPromise as js.JsObject;
    // print(blob);

    return Future.value(null);
  }
}
