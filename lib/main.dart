import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ui_adapt/my_widgets_flutter_binding.dart';

void main() {
  // runApp(const MyApp());
  runMyApp(const MyApp());
}

void runMyApp(Widget app) {
  MyWidgetsFlutterBinding.ensureInitialized()
      ..scheduleAttachRootWidget(app)
      ..scheduleWarmUpFrame();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: UIAdaptUtils.buildApp,
      home: MyHomePage(),
    );
  }
}

class AutoAdaptUtils extends StatefulWidget {

  final Size designSize;

  final Widget? child;

  const AutoAdaptUtils({Key? key, required this.designSize, this.child}) : super(key: key);



  @override
  State<AutoAdaptUtils> createState() => _AutoAdaptUtilsState();
}

class _AutoAdaptUtilsState extends State<AutoAdaptUtils> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final devicePixelRatio = window.physicalSize.width/375;
    final size = Size(375, window.physicalSize.height / devicePixelRatio);
    return MediaQuery(
      data: data.copyWith(
        size: size,
        devicePixelRatio: devicePixelRatio,
        textScaleFactor: 1.0,
      ),
      child: Container(
        child: widget,
      ),
    );
  }
}


class UIAdaptUtils {
  static Widget buildApp(BuildContext context, Widget? widget) {
    final data = MediaQuery.of(context);
    final devicePixelRatio = window.physicalSize.width/375;
    final size = Size(375, window.physicalSize.height / devicePixelRatio);
    return MediaQuery(
      data: data.copyWith(
        size: size,
        devicePixelRatio: devicePixelRatio,
        textScaleFactor: 1.0,
      ),
      child: Container(
        child: widget,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(top: 44),
          color: Colors.blue,
          width: 375,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.red,
                width: 300,
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
