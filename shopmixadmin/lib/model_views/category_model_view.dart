import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopmixadmin/models/category.dart';

class CategoryModelView extends ChangeNotifier {
  List<category>? categories;

  CategoryModelView() {
    getCategories();
  }

  Future<void> getCategories() async {
  FirebaseFirestore.instance
        .collection("categories")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      categories = snapshot.docs.map((DocumentSnapshot doc) {
        return category.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      notifyListeners();
    });
  }
}
