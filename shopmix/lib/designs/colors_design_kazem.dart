import 'package:flutter/material.dart';

class ColorsDesignkazem {
  ColorsDesignkazem();

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
  }

  final Map<String, Color> light = {
    "input": const Color(0xFFFFFFFF),
    "inputfoucs": const Color(0xFFFFFFFF),
    "label": const Color(0xFF9B9B9B),
    // "background": Color.fromARGB(255, 243, 238, 238),
    "background": Colors.white,
    "button": const Color(0xFFDB3022),
    "buttontext": Colors.white,
    "title": const Color(0xFF1A1A1A),
    "focusedBorder": Color.fromARGB(255, 170, 169, 169),
    "socilafb": Colors.white,
    "socilagooogle": Color.fromARGB(255, 236, 233, 233),
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
    "socilafb": Colors.black,
    "socilagooogle": Color.fromARGB(255, 231, 223, 223),
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
