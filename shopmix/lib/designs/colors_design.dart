import 'package:flutter/material.dart';

class ColorsDesign {
  ColorsDesign();

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
  }

  final List<Color> dark=[Color.fromARGB(255, 8, 8, 8),Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 146, 143, 143),const Color.fromARGB(255, 46, 45, 45),Colors.white,Colors.white,Colors.white];
  final List<Color> light=[Colors.white,Color.fromARGB(255, 0, 0, 0),Color.fromARGB(255, 255, 0, 0),Color.fromARGB(255, 146, 143, 143),Colors.white,Color.fromARGB(255, 117, 125, 135),Colors.blue,Color.fromARGB(255, 146, 143, 143)];


  Color getdarkColor(Color color){
    Color darkcolorforlightcolor= dark[light.indexOf(color)];
    return darkcolorforlightcolor;

  }
    Color getlightColor(Color color){
    Color lightcolorfordarkcolor= light[dark.indexOf(color)]
    ;
    return lightcolorfordarkcolor;

  }



}
