import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final String _viewType = "testPlatformView";
  final Map<String, dynamic> _params = {"a": 2, "b": 1};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform View'),
      ),
      body: Center(
        child: Platform.isAndroid
            ? AndroidView(
                viewType: _viewType,
                creationParams: _params,
                creationParamsCodec: const StandardMessageCodec(),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
              )
            : UiKitView(
                viewType: _viewType,
                creationParams: _params,
                creationParamsCodec: const StandardMessageCodec(),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
              ),
      ),
    );
  }
}
