import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';

class ProductDetailsModelView extends ChangeNotifier {

ProductModel? product;

int currentImageIndex=0;
ProductDetailsModelView();



void changeProduct(ProductModel productt){


  product=productt;
  currentImageIndex=0;
  notifyListeners();
}

void changeImageIndex(int index){
  currentImageIndex=index;
  notifyListeners();
}


}