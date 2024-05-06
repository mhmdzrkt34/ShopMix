import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:shopmixadmin/models/product.dart';

class ProductModelView extends ChangeNotifier {
  List<ProductModel>? products;
  List<ProductModel>? originalProducts;

  ProductModelView() {
    getProducts();
  }

  void getProducts() {
    Stream<QuerySnapshot> productImagesStream =
        FirebaseFirestore.instance.collection('productImages').snapshots();
    Stream<QuerySnapshot> productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    StreamGroup<QuerySnapshot> streamGroup = StreamGroup<QuerySnapshot>();
    streamGroup.add(productImagesStream);
    streamGroup.add(productsStream);

    streamGroup.stream.listen((QuerySnapshot snapshot) async {
      var documents =
          (await FirebaseFirestore.instance.collection("products").get()).docs;
      List<Future<ProductModel>> futures =
          documents.map((DocumentSnapshot doc) async {
        return await ProductModel.FromJson(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      Future.wait(futures).then((List<ProductModel> productList) {
        products = productList;
        originalProducts = List.from(products!);
        notifyListeners();
      }).catchError((error) {
        print("Error fetching products: $error");
      });
    });
  }

  Future<void> searchProducts(String search) async {
    if (search.isEmpty) {
      products = List.from(originalProducts!);
    } else {
      products = originalProducts!
          .where((product) =>
              product.title.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void deleteDocument(ProductModel prd) async {
    if (prd.quantiy == 0) {
      Fluttertoast.showToast(
        msg: "Product is already out of stock!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(prd.id)
          .update({"quantity": 0});

      prd.quantiy = 0;

      Fluttertoast.showToast(
        msg: "Product successfully updated!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      return;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error updating product quantity: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
