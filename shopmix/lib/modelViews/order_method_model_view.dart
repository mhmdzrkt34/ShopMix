
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/order_model_view.dart';
import 'package:shopmix/models/order_items_model.dart';
import 'package:shopmix/models/order_model.dart';

class OrderMethodModelView extends ChangeNotifier {



  bool payOnDelivery=true;



  OrderMethodModelView();

  void makePayOnDeliveryTrue(){

    payOnDelivery=true;
    notifyListeners();
  }

    void makePayOnDeliveryFalse(){

    payOnDelivery=false;
    notifyListeners();
  }

  void payOnDeliveryCLick(BuildContext context){

    GetIt.instance.get<OrderModelView>().addOrder(context);

 







  }


}