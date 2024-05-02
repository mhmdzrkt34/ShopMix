import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';

class AllNewProductModelView extends ChangeNotifier {

  List<ProductModel>? newProducts;

   List<ProductModel>? filterNewProducts;


  Future<void> getAllNewProducts(List<ProductModel>? allnewproducts) async{

    newProducts=allnewproducts;
    filterNewProducts=newProducts;
    notifyListeners();




  }

    void Filter(String value){

    if(filterNewProducts==null){


    }


    else {

    


    filterNewProducts=List.from(newProducts!.where((element) => element.title.toUpperCase().contains(value.toUpperCase())).toList());
    notifyListeners();}
  }
  




}