import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/order_method_model_view.dart';
import 'package:shopmix/modelViews/setting_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';

class OrderMethodView extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;
  late BuildContext currentcontext;


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    currentcontext=context;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<OrderMethodModelView>()),
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

      body:SingleChildScrollView(child: Column(children: [paysMethod(),ConfirmButton()],),),
        appBar: AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,),

      
      
    );
      



    }
    );
}

Selector<OrderMethodModelView,bool> paysMethod(){


  return  Selector<OrderMethodModelView,bool>(selector: (context,provider)=>provider.payOnDelivery,
  
  shouldRebuild: (previous, next) => !identical(previous, next),
  
  builder: (context,value,child){

    return    Container(
    padding: EdgeInsets.all(20),
    child: Column(children: [Container(width: _deviceWidth,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Container(child: Row(children: [    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon(Icons.delivery_dining,size: _deviceWidth*0.1,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],),),
    
    Container(child: Text("Pay On delivery",style: TextStyle(fontSize: _deviceWidth*0.05,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),)],)),
    
    GestureDetector(
      onTap: (){

        GetIt.instance.get<OrderMethodModelView>().makePayOnDeliveryTrue();

      },
      child: Container(child: Icon(value==true? Icons.radio_button_checked:Icons.radio_button_off,size: _deviceWidth*0.07,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),)
    
    ],
    ),
    ),
    Container(width: _deviceWidth,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Container(child: Row(children: [    
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon(Icons.credit_card,size: _deviceWidth*0.1,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[6]:GetIt.instance.get<ColorsDesign>().light[6],),),
    
    Container(child: Text("Pay Online",style: TextStyle(fontSize: _deviceWidth*0.05,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),)],)),
    
    GestureDetector(
      onTap: (){
        GetIt.instance.get<OrderMethodModelView>().makePayOnDeliveryFalse();

      },
      child: Container(child: Icon(value==false? Icons.radio_button_checked:Icons.radio_button_off,size: _deviceWidth*0.07,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),)
    
    ],
    ),
    ),

    
    
    ],),
  );


  },
  );
  

}

Widget ConfirmButton(){
  return       Container(
        margin: EdgeInsets.all(20),
   
    width: _deviceWidth,
     
  
  child: MaterialButton(
    color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],
    textColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    
    
    
    onPressed: (){
      //Navigator.pushNamed(currentcontext, "/orderMethodView");


    },
  child: Text("Confirm"),),) ;
}





}