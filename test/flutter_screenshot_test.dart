import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenshot/flutter_screenshot.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_screenshot');
  final Uint8List? binaries = Uint8List.fromList([1, 2, 3, 4]);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return binaries;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getScreenshot', () async {
    expect(await FlutterScreenshot.getScreenshot, binaries);
  });
}
