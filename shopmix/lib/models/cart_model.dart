import 'package:firebase_auth/firebase_auth.dart';

class CartModel {


  late String id;
  late String email;

  late double total;


  CartModel({required this.id,required this.email,required this.total});


  static Future<CartModel> fromJson(Map<String,dynamic> json) async {
    
    return  CartModel(id: json['id'], email: json['email'], total: json['total'].toDouble());






  }
}