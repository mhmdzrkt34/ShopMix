import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopmixadmin/models/order.dart';

class Ordersmodelview extends ChangeNotifier {
  List<order>? orders;

  Ordersmodelview() {
    getOrders();
  }

  Future<void> getOrders() async {
    FirebaseFirestore.instance
        .collection("orders")
        .snapshots()
        .listen((QuerySnapshot snapshot) async {
      List<order> ordersfirebase = [];
      for (DocumentSnapshot doc in snapshot.docs) {
        order cat = order.fromJson(doc.data() as Map<String, dynamic>, doc.id);

        ordersfirebase.add(cat);
      }
      orders = ordersfirebase;
      print("orders " + orders!.length.toString());
      notifyListeners();
    });
  }
}
