import 'package:shopmix/models/order_items_model.dart';

class OrderModel {

  late String id;
  late String email;

  late int quantity;

  late double totalprice;
  bool itemVisible=false;


  List<OrderItems> items=[];
  DateTime date;
  late double lattitude;
  late double langitude;
  late bool delivered;

  OrderModel({required this.id,required this.email,required this.quantity,required this.totalprice,required this.date,required this.lattitude,required this.langitude,required this.delivered});



}