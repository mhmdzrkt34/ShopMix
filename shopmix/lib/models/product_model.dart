import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/models/product_image_model.dart';

class ProductModel {

  late String id;
 
  late bool isNew;
  late double salePercentage;
  late String title;
  late double price;
  late List<ProductImageModel> images=[];

  late String description;
  
  late String category_id;
  late int quantiy;


  ProductModel({required this.id,required this.isNew,required this.salePercentage,required this.title,required this.price,required this.images,required this.description,required this.category_id,required this.quantiy});



 static Future<ProductModel> FromJson(Map<String,dynamic> json) async{


  





    String idd=json['id'];
    bool issNew;
    double salePercentagee=json["salePercent"].toDouble();
    Timestamp timestamp = json['created_time'];
    DateTime createdTime = timestamp.toDate();
      print("productIdd:"+idd);

    List<ProductImageModel> imagess=[];

        DateTime twoDaysAgo = DateTime.now().subtract(Duration(days: 2));
    if (createdTime!.isAfter(twoDaysAgo)) {
      issNew=true;
    } else {
      issNew=false;
    }

    
    String titlee=json['title'];
    double pricee=json['price'].toDouble();
    String descriptionn=json['description'];
    String category_idd=json['category_id'];
    int quantiyy=json['quantity'].toInt();

    Query  productImages=FirebaseFirestore.instance.collection("productImages").where("product_id",isEqualTo:idd );
      await productImages.get().then((QuerySnapshot querySnapshot) {
 
      for (var doc in querySnapshot.docs) {

        Map<String,dynamic> data=doc.data() as Map<String,dynamic>;
        imagess.add(ProductImageModel(Id: doc.id, product_id: data['product_id'], ImageUrl: data['ImageUrl']));
        
        }
       
        
  }).catchError((error) {
    print("Error fetching product images: $error");
  });

  return ProductModel(id: idd, isNew: issNew, salePercentage: salePercentagee, title: titlee, price: pricee, images: imagess, description: descriptionn, category_id: category_idd,quantiy: quantiyy);
    
  
 
  




    
    

  
     



  }
}