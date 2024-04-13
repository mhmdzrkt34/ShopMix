import 'package:flutter/material.dart';

class ColorsDesign {
  ColorsDesign();

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
  }

  final List<Color> dark=[Color.fromARGB(255, 8, 8, 8),Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 255, 0, 0)];
  final List<Color> light=[Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 0, 0, 0),Color.fromARGB(255, 255, 0, 0)];


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
