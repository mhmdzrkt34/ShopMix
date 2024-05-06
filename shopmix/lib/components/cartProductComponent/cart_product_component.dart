import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/modelViews/product_details_model_view.dart';
import 'package:shopmix/models/product_model.dart';

class CartProductComponent extends StatelessWidget {


  late ProductModel product;

  late int quantity;
  late double deviceWidth;
  late double deviceHeight;
  late bool isremoveVisible;
  late BuildContext context;

     Color saleBackgroundColor=GetIt.instance.get<ColorsDesign>().light[2];
  Color newBackgroundColor=GetIt.instance.get<ColorsDesign>().light[1];
  Color salesfontcolor=GetIt.instance.get<ColorsDesign>().light[0];
   Color newfontcolor=GetIt.instance.get<ColorsDesign>().light[0];

  Color titleFontColor=GetIt.instance.get<ColorsDesign>().light[1];
  Color beforSaleFontColor=GetIt.instance.get<ColorsDesign>().light[3];
 Color withSaleFontColor=GetIt.instance.get<ColorsDesign>().light[2];



  Color RemoveFromCartIconColor=GetIt.instance.get<ColorsDesign>().light[2];

  Color UpAndDownColor=GetIt.instance.get<ColorsDesign>().light[1];

  Color TotalFontColor=GetIt.instance.get<ColorsDesign>().light[1];
  Color TextFormColor=GetIt.instance.get<ColorsDesign>().light[1];

  CartProductComponent({required this.product,required this.quantity,required this.deviceWidth,required this.deviceHeight,required this.isremoveVisible,required this.context}){
    getpropertyColor(saleBackgroundColor, newBackgroundColor, salesfontcolor, newfontcolor, titleFontColor, beforSaleFontColor, withSaleFontColor, RemoveFromCartIconColor, UpAndDownColor, TotalFontColor, TextFormColor);
  }






