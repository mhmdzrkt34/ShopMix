import 'package:flutter/material.dart';

class ColorsDesign {
  ColorsDesign();

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
  }

  final Map light = {
    "input": Color(0xFFFFFF),
    "label": Color(0x9B9B9B),
    "background": Color(0xF9F9F9),
    "botton": Color(0xDB3022),
  };

  final Map dark = {
    "input": Color(0xFFFFFF),
    "label": Color(0xC0C0C0),
    "background": Color(0x1A1A1A),
    "botton": Color(0xDB3022),
  };
}
