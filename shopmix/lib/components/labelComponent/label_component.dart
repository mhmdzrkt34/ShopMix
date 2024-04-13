import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';

class LabelComponent extends StatelessWidget {
  late List<double>  _padding, _margin;
  late String _title;
  
   
  late Color _fontColor;
  late double _fontsize;
  late Function _todoOnPress;
  

    LabelComponent( List<double> padding, List<double> margin,String title,Color fontColor,double fontsize,Function todoOnPress){
    
    _padding=padding;
    _margin=margin;
    _title=title;
    _todoOnPress = todoOnPress;

    
    
    _fontsize=fontsize;
    
    getpropertyColor( fontColor);


  }




  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(child: Text(_title,style: TextStyle(color: _fontColor),) ,onTap: (){
      _todoOnPress();

    },);


  }

      void getpropertyColor(Color fontColor) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

      _fontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(fontColor);
      
    }
    else {
      _fontColor=fontColor;
      
      

    }
    

  }
}