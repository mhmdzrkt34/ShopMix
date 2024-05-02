import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopmix/models/cart_model.dart';
import 'package:shopmix/models/product_model.dart';

class CartItemsModel {

  late String id;

  late String cart_id;
  late String product_id;

  late CartModel cart;
  late ProductModel product;

  late int quantity;

  CartItemsModel({required this.id,required this.cart_id,required this.product_id,required this.cart,required this.product,required this.quantity});




  static Future<CartItemsModel> FromJson(Map<String,dynamic> json,CartModel cartt) async{


    var productModelJson=(await FirebaseFirestore.instance.collection("products").doc(json["product_id"]).get()).data() as Map<String,dynamic> ;

    productModelJson['id']=json["product_id"];
    //print(productModelJson);
    ProductModel productt=await ProductModel.FromJson(productModelJson);
    //print(productt.title);




     return CartItemsModel(id: json['id'], cart_id: cartt.id, product_id: productt.id, cart: cartt, product: productt, quantity:json['quantity'] );

     

    



  }

  



}