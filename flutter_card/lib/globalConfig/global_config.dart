import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class GlobalConfig {
  static bool dark = true;
  static ThemeData themeData = new ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: new Color(0xFFEBEBEB),
  );
  // static Color searchBackgroundColor = Colors.white10;
  // static Color cardBackgroundColor = Colors.white10;
  // static Color fontColor = Colors.white30;
  static EventBus eventBus = new EventBus();
}
