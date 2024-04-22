import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/home_body_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/views/home_body_view.dart';

class MoreTapComponent extends StatelessWidget {

  Color backgroundColor=GetIt.instance.get<ColorsDesign>().light[4];

  Color textFontColor=GetIt.instance.get<ColorsDesign>().light[1];

  late double deviceWidth;
  late BuildContext HomePageContext;
 


  MoreTapComponent({required this.deviceWidth,required this.HomePageContext}){
    getpropertyColor();
  }



  @override
  Widget build(BuildContext context) {
   
    return Container(
      decoration: BoxDecoration(color:backgroundColor,borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.only(left: 20,right: 60,top: 20,bottom: 20),
     
      
      child: Column(children: [
        GestureDetector(
          onTap: (){
             Navigator.pushNamed(HomePageContext, "/setting");
             GetIt.instance.get<HomeModelView>().changeMoreTapViewToOpposite();
          },
          child:Text("settings",style: TextStyle(fontSize: deviceWidth*0.1,color: textFontColor),),),

        
     
      
      ],),
      
    );

  }
            void getpropertyColor(
        ) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){
      backgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(backgroundColor);
      textFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(textFontColor);



      
    }
    else {
      
      
      

    }
    

}
}