import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';

class buttonComponent extends StatelessWidget {
  late List<double> _size,_padding,_margin;
  late String _title;
  late Function _toDoOnPress;
  late Color _backgroundColor;
  late double _borderRadius;
  late Color _fontColor;
  

  buttonComponent(List<double> size,List<double> padding,List<double> margin,String title,Function toDoOnPress,Color color,double borderRadius){
    _size=size;
    _padding=padding;
    _title=title;
    _toDoOnPress=toDoOnPress;
    _backgroundColor=color;
    _borderRadius=borderRadius;
    



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }



  void getColor(){

    if(GetIt.instance.get<ColorsDesign>().isDark){
      int index=GetIt.instance.get<ColorsDesign>().findCurrentDarkModeColorIndex(_backgroundColor);
      _backgroundColor=GetIt.instance.get<ColorsDesign>().lightMode[index];
      

    }
    else {
      int index=GetIt.instance.get<ColorsDesign>().findCurrentLightModeColorIndex(_backgroundColor);
      _backgroundColor=GetIt.instance.get<ColorsDesign>().darkMode[index];




      
    }

  }




}