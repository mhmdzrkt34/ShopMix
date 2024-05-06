import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';

class AllProductModelView extends ChangeNotifier {
IProductRepository productRepository=ProductFirebase();
  
 List<ProductModel>? products;
  List<ProductModel>? filterProducts;


  AllProductModelView(){
    
  }

      Future<void> GetProducts(List<ProductModel>? allproducts) async{


    products=allproducts;
    filterProducts=allproducts;
    notifyListeners();
  }



  
  void Filter(String value){

    if(filterProducts==null){


    }


    else {

    


    filterProducts=List.from(products!.where((element) => element.title.toUpperCase().contains(value.toUpperCase())).toList());
    notifyListeners();}
  }
}