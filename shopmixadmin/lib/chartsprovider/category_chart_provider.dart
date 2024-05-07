import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopmixadmin/model_views/CategoryWithCount.dart';
import 'package:shopmixadmin/models/category.dart';

class CategoriesWithCountprovider extends ChangeNotifier {
  List<CategoryWithCount>? categoriesWithCount;

  CategoriesWithCountprovider() {
    getCategoriesWithCount();
  }

  Future<void> getCategoriesWithCount() async {
    FirebaseFirestore.instance
        .collection("categories")
        .snapshots()
        .listen((QuerySnapshot snapshot) async {
      List<CategoryWithCount> categories = [];
      for (DocumentSnapshot doc in snapshot.docs) {
        category cat =
            category.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        int count = await getProductCountForCategory(cat.id);
        categories.add(CategoryWithCount(Category: cat, count: count));
      }
      categoriesWithCount = categories;
      notifyListeners();
    });
  }

  Future<int> getProductCountForCategory(String? categoryId) async {
    QuerySnapshot productSnapshot = await FirebaseFirestore.instance
        .collection("products")
        .where("category_id", isEqualTo: categoryId)
        .get();

    return productSnapshot.size;
  }
}
