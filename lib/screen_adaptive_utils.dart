// created by YiBei at 2022/3/9
// Copyright ©2022 zcy_app. All rights reserved.

import 'dart:collection';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// 设备宽度
double _designWidth = 375;

// 屏幕自适应公交
class ScreenAdaptiveUtils {
  // 运行 App
  static void runApp({double designWidth = 375, required Widget rootWidget}) {
    _designWidth = designWidth;
    _ScreenAdaptiveFlutterBinding.ensureInitialized()
      ..scheduleAttachRootWidget(rootWidget)
      ..scheduleWarmUpFrame();
  }

  // MaterialApp 的 builder
  static TransitionBuilder builder({TransitionBuilder? builder}) {
    final devicePixelRatio = window.physicalSize.width / _designWidth;
    final designHeight = window.physicalSize.height / devicePixelRatio;
    final size = Size(_designWidth, designHeight);
    return (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          size: size,
          devicePixelRatio: devicePixelRatio,
          textScaleFactor: 1.0,
        ),
        child:
            builder != null ? builder(context, child) : Container(child: child),
      );
    };
  }
}

/// 自定义的 WidgetsFlutterBinding 子类
class _ScreenAdaptiveFlutterBinding extends WidgetsFlutterBinding {
  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  // 确保初始化
  static _ScreenAdaptiveFlutterBinding ensureInitialized() {
    _ScreenAdaptiveFlutterBinding();
    return WidgetsBinding.instance as _ScreenAdaptiveFlutterBinding;
  }

  @override
  void scheduleAttachRootWidget(Widget rootWidget) {
    super.scheduleAttachRootWidget(rootWidget);
  }

  @override
  void initInstances() {
    super.initInstances();
    window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  ViewConfiguration createViewConfiguration() {
    final devicePixelRatio = window.physicalSize.width / _designWidth;
    final designHeight = window.physicalSize.height / devicePixelRatio;
    final size = Size(_designWidth, designHeight);
    return ViewConfiguration(size: size, devicePixelRatio: devicePixelRatio);
  }

  void _handlePointerDataPacket(PointerDataPacket packet) {
    final devicePixelRatio = window.physicalSize.width / _designWidth;
    final event = PointerEventConverter.expand(packet.data, devicePixelRatio);
    _pendingPointerEvents.addAll(event);
    if (!locked) _flushPointerEventQueue();
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty) {
      handlePointerEvent(_pendingPointerEvents.removeFirst());
    }
  }
}
