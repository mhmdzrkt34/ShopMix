

import 'package:flutter/material.dart';

class ColorsDesign {


  ColorsDesign();

    bool isDark=false;


   final List<Color> darkMode=[Color(0xFFF44336)];
   final List<Color> lightMode=[Color(0xFFF44336)];




   void changeMode(){
    isDark=!isDark;
   }


  int findCurrentLightModeColorIndex(Color color){

    int index=lightMode.indexOf(color);
    return index;

   }

  int findCurrentDarkModeColorIndex(Color color){

    int index=darkMode.indexOf(color);
    return index;

   }

//kazem


   final Map light ={

    "input":Color(0xFFFFFF) ,
    "label":Color(0x9B9B9B),
    "background":Color(0xF9F9F9),
    "botton":Color(0xDB3022)

    
   };
   
   final Map dark ={

    "input":Color( 0xFFFFFF) ,
    "label":Color(0xC0C0C0),
    "background":Color(0x1A1A1A),
    "botton":Color(0xDB3022)

    
   };











}