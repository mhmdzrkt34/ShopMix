import 'package:flutter/material.dart';

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




  
}