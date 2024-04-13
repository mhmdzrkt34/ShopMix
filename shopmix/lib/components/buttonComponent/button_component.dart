
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';

class buttonComponent extends StatelessWidget {
  late List<double> _size, _padding, _margin;
  late String _title;
  late Function _toDoOnPress;
  late Color _backgroundColor;
  late double _borderRadius;
  late Color _fontColor;
  late double _fontsize;

  buttonComponent(List<double> size, List<double> padding, List<double> margin,
      String title, Function toDoOnPress, Color backgroundcolor, double borderRadius,double fontSize,Color fontcolor) {
        _margin=margin;
    _size = size;
    _padding = padding;
    _title = title;
    _toDoOnPress = toDoOnPress;
    
    _borderRadius = borderRadius;
    _fontsize=fontSize;
    getpropertyColor(backgroundcolor, fontcolor);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(color: _backgroundColor,borderRadius: BorderRadius.circular(_borderRadius)),
     
      padding: EdgeInsets.only(top:_padding[0],right: _padding[1],bottom: _padding[2],left: _padding[3] ),
      margin: EdgeInsets.only(top:_margin[0],right: _margin[1],bottom: _margin[2],left: _margin[3] ),

      width: _size[1],
      
      child: MaterialButton(onPressed: (){
        _toDoOnPress();
      },
      child: Text(_title,style: TextStyle(color: _fontColor,fontSize: _fontsize),),),
    );

    

  }
  
  void getpropertyColor(Color backgroundcolor,Color fontColor) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

      _fontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(fontColor);
      _backgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(backgroundcolor);
      
    }
    else {
      _fontColor=fontColor;
      _backgroundColor = backgroundcolor;
      

    }
    

  }

}
