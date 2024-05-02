import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/designs/colors_design.dart';

import 'package:shopmix/modelViews/profile_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';


class ProfileView extends StatelessWidget {
  late double _deviceWidth;

  late double _deviceHeight;

  
  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<ProfileModelView>()),
      

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
      body: SingleChildScrollView(child: Column(children: [OrdersItem(context),paymentMethodItem(context),Locations(context)],),),
    );
      



    }
    );
}


Widget OrdersItem(BuildContext context){

  return GestureDetector(
    onTap: (){
      Navigator.pushNamed(context, "/orders");
    },
    child: Container(

    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon( 
          color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],
          Icons.money_outlined,size: _deviceWidth*0.1,),),
          Expanded(child:       Container(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [

             Container(child: Text("Orders",style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),),
        Container(child: Text("View your orders",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],fontSize: _deviceWidth*0.04),),)
        ],),
      ))

    ],),
  ));
}

Widget paymentMethodItem(BuildContext context){

  return
  
    GestureDetector(

      onTap: (){
        Navigator.pushNamed(context, "/CreditCartsView");
      },
      child: 
   Container(

    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon( 
          color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],
          Icons.payment,size: _deviceWidth*0.1,),),
          Expanded(child:       Container(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [Container(child: Text("Payments",style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),),
        Container(child: Text("View,change, or add payment",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],fontSize: _deviceWidth*0.04),),)
        ],),
      ))

    ],),
  ),
    );
}


Widget Locations(BuildContext context){

  return
  
    GestureDetector(

      onTap: (){
        Navigator.pushNamed(context, "/locationsView");
       
      },
      child: 
   Container(

    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon( 
          color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],
          Icons.location_on,size: _deviceWidth*0.1,),),
          Expanded(child:       Container(
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [Container(child: Text("Locations",style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),),
        Container(child: Text("View,Add and Delete Locations",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[5]:GetIt.instance.get<ColorsDesign>().light[5],fontSize: _deviceWidth*0.04),),)
        ],),
      ))

    ],),
  ),
    );
}


  
}