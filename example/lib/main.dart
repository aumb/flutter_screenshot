import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_screenshot/flutter_screenshot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Uint8List? pic;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Screenshot example'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('screenshot'),
                  onPressed: () async {
                    await screenshot();
                  },
                ),
              ),
              if (pic != null) Center(child: Image.memory(pic!)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> screenshot() async {
    try {
      final val = await FlutterScreenshot.getScreenshot;
      setState(() {
        pic = val;
      });
    } on PlatformException {
      print('sad');
    }
  }
}
