

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/components/productComponent/product_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/home_body_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/modelViews/product_details_model_view.dart';
import 'package:shopmix/modelViews/setting_model_view.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';
import 'package:tuple/tuple.dart';

class productDetailsView extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<ProductDetailsModelView>()),
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

      body:SingleChildScrollView(child: Column(children: [productSelector()],),),
        appBar: AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,searchVisible: false,filter: Filter,),

      
      
    );
      



    }
    );
}

Selector<ProductDetailsModelView,Tuple2<ProductModel?,int>> productSelector(){


  return Selector<ProductDetailsModelView,Tuple2<ProductModel?,int>>(selector: (context,provider)=>Tuple2(provider.product, provider.currentImageIndex),
  shouldRebuild: (previous, next) =>!identical(previous.item1,next.item1) || !identical(previous.item2, next.item2) ,
  builder: (context, value, child){

    if (value.item1==null) {

      return Center(child: CircularProgressIndicator(),);
      
    }
              return Container(
    margin: EdgeInsets.only(left: 10,right: 10),
    child: Container(
      width: _deviceWidth,
      
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Stack(children: [Container(
          
          width: _deviceWidth*0.9,height: _deviceHeight*0.45,
          decoration: BoxDecoration(image: DecorationImage(image:  NetworkImage(value.item1!.images.length==0?"https://longislandsportsdome.com/wp-content/uploads/2019/01/182-1826643_coming-soon-png-clipart-coming-soon-png-transparent.png" :  value.item1!.images[GetIt.instance.get<ProductDetailsModelView>().currentImageIndex].ImageUrl),fit: BoxFit.contain)),
          ),
          Positioned(
            left: 5,
            top: 5,
            child: Visibility(
              visible: value.item1!.salePercentage==0?false:true,
               child: Container(
            
            padding: EdgeInsets.only(top: 5,right: 10,bottom: 5,left: 10),
            child: Text("-"+value.item1!.salePercentage.toString()+"%",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],fontSize: _deviceWidth*0.035),),
            decoration: BoxDecoration(
              color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],
              borderRadius: BorderRadius.circular(15)),
          ),)),
      
                Positioned(
            right: 5,
            top: 5,
            child: Visibility(
              visible: value.item1!.isNew?true:false,
              child: Container(
            
            padding: EdgeInsets.only(top: 5,right: 10,bottom: 5,left: 10),
            child: Text("NEW",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],fontSize: _deviceWidth*0.035),),
            decoration: BoxDecoration(
              color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],
              borderRadius: BorderRadius.circular(15)),
          ))),
                      Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              
            
            padding: EdgeInsets.all(10),
            child: Container(
              
              child: Icon(Icons.favorite_border,color:GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[3]:GetIt.instance.get<ColorsDesign>().light[3]),),
              
      
               
               
          ),
          
          ),
         
      
      
          ],
          
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:value.item1!.images.length==0? Container(
                
                margin: EdgeInsets.only(right: 10),
              
                width: _deviceWidth*0.2, height: _deviceWidth*0.2,decoration: BoxDecoration(
                  border: Border.all(color: GetIt.instance.get<ColorsDesign>().light[2]),
                  image: DecorationImage(image: NetworkImage("https://longislandsportsdome.com/wp-content/uploads/2019/01/182-1826643_coming-soon-png-clipart-coming-soon-png-transparent.png"),fit: BoxFit.contain)),): Row(children:value.item1!.images.asMap().entries.map<Widget>((e){
             

              return GestureDetector(
                onTap: (){
                  GetIt.instance.get<ProductDetailsModelView>().changeImageIndex(e.key);


                },
                child: Container(
                
                margin: EdgeInsets.only(right: 10),
              
                width: _deviceWidth*0.2, height: _deviceWidth*0.2,decoration: BoxDecoration(
                  border: Border.all(color: e.key==value.item2?GetIt.instance.get<ColorsDesign>().light[2]:GetIt.instance.get<ColorsDesign>().light[3]),
                  image: DecorationImage(image: NetworkImage(e.value.ImageUrl),fit: BoxFit.contain)),),);

            }).toList(),),),
      
          GestureDetector(
            
            onTap: (){
              Navigator.pushNamed(context, "/productDetail");
              
            },
            child:         Expanded(child: Container(
            
            
            child: Text("Product Name:"+value.item1!.title,style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],fontWeight: FontWeight.bold,fontSize: _deviceWidth*0.06),),),))
      ,
      Container(child: Text("Description:"+value.item1!.description,style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],fontSize: _deviceWidth*0.035),),),

      
      
          SizedBox(
            width: _deviceWidth,
            
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Row(
                  
                  children: [Visibility(
                visible: value.item1!.salePercentage>0?true:false,
                child: Text(value.item1!.price.toString()+"\$",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[3]:GetIt.instance.get<ColorsDesign>().light[3],decoration: TextDecoration.lineThrough,fontSize: _deviceWidth*0.04),)),
              Text((value.item1!.price-(value.item1!.price*value.item1!.salePercentage/100)).toString()+"\$",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],fontSize: _deviceWidth*0.05))],),
              
              GestureDetector(
                onTap: (){
                  GetIt.instance.get<HomeModelView>().addToCart();
                  GetIt.instance.get<CartModelView>().addProductTocart(value.item1!);
                },
                child: Container(child: Icon(Icons.add_shopping_cart,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),),
              )
              ],),
            ),
          )
      
      
      
      ],),
    ),
  );






    


  },
  );
}







void Filter(String value){

  print(value);
}


}