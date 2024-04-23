import 'package:flutter/foundation.dart';
import 'package:shopmix/models/product_image_model.dart';

class ProductModel {

  late String id;
 
  late bool isNew;
  late double salePercentage;
  late String title;
  late double price;
  late List<ProductImageModel> images;

  late String description;
  
  late String category_id;


  ProductModel({required this.id,required this.isNew,required this.salePercentage,required this.title,required this.price,required this.images,required this.description,required this.category_id});
}