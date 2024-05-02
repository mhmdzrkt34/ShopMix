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
  late bool searchVisible;
  late Function filter;
   Color borderSearchColor=GetIt.instance.get<ColorsDesign>().light[1];
   Color IconSearchColors=GetIt.instance.get<ColorsDesign>().light[1];
   Color labelFormColor=GetIt.instance.get<ColorsDesign>().light[3];
   Color inputSeacrhColor=GetIt.instance.get<ColorsDesign>().light[1];

  Color moreIconColor=GetIt.instance.get<ColorsDesign>().light[1];
  

  AppBarComponent({required this.height,required this.backtickenabled,required this.actionsColors,required this.backgroundColor,required this.deviceWidth,required this.threeTapEnable,required this.searchVisible,required this.filter}){
    getpropertyColor(actionsColors, backgroundColor,borderSearchColor,IconSearchColors,labelFormColor,inputSeacrhColor);
  }


  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child:Container(
          margin: EdgeInsets.only(top: 20),
          child: Visibility(
            visible: searchVisible,
            child: Container(
              
              margin: EdgeInsets.only(left: 10,right: 10),
            width: deviceWidth,
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration:BoxDecoration(border: Border.all(color: borderSearchColor)) ,
             
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children:  [Expanded(child: TextFormField(

                onChanged: (value){
                  filter(value);

                },
                cursorColor: IconSearchColors,
                 style: TextStyle(fontSize: 15,color: inputSeacrhColor), decoration:InputDecoration( hintText: "Search",border: InputBorder.none,hintStyle: TextStyle(color: labelFormColor)) ,)), Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.search,color: IconSearchColors,))],),
            ),)),
        ) ,
        
      ),
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

    void getpropertyColor(Color _actionColor,Color _backgroundColor,Color _borderSearchColor,Color _IconSearchColors,Color _labelFormColor,Color _inputSeacrhColor) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

      backgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_backgroundColor);
      actionsColors=GetIt.instance.get<ColorsDesign>().getdarkColor(_actionColor);
      moreIconColor=GetIt.instance.get<ColorsDesign>().getdarkColor(moreIconColor);
      backTickColor=GetIt.instance.get<ColorsDesign>().getdarkColor(backTickColor);

       borderSearchColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_borderSearchColor);
    IconSearchColors=GetIt.instance.get<ColorsDesign>().getdarkColor(_IconSearchColors);
labelFormColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_labelFormColor);
  inputSeacrhColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_inputSeacrhColor);

    }
    else {
      actionsColors=_actionColor;
      backgroundColor = _backgroundColor;
      

    }
    

  }
  
}
