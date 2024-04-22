import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/setting_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';

class SettingView extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<SettingModelView>()),
       ChangeNotifierProvider.value(value: GetIt.instance.get<darkModeProvider>()),


    ],
    child: ScaffoldSelector()
    );

  }

        Selector<darkModeProvider,bool> ScaffoldSelector(){
    return Selector<darkModeProvider,bool>(selector: (context,provider)=>provider.isDark,
    shouldRebuild: (previous,next)=>!identical(previous,next),
    builder: (context, value, child){

      return Scaffold(

      backgroundColor:value?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],

      body:SingleChildScrollView(child: Column(children: [AccountItemContainer(),changePassword(),LogoutItemContainer(),deactivateItemContainer()],),),
        appBar: AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,),

      
      
    );
      



    }
    );
}

Widget AccountItemContainer(){

  return Container(

    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon( 
          color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],
          Icons.key,size: _deviceWidth*0.1,),),
      Container(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [Container(child: Text("Account",style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1], ),),),
        Container(child: Text("Security Information",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],fontSize: _deviceWidth*0.04),),)
        ],),
      )
    ],),
  );
}

Widget LogoutItemContainer(){

  return Container(

    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon( 
          color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],
          Icons.logout,size: _deviceWidth*0.1,),),
          Expanded(child:       Container(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [Container(child: Text("Logout",style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),),
        Container(child: Text("When you logout you must login to go back",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],fontSize: _deviceWidth*0.04),),)
        ],),
      ))

    ],),
  );
}

Widget changePassword(){

  return Container(

    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon( 
          color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],
          Icons.password,size: _deviceWidth*0.1,),),
          Expanded(child:       Container(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [Container(child: Text("Change Password",style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),),
        Container(child: Text("Make sure you know the old password",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],fontSize: _deviceWidth*0.04),),)
        ],),
      ))

    ],),
  );
}

Widget deactivateItemContainer(){

  return Container(

    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon( 
          color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],
          Icons.delete_forever_sharp,size: _deviceWidth*0.1,),),
          Expanded(child:       Container(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [Container(child: Text("Deactivate Account",style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),),
        Container(child: Text("When you deactivate you cant go back",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],fontSize: _deviceWidth*0.04),),)
        ],),
      ))

    ],),
  );
}

}