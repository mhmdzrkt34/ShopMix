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

  



}