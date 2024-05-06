import 'package:async/async.dart';
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

      Stream<QuerySnapshot> productImagesStream = FirebaseFirestore.instance
    .collection('productImages')
    .where("product_id", isEqualTo: productID)
    .snapshots();

         Stream<DocumentSnapshot> productsStream = FirebaseFirestore.instance.collection("products").doc(productID).snapshots();

            StreamGroup<dynamic> streamGroup = StreamGroup<dynamic>();

            streamGroup.add(productsStream);
            streamGroup.add(productImagesStream);

            streamGroup.stream.listen((event) async{

              var data=await FirebaseFirestore.instance.collection("products").doc(productID).get();
                  Map<String,dynamic> json=data.data() as Map<String,dynamic>;

                      json['id']=data.id;
        ProductModel productFetched=await ProductModel.FromJson(json);
        product=productFetched;

        notifyListeners();



             });




}


}