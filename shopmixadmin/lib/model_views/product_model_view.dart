import 'package:flutter/material.dart';

import 'package:shopmixadmin/PostRepository/product/IProductRepository.dart';
import 'package:shopmixadmin/PostRepository/product/ProductApi.dart';
import 'package:shopmixadmin/models/product.dart';

class ProductModelView extends ChangeNotifier {
  List<ProductModel>? products;

  IProductRepository _productRepository = productApi();

  ProductModelView() {
    getProducts();
  }

  Future<void> getProducts() async {
    products = await _productRepository.getProducts();
    print("products " + products!.toString());
    notifyListeners();
  }
}
