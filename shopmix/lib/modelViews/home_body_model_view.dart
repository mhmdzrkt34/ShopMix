import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';

class HomeBodyModelView extends ChangeNotifier {
IProductRepository productRepository=ProductFirebase();

 List<ProductModel>? products;

  HomeBodyModelView(){
    GetProducts();
  }

    Future<void> GetProducts() async{

    products=await productRepository.getProducts();
    notifyListeners();
  }
}