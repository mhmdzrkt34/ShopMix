import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/models/order_items_model.dart';

import 'package:shopmix/models/order_model.dart';
import 'package:shopmix/repositories/orderRepository/IOrderRepository.dart';
import 'package:shopmix/repositories/orderRepository/OrderApi.dart';

class OrderModelView extends ChangeNotifier {


  IOrderRepository orderRepository=OrderApi();

  List<OrderModel>? orders;

  OrderModelView(){
    getOrders();

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

void addOrder(){

   int quantity=0;

    GetIt.instance.get<CartModelView>().cartItems.forEach((element) {
      quantity=quantity+element.quantity;



     });

    OrderModel order=new OrderModel(id: generateStringId(), user_id: "1", quantity: quantity, totalprice: GetIt.instance.get<CartModelView>().cart!.total);
     
     String orderItemId=generateStringId();
       GetIt.instance.get<CartModelView>().cartItems.forEach((element) {

        order.items.add(new OrderItems(id: orderItemId, product_id: element.product_id, quantity: element.quantity, product: element.product, name: element.product.title));
      



     });  

     orders!.add(order);
     orders=List.from(orders!);
     GetIt.instance.get<CartModelView>().clearCart();
     notifyListeners();

  
}

  String generateStringId({int length = 20}) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
}




  
}