import 'package:flutter/material.dart';

class ColorsDesign {
  ColorsDesign();

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
  }

  final Map<String, Color> light = {
    "input": const Color(0xFFFFFFFF),
    "inputfoucs": const Color(0xFFFFFFFF),
    "label": const Color(0xFF9B9B9B),
    "background": Color.fromARGB(255, 243, 238, 238),
    "button": const Color(0xFFDB3022),
    "buttontext": const Color(0xFF1A1A1A),
    "title": const Color(0xFF1A1A1A),
    "focusedBorder": Color.fromARGB(255, 170, 169, 169),
  };

  final Map<String, Color> dark = {
    "input": Color.fromARGB(255, 204, 204, 204),
    "inputfoucs": const Color(0xFFFFFFFF),
    "label": const Color(0xFFFFFFFF),
    "background": const Color(0xFF1A1A1A),
    "button": const Color(0xFFDB3022),
    "buttontext": Color.fromARGB(255, 243, 238, 238),
    "title": const Color(0xFFFFFFFF),
    "focusedBorder": const Color(0xFFFFFFFF),
  };

  String getLabelFromColor(Color color) {
    for (var entry in light.entries) {
      if (entry.value == color) {
        return entry.key;
      }
    }

    return "";
  }
}
