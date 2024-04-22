import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget{

  late double height;

  late bool backtickenabled;
  late Color actionsColors;
  late Color backgroundColor;
  late Color backTickColor=GetIt.instance.get<ColorsDesign>().light[1];
  late double deviceWidth;
  late bool threeTapEnable;
  Color moreIconColor=GetIt.instance.get<ColorsDesign>().light[1];
  

  AppBarComponent({required this.height,required this.backtickenabled,required this.actionsColors,required this.backgroundColor,required this.deviceWidth,required this.threeTapEnable}){
    getpropertyColor(actionsColors, backgroundColor);
  }


  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: backTickColor
      ),
      backgroundColor:backgroundColor,
      actions: [darkMode(),threeTopLines()],
      automaticallyImplyLeading: this.backtickenabled,


    );



  }
    @override
  Size get preferredSize => Size.fromHeight(this.height); // Custom height



  Widget darkMode(){
    return 
    GestureDetector(
      onTap: (){GetIt.instance.get<darkModeProvider>().changeisDark();},
      child:     Container(
      child:
      GetIt.instance.get<ColorsDesign>().isDark==true?
      
      Icon(color: actionsColors,Icons.light_mode):Icon(color: actionsColors,Icons.dark_mode)));


  }

  Widget threeTopLines(){

  return Visibility( 
    visible: threeTapEnable? true:false,
    child:    GestureDetector(
    onTap: (){
      GetIt.instance.get<HomeModelView>().changeMoreTapViewToOpposite();
    

    },
    child: Container(child: Icon(Icons.more_vert,color: moreIconColor,),),)); 
  

  }

    void getpropertyColor(Color _actionColor,Color _backgroundColor) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

      backgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_backgroundColor);
      actionsColors=GetIt.instance.get<ColorsDesign>().getdarkColor(_actionColor);
      moreIconColor=GetIt.instance.get<ColorsDesign>().getdarkColor(moreIconColor);
      backTickColor=GetIt.instance.get<ColorsDesign>().getdarkColor(backTickColor);
    }
    else {
      actionsColors=_actionColor;
      backgroundColor = _backgroundColor;
      

    }
    

  }
  
}