  @override
  Widget build(BuildContext context) {
    return  SizedBox(width: deviceWidth,
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
  children: [Container(
    padding:EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
    margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Stack(children: [Container(
        
        width: deviceWidth*0.3,height: deviceHeight*0.3,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(product.images[0].ImageUrl),fit: BoxFit.contain)),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: Visibility(
            visible: product.salePercentage==0?false:true,
             child: Container(
          
          padding: EdgeInsets.only(top: 5,right: 10,bottom: 5,left: 10),
          child: Text("-"+product.salePercentage.toString()+"%",style: TextStyle(fontSize: deviceWidth*0.03, color: salesfontcolor),),
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
          child: Text("NEW",style: TextStyle(fontSize: deviceWidth*0.03, color: newfontcolor),),
          decoration: BoxDecoration(
            color: newBackgroundColor,
            borderRadius: BorderRadius.circular(15)),
        ))),

       
    
    
        ],
        
        ),
        GestureDetector(
          onTap: (){

            GetIt.instance<ProductDetailsModelView>().changeProduct(product);
            Navigator.pushNamed(context, "/productDetail");
          },
          child: Container(child: Text(product.title,style: TextStyle(color: titleFontColor,fontWeight: FontWeight.bold,fontSize: deviceWidth*0.05),),),),
    
        SizedBox(
          width: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(
              
              children: [Visibility(
            visible: product.salePercentage>0?true:false,
            child: Text(product.price.toStringAsFixed(2)+"\$",style: TextStyle(color: beforSaleFontColor,decoration: TextDecoration.lineThrough,fontSize: deviceWidth*0.03),)),
          Text((product.price-(product.price*product.salePercentage/100)).toStringAsFixed(2)+"\$",style: TextStyle(color: withSaleFontColor,fontSize: deviceWidth*0.03))],),
          

          ],),
        )
    
    
    
    ],),
  ),
  
  Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      

      
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(children: [Row(children: [      GestureDetector(
          onTap: () async{

                            final SharedPreferences prefs = await SharedPreferences.getInstance();
          var cartitem=await FirebaseFirestore.instance.collection("cartItems").where("cart_id",isEqualTo: prefs.get("cart_id")).where("product_id",isEqualTo: product.id).limit(1).get();

          if(GetIt.instance.get<AllProductModelView>().products!.firstWhere((element) => element.id==product.id).quantiy>quantity){

                                  DocumentReference docRef = cartitem.docs.first.reference;
              await docRef.update({
                "quantity":FieldValue.increment(1)
              });
              print(prefs.getString("cart_id"));

                                   var cart=await FirebaseFirestore.instance.collection("carts").doc(prefs.getString("cart_id")).get();

          DocumentReference docref=cart.reference;

          await docref.update({
            "total":FieldValue.increment((product.price-(product.price*product.salePercentage/100)))

          });

              

              





            GetIt.instance.get<CartModelView>().addProductQuantity(product);

          }
          else {
               Fluttertoast.showToast(
        msg: "you cant add more there is no more in the stock",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
          }

      


            
          },
          child: Visibility(visible: isremoveVisible,child: Container(child: Icon(size: deviceWidth*0.08, Icons.arrow_upward,color: UpAndDownColor,),),),),
      Container(
        alignment: Alignment.center,
        width: deviceWidth*0.05,
        child: /*TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          enabled: false,
          initialValue:quantity.toString(),
          decoration: InputDecoration(
            
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
          cursorColor: Colors.black,
          style: TextStyle(fontSize: deviceWidth*0.05,color: TextFormColor),
          
        )*/
        
        Text(quantity.toString(),style: TextStyle(fontSize: deviceWidth*0.05,color: TextFormColor)),),
       GestureDetector(
        onTap: () async{
          if(quantity>1){
          
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
          var cartitem=await FirebaseFirestore.instance.collection("cartItems").where("cart_id",isEqualTo: prefs.get("cart_id")).where("product_id",isEqualTo: product.id).limit(1).get();

      

                      DocumentReference docRef = cartitem.docs.first.reference;
              await docRef.update({
                "quantity":FieldValue.increment(-1)
              });

                        var cart=await FirebaseFirestore.instance.collection("carts").doc(prefs.getString("cart_id")).get();

          DocumentReference docref=cart.reference;

          await docref.update({
            "total":FieldValue.increment(-(product.price-(product.price*product.salePercentage/100)))

          });
          }



          GetIt.instance<CartModelView>().subProductquantity(product);
        },
        child:  Visibility(visible: isremoveVisible, child: Container(
          
          child: Icon(size: deviceWidth*0.08, Icons.arrow_downward,color: UpAndDownColor,),)),)],),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text("Total:"+(quantity*(product.price-(product.price*product.salePercentage/100))).toStringAsFixed(3)+"\$",style:TextStyle(color: UpAndDownColor),),)
          ],)


    ],),
   

    Visibility(
      visible: isremoveVisible,
      child: GestureDetector(
        onTap: () async{

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var cartitem=await FirebaseFirestore.instance.collection("cartItems").where("cart_id",isEqualTo: prefs.get("cart_id")).where("product_id",isEqualTo: product.id).limit(1).get();
          DocumentReference docRef = cartitem.docs.first.reference;
              await docRef.delete()
        .then((_) => print("Document successfully deleted!"))
        .catchError((error) => print("Failed to delete document: $error"));


                                var cart=await FirebaseFirestore.instance.collection("carts").doc(prefs.getString("cart_id")).get();

          DocumentReference docref=cart.reference;

          await docref.update({
            "total":FieldValue.increment(-((product.price-(product.price*product.salePercentage/100))*quantity))

          });

          
          GetIt.instance.get<CartModelView>().removeProductFromCart(product,quantity);
          GetIt.instance.get<HomeModelView>().removeCountFromCart(quantity);
        },
        child: Icon(Icons.delete,color: RemoveFromCartIconColor,),))
  ],)
  ],
  ),
  );

  }


  
          void getpropertyColor(Color _saleBackgroundColor,Color _newBackgroundColor,Color _salesfontcolor,Color _newfontcolor,
        Color _titleFontColor,Color _beforSaleFontColor,Color _withSaleFontColor,
        Color _RemoveFromCartIconColor,Color _UpAndDownColor,Color _TotalFontColor,Color _TextFormColor
        ) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

    saleBackgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_saleBackgroundColor);
    newBackgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_newBackgroundColor);
    salesfontcolor=GetIt.instance.get<ColorsDesign>().getdarkColor(_salesfontcolor);
    newfontcolor=GetIt.instance.get<ColorsDesign>().getdarkColor(_newfontcolor);
    
    titleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_titleFontColor);
    beforSaleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_beforSaleFontColor);
    withSaleFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_withSaleFontColor);

    RemoveFromCartIconColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_RemoveFromCartIconColor);
    UpAndDownColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_UpAndDownColor);
    TotalFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_TotalFontColor);
    TextFormColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_TextFormColor);

      
    }
    else {
      
      
      

    }
    
        }
}