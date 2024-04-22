import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';

class AllProductModelView extends ChangeNotifier {
IProductRepository productRepository=ProductFirebase();
  
 List<ProductModel>? products;


  AllProductModelView(){
    
  }

      Future<void> GetProducts(List<ProductModel>? allproducts) async{

    products=allproducts;
    notifyListeners();
  }
}