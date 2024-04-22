import 'package:flutter/material.dart';

import 'package:shopmixadmin/PostRepository/CategoryApi.dart';
import 'package:shopmixadmin/PostRepository/ICategoryRepository.dart';
import 'package:shopmixadmin/models/category.dart';

class CategoryModelView extends ChangeNotifier {
  List<category>? categories;

  ICategoryRepository _categoryRepository = categoryApi();

  CategoryModelView() {
    getPosts();
  }

  Future<void> getPosts() async {
    categories = await _categoryRepository.getCategories();
    notifyListeners();
  }
}
