import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/favourites_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/modelViews/product_details_model_view.dart';
import 'package:shopmix/models/product_model.dart';

class ProductComponent extends StatelessWidget {

  late ProductModel product;

  late double deviceWidth;
  late double deviceHeight;

  late Color saleBackgroundColor=GetIt.instance.get<ColorsDesign>().light[2];
  late Color newBackgroundColor=GetIt.instance.get<ColorsDesign>().light[1];
  late Color salesfontcolor=GetIt.instance.get<ColorsDesign>().light[0];
  late Color newfontcolor=GetIt.instance.get<ColorsDesign>().light[0];
  late Color favouriteIconColor=GetIt.instance.get<ColorsDesign>().light[3];
  late Color titleFontColor=GetIt.instance.get<ColorsDesign>().light[1];
  late Color beforSaleFontColor=GetIt.instance.get<ColorsDesign>().light[3];
  late Color withSaleFontColor=GetIt.instance.get<ColorsDesign>().light[2];

  late Color addToCartColor=GetIt.instance.get<ColorsDesign>().light[1];

  late BuildContext context;

  ProductComponent({required this.product,required this.deviceWidth,required this.deviceHeight,required this.context}){
    getpropertyColor(saleBackgroundColor, newBackgroundColor, salesfontcolor, newfontcolor, favouriteIconColor, titleFontColor, beforSaleFontColor, withSaleFontColor,addToCartColor);
  }
  




  @override
  Widget build(BuildContext context) {

      return Container(
    margin: EdgeInsets.only(left: 10,right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Stack(children: [Container(
        
        width: deviceWidth*0.35,height: deviceWidth*0.45,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(product.images[0].ImageUrl),fit: BoxFit.contain)),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: Visibility(
            visible: product.salePercentage==0?false:true,
             child: Container(
          
          padding: EdgeInsets.only(top: 5,right: 10,bottom: 5,left: 10),
          child: Text("-"+product.salePercentage.toString()+"%",style: TextStyle(color: salesfontcolor,fontSize: deviceWidth*0.035),),
          decoration: BoxDecoration(
            color: saleBackgroundColor,
            borderRadius: BorderRadius.circular(15)),
        ),)),
    
              Positioned(
          right: 5,
          top: 5,
          child: Visibility(
            visible: product.isNew?true:false,
            child: Container(
          
          padding: EdgeInsets.only(top: 5,right: 10,bottom: 5,left: 10),
          child: Text("NEW",style: TextStyle(color: newfontcolor,fontSize: deviceWidth*0.035),),
          decoration: BoxDecoration(
            color: newBackgroundColor,
            borderRadius: BorderRadius.circular(15)),
        ))),
                    Positioned(
          right: 5,
          bottom: 5,
          child: Container(
            
          
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: (){

              GetIt.instance.get<FavouritesModelView>().addToFavourites(product);
            },
            child: Container(
            
            child: Icon(Icons.favorite_border,color:favouriteIconColor),),),
            

             
             
        ),
        
        ),
       
    
    
        ],
        
        ),

        GestureDetector(
          
          onTap: (){
            GetIt.instance<ProductDetailsModelView>().changeProduct(product);
            Navigator.pushNamed(context, "/productDetail");
            
          },
          child:         Container(
          width: deviceWidth*0.35,
          
          child: Text(product.title,style: TextStyle(color: titleFontColor,fontWeight: FontWeight.bold,fontSize: deviceWidth*0.05),),),)
,
    
        SizedBox(
          width: deviceWidth*0.35,
          
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Row(
                
                children: [Visibility(
              visible: product.salePercentage>0?true:false,
              child: Text(product.price.toString()+"\$",style: TextStyle(color: beforSaleFontColor,decoration: TextDecoration.lineThrough,fontSize: deviceWidth*0.03),)),
            Text((product.price-(product.price*product.salePercentage/100)).toString()+"\$",style: TextStyle(color: withSaleFontColor,fontSize: deviceWidth*0.04))],),
            
            GestureDetector(
              onTap: (){
                GetIt.instance.get<HomeModelView>().addToCart();

                GetIt.instance.get<CartModelView>().addProductTocart(product);
              },
              child: Container(child: Icon(Icons.add_shopping_cart,color: addToCartColor,),),
            )
            ],),
          ),
        )
    
    
    
    ],),
  );



  }

        void getpropertyColor(Color _saleBackgroundColor,Color _newBackgroundColor,Color _salesfontcolor,Color _newfontcolor,
        Color _favouriteIconColor,Color _titleFontColor,Color _beforSaleFontColor,Color _withSaleFontColor,Color _addToCartColor
        ) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

    saleBackgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_saleBackgroundColor);
    newBackgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_newBackgroundColor);
    salesfontcolor=GetIt.instance.get<ColorsDesign>().getdarkColor(_salesfontcolor);
    newfontcolor=GetIt.instance.get<ColorsDesign>().getdarkColor(_newfontcolor);
    favouriteIconColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_favouriteIconColor);
    titleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_titleFontColor);
    beforSaleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_beforSaleFontColor);
    withSaleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_withSaleFontColor);
    addToCartColor=GetIt.instance.get<ColorsDesign>().getdarkColor(addToCartColor);

      
    }
    else {
      
      
      

    }
    

  }
}