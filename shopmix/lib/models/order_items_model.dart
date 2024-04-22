import 'package:shopmix/models/product_model.dart';

class OrderItems {
late String id;

late String product_id;

late ProductModel product;

late String order_id;
late int quantity;



late String name;


OrderItems({required this.id,required this.product_id,required this.quantity,required this.product,required this.name});

}