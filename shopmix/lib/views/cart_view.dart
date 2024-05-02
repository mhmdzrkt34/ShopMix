import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/components/cartProductComponent/cart_product_component.dart';

import 'package:shopmix/designs/colors_design.dart';

import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/models/cart_items_model.dart';
import 'package:shopmix/models/product_model.dart';

import 'package:shopmix/providers/dark_mode_provider.dart';


class CartView extends StatelessWidget {
late ProductModel test=GetIt.instance.get<Seeding>().products[1];
late double _deviceWidth;
late double _deviceHeight;
late BuildContext currentcontext;
  
  @override
  Widget build(BuildContext context) {
    currentcontext=context;
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<CartModelView>()),

    ],
    child: ScaffoldSelector()
    );

  }

        Selector<darkModeProvider,bool> ScaffoldSelector(){
    return Selector<darkModeProvider,bool>(selector: (context,provider)=>provider.isDark,
    shouldRebuild: (previous,next)=>!identical(previous,next),
    builder: (context, value, child){

      return Scaffold(
        body: SingleChildScrollView(child: CartItemsSelector()),

      backgroundColor:value?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    );
      



    }
    );
}


Selector<CartModelView,List<CartItemsModel>> CartItemsSelector(){

 
  


  return Selector<CartModelView,List<CartItemsModel>>(selector: (context,provider)=>provider.cartItems,
  shouldRebuild: (previous,next)=>!identical(previous, next),

  builder: (context, value, child){
     //print(GetIt.instance.get<CartModelView>().cart.total.toString());

    return cartItems(value);

    


  },
  );
}


Widget cartItems(List<CartItemsModel> items){
  

  if(GetIt.instance.get<CartModelView>().cart==null){
    return Center(child: CircularProgressIndicator(),);
  }


  if(items.isEmpty){
    return Center(child: Text("your cart is empty",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],)));
  }

  return Column(children: [Column(children: items.map<Widget>((e){
    print(e.quantity.toString());

    return CartProductComponent(product:  e.product,deviceHeight: _deviceHeight,deviceWidth: _deviceWidth,quantity: e.quantity,isremoveVisible: true,context: currentcontext,);



  }).toList(),),
  
  Container(
    margin:  EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
    width: _deviceWidth,
    child: Text("Total:"+GetIt.instance.get<CartModelView>().cart!.total.toString()+"\$",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],fontSize: _deviceWidth*0.05,fontWeight: FontWeight.bold),),),

  Container(
   
    width: _deviceWidth,
     padding:EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
  
  child: MaterialButton(
    color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],
    textColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    
    
    
    onPressed: (){
      Navigator.pushNamed(currentcontext, "/orderMethodView");


    },
  child: Text("Proceed To Checkout"),),)  
  ],);
}




}