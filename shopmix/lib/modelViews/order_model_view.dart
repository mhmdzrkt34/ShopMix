import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/models/order_items_model.dart';

import 'package:shopmix/models/order_model.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/orderRepository/IOrderRepository.dart';
import 'package:shopmix/repositories/orderRepository/OrderApi.dart';

class OrderModelView extends ChangeNotifier {


  IOrderRepository orderRepository=OrderApi();

  List<OrderModel> orders=[];

  OrderModelView(){
    

  }



  void orderDetailsClick(int index){
    orders![index].itemVisible=!orders![index].itemVisible;

    orders=List.from(orders!);
   
    notifyListeners();






  }

Future<void> getOrders() async {
  orders=await orderRepository.getorders();
  notifyListeners();
}

Future<void> addOrder(BuildContext context) async{
  int error=0;

   GetIt.instance.get<CartModelView>().cartItems.forEach((element) {

    if(GetIt.instance.get<AllProductModelView>().products!.firstWhere((item) => item.id==element.product.id).quantiy<element.quantity){
        error=1;


    }



   });

   if(error==1){

               Fluttertoast.showToast(
        msg: "there is an item in the order exeeds stock limit go and check before continue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      
   }
   if(error==0){

    User? user=FirebaseAuth.instance.currentUser;

   int quantity=0;

    GetIt.instance.get<CartModelView>().cartItems.forEach((element) {
      quantity=quantity+element.quantity;



     });
     var orderAdded=await (await FirebaseFirestore.instance.collection("orders").add({
      "totalPrice":GetIt.instance.get<CartModelView>().cart!.total,
      "quantity":quantity,
      "user_email":user!.email,
      "date":DateTime.timestamp()

      
     })).get();
     Map<String,dynamic> orderAddedJson=orderAdded.data() as Map<String,dynamic>;
     orderAddedJson['id']=orderAdded.id;

     

    OrderModel order=new OrderModel(id:  orderAddedJson['id'], email: orderAddedJson["user_email"], quantity: orderAddedJson["quantity"], totalprice: orderAddedJson["totalPrice"],date: orderAddedJson["date"].toDate());
     
    
       GetIt.instance.get<CartModelView>().cartItems.forEach((element) async{

        

            var orderItemAdded=await (await FirebaseFirestore.instance.collection("orderItems").add({
"quantity":element.quantity,
"product_id":element.product_id,
"order_id":order.id

      
     })).get();
     Map<String,dynamic> orderItemAddedJson=orderItemAdded.data() as Map<String,dynamic>;
     orderItemAddedJson['id']=orderItemAdded.id;

        order.items.add(new OrderItems(id: orderItemAddedJson['id'], product_id: element.product_id, quantity: element.quantity, product: element.product, name: element.product.title));


        (await FirebaseFirestore.instance.collection("products").doc(element.product_id)).update({
          "quantity":FieldValue.increment(-element.quantity)
        });
      



     });  

     orders!.add(order);
     orders=List.from(orders!);

                 final SharedPreferences prefs = await SharedPreferences.getInstance();

        
     var querysnapshocartItems=(await FirebaseFirestore.instance.collection("cartItems").where("cart_id",isEqualTo: prefs.getString("cart_id")).get()).docs;

     for(var val  in querysnapshocartItems){

      await val.reference.delete();
     }

     (await FirebaseFirestore.instance.collection("carts").where("email",isEqualTo: user!.email).limit(1).get()).docs.first.reference.update({
      "total":0
     });
     GetIt.instance.get<CartModelView>().clearCart();
        Navigator.pushNamed(context, "/orders");
     notifyListeners();

   }

  
  

  
}



Future<void> fetchOrders() async{
  orders=[];


  User? user= FirebaseAuth.instance.currentUser;

  var ordersFirebase=(await FirebaseFirestore.instance.collection("orders").where("user_email",isEqualTo: user!.email).get()).docs;


  



  for(var item in ordersFirebase){
    Map<String,dynamic> jsonDataOrder=item.data() as Map<String,dynamic>;

    OrderModel order=OrderModel(id: item.id, email: jsonDataOrder["user_email"], quantity: jsonDataOrder['quantity'], totalprice: jsonDataOrder['totalPrice'],date:jsonDataOrder["date"].toDate());

    var orderItemsFirebase=(await FirebaseFirestore.instance.collection("orderItems").where("order_id",isEqualTo: order.id).get()).docs;

    for(var itemTwo in orderItemsFirebase){

      Map<String,dynamic> jsonDataOrderItem=itemTwo.data() as Map<String,dynamic>;

     print("productId:"+ jsonDataOrderItem["product_id"]);
      Map<String,dynamic> ProductFirebase=(await FirebaseFirestore.instance.collection("products").doc(jsonDataOrderItem["product_id"]).get()).data() as Map<String,dynamic>;

      ProductFirebase['id']=jsonDataOrderItem["product_id"];


      ProductModel productOrder=await ProductModel.FromJson(ProductFirebase);

      order.items.add(OrderItems(id: itemTwo.id, product_id: productOrder.id, quantity: jsonDataOrderItem['quantity'], product: productOrder, name: productOrder.title));

      

    }
    orders.add(order);




  }

  orders=List.from(orders);
  notifyListeners();



}


  
}