import 'package:shopmix/models/order_items_model.dart';

class OrderModel {

  late String id;
  late String user_id;

  late int quantity;

  late double totalprice;
  bool itemVisible=false;


  List<OrderItems> items=[];

  OrderModel({required this.id,required this.user_id,required this.quantity,required this.totalprice});



}