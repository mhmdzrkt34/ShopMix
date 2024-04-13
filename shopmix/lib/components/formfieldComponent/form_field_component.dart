import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/controllers/formsControllers/login_form_controller.dart';
import 'package:shopmix/controllers/formsControllers/register_form_controller.dart';
import 'package:shopmix/designs/colors_design.dart';

class FormFieldComponent extends StatelessWidget{
  late List<double> _size, _padding, _margin;
  late String _title;
  late Color _backgroundColor;
  late double _borderRadius;
  late Color _fontColor;
  late double _fontsize;


  late Function _todoOnSave;
  late Function _validator;

  FormFieldComponent(List<double> size, List<double> padding, List<double> margin,String title,Color backgroundColor,double borderRadius,Color fontColor,double fontsize,Function todoonsave,Function validator){
    _size=size;
    _padding=padding;
    _margin=margin;
    _title=title;

    _borderRadius=borderRadius;
    
    _fontsize=fontsize;

    _todoOnSave = todoonsave; //
    _validator=validator;
    getpropertyColor(backgroundColor, fontColor);


  }

  @override
  Widget build(BuildContext context) {


      
        return Container(
                decoration: BoxDecoration(color: _backgroundColor,borderRadius: BorderRadius.circular(_borderRadius)),
     
      padding: EdgeInsets.only(top:_padding[0],right: _padding[1],bottom: _padding[2],left: _padding[3] ),
      margin: EdgeInsets.only(top:_margin[0],right: _margin[1],bottom: _margin[2],left: _margin[3] ),

      width: _size[1],
      
          child: TextFormField(decoration:InputDecoration(labelText:_title),
          onSaved: (value){
            _todoOnSave(value!);
          },
          validator: (value){
            return _validator(value!);

          },
          
          
          ));

      

 
    



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