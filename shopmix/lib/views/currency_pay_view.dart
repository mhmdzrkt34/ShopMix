import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/env.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/currency_pay_model_view.dart';
import 'package:tuple/tuple.dart';

class CurrencyPayView extends StatelessWidget{

  late double _deviceWidth;
  late double _deviceHeight;



  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;

    _deviceHeight=MediaQuery.of(context).size.height;
    GetIt.instance.get<CurrencyPayModelView>().waitForLtcPayment(context);


    return
    
    MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<CurrencyPayModelView>())
    ],
    child:
    Scaffold(

      appBar: AppBar(
               leading: IconButton(
          icon: Icon(Icons.arrow_back, color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),
          onPressed: () {
            GetIt.instance.get<CurrencyPayModelView>().exit=true;
   
            Navigator.pop(context); // Navigate back
          }),
             backgroundColor:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
       
      ),
      backgroundColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
     

      body: SafeArea(
      
        child: 
        
        ListView(

          children: [WidgetQrWaller(),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Text("Network",style: TextStyle(fontSize: _deviceWidth*0.05,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[3]:GetIt.instance.get<ColorsDesign>().light[3],),),),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Text("LiteCoin",style: TextStyle(fontSize: _deviceWidth*0.05,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),),),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Text("Wallet Address",style: TextStyle(fontSize: _deviceWidth*0.05,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[3]:GetIt.instance.get<ColorsDesign>().light[3]),),),
          Expanded(child:           Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Text(GetIt.instance.get<env>().ltcWallet,style: TextStyle(fontSize: _deviceWidth*0.05,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),)),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Text("* Please note that confidential deposits via different address or address type will result in-deposits being lost due to blockchain algorithms",style: TextStyle(fontSize: _deviceWidth*0.04,color: Colors.red),))),
            ltcTotalSelector(),
            TimerSelector()
            


            
          

            ],
        )),
    )
    );
     
   
  }

  WidgetQrWaller(){

    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 20),
      width: _deviceWidth,
      alignment: Alignment.center,
      
      child: QrImageView(
        backgroundColor:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0] ,
        foregroundColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],
        
        data: GetIt.instance.get<env>().ltcWallet,
        version: QrVersions.auto,
        size: _deviceWidth*0.7,
        ));
  }

  Selector<CurrencyPayModelView,double?> ltcTotalSelector(){

    return Selector<CurrencyPayModelView,double?>(selector: (context,provider)=>provider.ltcValue,
    shouldRebuild: (previous,next)=>!identical(previous,next),

    builder: (context,value,child){
        return ltcTotal(value);

    },
    ) ;



  }

  Widget ltcTotal(double? ltcConversion){

    if(ltcConversion==null){

      return Center(child: CircularProgressIndicator(),);

    }
    return           Expanded(child: Container(
            padding: EdgeInsets.only(left: 20,top: 20),
            child: Text("To confirm your order you must send "+ltcConversion.toString()+"LTC to the above address",style: TextStyle(fontSize: _deviceWidth*0.04,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),)));

    
  }


  Selector<CurrencyPayModelView,String?> TimerSelector(){


    return Selector<CurrencyPayModelView,String?>(selector: (context,provider)=>provider.RemaininTime,
    
    shouldRebuild: (previous,next)=>!identical(previous,next),
    builder: (context,value,child){

      if(value==null){
        return Center(child: CircularProgressIndicator(),);
      }

      return     Expanded(child: Container(
            padding: EdgeInsets.only(left: 20),
            child:Row(children: [Text("Payment will expire in ",style: TextStyle(fontSize: _deviceWidth*0.04,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1])),
             Text(value,style: TextStyle(fontSize: _deviceWidth*0.04,color: Colors.red),)
            
            ],)
            
            ));


    },
    );
  }
}