import 'package:flutter/material.dart';
import 'package:flutter_ui_adapt/screen_adaptive_utils.dart';

void main() {
  ScreenAdaptiveUtils.runApp(rootWidget: const MyApp());
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
      builder: ScreenAdaptiveUtils.builder(),
      home: const MyHomePage(),
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
          margin: const EdgeInsets.only(top: 88),
          color: Colors.blue,
          width: 370,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.red,
                width: 365,
                height: 365,
              )
            ],
          ),
        ),
      ),
    );
  }
}
