import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/credit_carts_model_view.dart';

import 'package:shopmix/modelViews/profile_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';


class creditCartView extends StatelessWidget {
  late double _deviceWidth;

  late double _deviceHeight;
  late BuildContext currentContext;

  
  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    currentContext=context;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<CreditCartsModelView>()),
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
      body: SingleChildScrollView(child: Column(children: [addNewPaymentButton()],),),
      appBar:   AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,searchVisible: false,filter: Filter,),


    );
      



    }
    );
}

Widget addNewPaymentButton(){
  return   Container(
   
    width: _deviceWidth,
     padding:EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
  
  child: MaterialButton(
    color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],
    textColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    
    
    
    onPressed: (){
      Navigator.pushNamed(currentContext, "/addCreditCartView");
    


    },
  child: Text("Add New Payment"),),); 
}


void Filter(String value){

  print(value);
}




  
}