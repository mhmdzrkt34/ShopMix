import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';

class AllSalesModelView extends ChangeNotifier {
 List<ProductModel>? SalesProduct;

  AllSalesModelView(){

  }


  void getSalesproducts(List<ProductModel> allSalesProduct){
    SalesProduct=allSalesProduct;
    notifyListeners();
  }
}