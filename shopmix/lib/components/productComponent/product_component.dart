import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      Stack(children: [Stack(children: [Container(
        
        width: deviceWidth*0.35,height: deviceWidth*0.45,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(product.images.length==0?"https://longislandsportsdome.com/wp-content/uploads/2019/01/182-1826643_coming-soon-png-clipart-coming-soon-png-transparent.png": product.images[0].ImageUrl),fit: BoxFit.contain)),
        ),
        Positioned(
          top: deviceWidth*0.45/2.2,
          left: 0,
          right: 0,
          
          child: Container(
            alignment: Alignment.center,
            color: Colors.red,
            child: Visibility(
              visible: product.quantiy==0,
              child: Text("OUT OF STOCK",style: TextStyle(backgroundColor: Colors.red, color: Colors.white,fontSize: deviceWidth*0.03,fontWeight: FontWeight.w900),)),
          ))
        ],) ,
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
            onTap: () async{

              User? user=await FirebaseAuth.instance.currentUser;

              var data=(await FirebaseFirestore.instance.collection("favourites").where("user_email",isEqualTo: user!.email).where("product_id",isEqualTo: product.id).get()).docs;

               if(data.isEmpty){

                              await FirebaseFirestore.instance.collection("favourites").add({

                "product_id":product.id,
                "user_email":user!.email

              });

               }




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
            GetIt.instance<ProductDetailsModelView>().getProduct(product.id);
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
              children: [Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [Visibility(
              visible: product.salePercentage>0?true:false,
              child: Text(product.price.toString()+"\$",style: TextStyle(color: beforSaleFontColor,decoration: TextDecoration.lineThrough,fontSize: deviceWidth*0.03),)),
            Text((product.price-(product.price*product.salePercentage/100)).toStringAsFixed(2)+"\$",style: TextStyle(color: withSaleFontColor,fontSize: deviceWidth*0.04))],),
            
            GestureDetector(
              onTap: () async{ 

                if(product.quantiy!=0){

                                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                                            print(prefs.get("cart_id"));
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