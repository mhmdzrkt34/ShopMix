import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/add_credit_cart_model_view.dart';

import 'package:shopmix/modelViews/profile_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';


class AddCreditCartView extends StatelessWidget {
  late double _deviceWidth;

  late double _deviceHeight;
  CardFieldInputDetails cardDetails=CardFieldInputDetails(complete: false,brand: "",cvc: "",expiryMonth: 0,expiryYear: 0,last4: "",number: "",postalCode: "");
  

  
  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<AddCreditCartModelView>()),
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
        appBar:    AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,searchVisible: false,filter: Filter,),

      backgroundColor:value?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
      body: SingleChildScrollView(child: Column(children: [CreditCartForm(),SubmitButton()],),),
    );
      



    }
    );
}


Widget CreditCartForm(){

  return Container(
    padding:EdgeInsets.only(left: 20,right: 20,top: 10),
  
    
    child: CardFormField(
      onCardChanged: (details) => {
        print(details!.toJson())
        


      },
      
      
      style: CardFormStyle(
        

        placeholderColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[7]:GetIt.instance.get<ColorsDesign>().light[7],
        textColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],
        borderColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[7]:GetIt.instance.get<ColorsDesign>().light[7],
        


      ),
    
      
      
      ));
}


Widget SubmitButton(){
  return   Container(
   
    width: _deviceWidth,
     padding:EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
  
  child: MaterialButton(
    color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],
    textColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    
    
    
    onPressed: (){
      

        if(cardDetails.complete==true){
          print(cardDetails.complete);

        }
       

  // Use Stripe SDK to validate the card

     
    


    },
  child: Text("Submit"),),); 
}

void Filter(String value){

  print(value);
}







  
}