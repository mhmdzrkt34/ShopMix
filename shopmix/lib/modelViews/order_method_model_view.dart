import 'package:flutter/material.dart';

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
}