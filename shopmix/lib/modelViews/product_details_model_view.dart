import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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

void getProduct(String productID) async{
  currentImageIndex=0;
  FirebaseFirestore.instance.collection("products").doc(productID).snapshots().listen((snapshot) async{ 


    Map<String,dynamic> json=snapshot.data() as Map<String,dynamic>;

        json['id']=snapshot.id;
        ProductModel productFetched=await ProductModel.FromJson(json);
        product=productFetched;

        notifyListeners();
  });


}


}