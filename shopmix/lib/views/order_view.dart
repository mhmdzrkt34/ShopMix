import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/components/cartProductComponent/cart_product_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/order_model_view.dart';
import 'package:shopmix/modelViews/setting_model_view.dart';
import 'package:shopmix/models/order_model.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';
import 'package:shopmix/providers/map_page_provider.dart';

class OrderView extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<OrderModelView>()),
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

      body:SingleChildScrollView(child: Column(children: [

        OrdersWidgetSelector()
      ],),),
        appBar: AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,searchVisible: false,filter: Filter,),

      
      
    );
      



    }
    );
}



Selector<OrderModelView,List<OrderModel>?> OrdersWidgetSelector(){

  return Selector<OrderModelView,List<OrderModel>?>(selector: (context,provider)=>provider.orders,
  shouldRebuild: (previous,next)=>!identical(previous, next),
  builder: (context,value,child){
    return OrderWidget(value);





  },
  );




}

Widget OrderWidget(List<OrderModel>? value){

  if(value == null){
    return Center(child: CircularProgressIndicator(),);
  }


       return Container(
    width: _deviceWidth,
   
    child: Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

    Container(
      padding: EdgeInsets.only(left: 20),
      child: Text("Total number of orders:"+value!.length.toString(),style: TextStyle(fontSize: _deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),),),

    Container(
      child: ListView.builder(
        shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
        
      

        itemCount:value.length, itemBuilder: (BuildContext context,int index){
      
        return Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(
            width: 1,
            color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]
          ))),
          
          
          child: Container(
            width: _deviceWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text("order Id:"+value[index].id,style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1] ),),),
              Container(
                 padding: EdgeInsets.only(left: 20),
                child: Text("number of items:"+value[index].quantity.toString(),style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1] ),),),
              Container(
                
                 padding: EdgeInsets.only(left: 20),
                child: Text("Total price:"+value[index].totalprice.toStringAsFixed(3)+"\$",style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1] ),),),

                Container(
                   padding: EdgeInsets.only(left: 20),
                  child: Visibility(

                  visible: value[index].delivered==true,
                  child: Container(child:Text("Order Delivery is Completed:",style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1] ),),),),
                ),

                GestureDetector(
                  onTap: (){

                    GetIt.instance.get<MapPageProvider>().start(value[index]);

                    Navigator.pushNamed(context, "mapDistancePage");
                  },
                  child:              Container(
                   padding: EdgeInsets.only(left: 20),
                  child: Visibility(

                  visible: value[index].delivered==false,
                  child: Container(child:Text("Status:undelivered press the line to check delivery status",style: TextStyle(fontSize:_deviceWidth*0.04,color:Colors.red, decoration: TextDecoration.underline,decorationColor: Colors.red ),),),),
                ),),
    
            
              Container(
                 padding: EdgeInsets.only(left: 20),
                width: _deviceWidth,
              
                child:Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Container(child: Text("Order Product details",style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),),),
                    GestureDetector(onTap: (){
                      GetIt.instance.get<OrderModelView>().orderDetailsClick(index);
                              
                    },
                    child: Container(child: Icon(value[index].itemVisible? Icons.arrow_drop_up:Icons.arrow_drop_down,size: _deviceWidth*0.07,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),),),

                    ],
                  ),
                ) ,),
                                    Visibility(
                                      visible: value[index].itemVisible,
                                      child: Container(
                      
                      child: ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                       
                      itemCount: value[index].items.length, itemBuilder: (BuildContext context,int indextwo){
                              
                        return CartProductComponent(product: value[index].items[indextwo].product, quantity: value[index].items[indextwo].quantity, deviceWidth: _deviceWidth, deviceHeight: _deviceHeight, isremoveVisible:false,context: context,);
                              
                              
                              
                              
                              
                    }),))
              
            
            ],),
          ),
        );
      
      
      }),
    )

    
   ],),);



}
void Filter(String value){

  print(value);
}




}