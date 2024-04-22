import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';

class ShowingComponent extends StatelessWidget {


  late String title;
  late String subtitle;
  late String trailing;
  late double deviceWidth;
  late Color titleFontColor=GetIt.instance.get<ColorsDesign>().light[1];
  late Color subtitleFontColor=GetIt.instance.get<ColorsDesign>().light[3];
  
  late Color trailingFontColor=GetIt.instance.get<ColorsDesign>().light[1];

  late Function trailingOnPressToDo;
  late BuildContext context;


  ShowingComponent({required this.title,required this.subtitle,required this.trailing,required this.trailingOnPressToDo,required this.deviceWidth,required this.context}){

    getpropertyColor(titleFontColor,subtitleFontColor,trailingFontColor);
  }

  


  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
    width:deviceWidth ,

  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(child: Text(title,style: TextStyle(color: titleFontColor,fontWeight:FontWeight.bold,fontSize: 40),),),Container(child: Text(subtitle,style:TextStyle(color: subtitleFontColor) ,),)],),GestureDetector(
      onTap: (){
        trailingOnPressToDo(context);
      },
      child: Container(child: Text(trailing,style: TextStyle(color: trailingFontColor),),),)],),
  );
  }

        void getpropertyColor(Color _titleFontColor,Color _subtitleFontColor,Color _trailingFontColor) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

      titleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_titleFontColor);
      subtitleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_subtitleFontColor);
      trailingFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_trailingFontColor);
      
    }
    else {
     
      
      

    }
    

  }
}