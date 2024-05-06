import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/favourites_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/modelViews/product_details_model_view.dart';
import 'package:shopmix/models/product_model.dart';

class FavouriteProductComponent extends StatelessWidget {

  late ProductModel product;
  late double deviceWidth;
  late BuildContext context;
   Color saleBackgroundColor=GetIt.instance.get<ColorsDesign>().light[2];
  Color newBackgroundColor=GetIt.instance.get<ColorsDesign>().light[1];
  Color salesfontcolor=GetIt.instance.get<ColorsDesign>().light[0];
   Color newfontcolor=GetIt.instance.get<ColorsDesign>().light[0];
Color favouriteIconColor=GetIt.instance.get<ColorsDesign>().light[2];
  Color titleFontColor=GetIt.instance.get<ColorsDesign>().light[1];
  Color beforSaleFontColor=GetIt.instance.get<ColorsDesign>().light[3];
 Color withSaleFontColor=GetIt.instance.get<ColorsDesign>().light[2];

  Color addToCartColor=GetIt.instance.get<ColorsDesign>().light[1];

  Color RemoveFromFavoriteIconColor=GetIt.instance.get<ColorsDesign>().light[2];
  
  FavouriteProductComponent({required this.product,required this.deviceWidth,required this.context}){
    getpropertyColor(saleBackgroundColor, newBackgroundColor, salesfontcolor, newfontcolor, favouriteIconColor, titleFontColor, beforSaleFontColor, withSaleFontColor, addToCartColor, RemoveFromFavoriteIconColor);
  }




  @override
  Widget build(BuildContext context) {

      return SizedBox(width: deviceWidth,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [Container(
    margin: EdgeInsets.only(left: 20,right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Stack(children: [Container(
        
        width: 170,height: 250,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(product.images[0].ImageUrl),fit: BoxFit.contain)),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: Visibility(
            visible: product.salePercentage==0?false:true,
             child: Container(
          
          padding: EdgeInsets.only(top: 5,right: 10,bottom: 5,left: 10),
          child: Text("-"+product.salePercentage.toString()+"%",style: TextStyle(color: salesfontcolor),),
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
          child: Text("NEW",style: TextStyle(color: newfontcolor),),
          decoration: BoxDecoration(
            color: newBackgroundColor,
            borderRadius: BorderRadius.circular(15)),
        ))),
                    Positioned(
          right: 5,
          bottom: 5,
          child: Container(
            
          
          padding: EdgeInsets.all(10),
          child: Container(
            
            child: Icon(Icons.favorite,color:favouriteIconColor),),
            

             
             
        ),
        
        ),
       
    
    
        ],
        
        ),

        GestureDetector(
          onTap: (){
            GetIt.instance<ProductDetailsModelView>().changeProduct(product);
             Navigator.pushNamed(context, "/productDetail");


          },
          child: Container(child: Text(product.title,style: TextStyle(color: titleFontColor,fontWeight: FontWeight.bold,fontSize: 20),),),),
        
    
        SizedBox(
          width: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(
              
              children: [Visibility(
            visible: product.salePercentage>0?true:false,
            child: Text(product.price.toString()+"\$",style: TextStyle(color: beforSaleFontColor,decoration: TextDecoration.lineThrough),)),
          Text((product.price-(product.price*product.salePercentage/100)).toString()+"\$",style: TextStyle(color: withSaleFontColor))],),
          
          GestureDetector(
            onTap: () async{

                if(product.quantiy!=0){

                                            final SharedPreferences prefs = await SharedPreferences.getInstance();
          var cartitem=await FirebaseFirestore.instance.collection("cartItems").where("cart_id",isEqualTo: prefs.get("cart_id")).where("product_id",isEqualTo: product.id).limit(1).get();

          if(cartitem.docs.isNotEmpty){

                      DocumentReference docRef = cartitem.docs.first.reference;
              await docRef.update({
                "quantity":FieldValue.increment(1)
              });




          }
          else {
                         await FirebaseFirestore.instance.collection("cartItems").add({
      'cart_id': prefs.get("cart_id"),
      'product_id': product.id,
      'quantity': 1
    });

          }
          var cart=await FirebaseFirestore.instance.collection("carts").doc(prefs.get("cart_id").toString()).get();

          DocumentReference docref=cart.reference;

          await docref.update({
            "total":FieldValue.increment((product.price-(product.price*product.salePercentage/100)))

          });

                
                GetIt.instance.get<HomeModelView>().addToCart();

                GetIt.instance.get<CartModelView>().addProductTocart(product);
                }

                else {

                     Fluttertoast.showToast(
        msg: "This product cant be added to cart since it is out of stock",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
                  
                }
                
            },
            child: Container(child: Icon(Icons.add_shopping_cart,color:addToCartColor,),),
          )
          ],),
        )
    
    
    
    ],),
  ),
  
GestureDetector(
  onTap: () async{
                  User? user=await FirebaseAuth.instance.currentUser;


              (await FirebaseFirestore.instance.collection("favourites").where("product_id",isEqualTo: product.id).limit(1).get()).docs.first.reference.delete();


    GetIt.instance.get<FavouritesModelView>().deleteFromFavourites(product);
  },
  child:   Container(
    margin: EdgeInsets.only(right: 20),
    child: Icon(Icons.delete,color: RemoveFromFavoriteIconColor,),),)
  ],
  
        ),);


  }


          void getpropertyColor(Color _saleBackgroundColor,Color _newBackgroundColor,Color _salesfontcolor,Color _newfontcolor,
        Color _favouriteIconColor,Color _titleFontColor,Color _beforSaleFontColor,Color _withSaleFontColor,Color _addToCartColor,
        Color _RemoveFromFavoriteIconColor
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
    RemoveFromFavoriteIconColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_RemoveFromFavoriteIconColor);
      
    }
    else {
      
      
      

    }
    

  }


}

