import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';

class AllSalesModelView extends ChangeNotifier {
 List<ProductModel>? SalesProduct;
  List<ProductModel>? FilterSalesProduct;

  AllSalesModelView(){

  }


  void getSalesproducts(List<ProductModel> allSalesProduct){
    SalesProduct=allSalesProduct;
    FilterSalesProduct=SalesProduct;
    notifyListeners();
  }

  void Filter(String value){

    if(FilterSalesProduct==null){


    }


    else {

    


    FilterSalesProduct=List.from(SalesProduct!.where((element) => element.title.toUpperCase().contains(value.toUpperCase())).toList());
    notifyListeners();}
  }
}
