import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';

class AllNewProductModelView extends ChangeNotifier {

  List<ProductModel>? newProducts;


  Future<void> getAllNewProducts(List<ProductModel>? allnewproducts) async{

    newProducts=allnewproducts;
    notifyListeners();




  }




}