import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/categories_model_view.dart';
import 'package:shopmix/modelViews/shared_provider.dart';
import 'package:shopmix/models/category_model.dart';
import 'package:shopmix/models/product_model.dart';

class CategorySearchModelView extends ChangeNotifier {


  List<ProductModel> ProductsByCategory=[];


 List<ProductModel> filterProductsByCategory=[];



  CategorySearchModelView();




Future<void> getProuctsByCategory(String categoryId) async {
  List<CategoryModel> categories = GetIt.instance.get<CategoriesModelView>().categories;
  CategoryModel? findCategory = _findCategoryById(categories, categoryId);

  ProductsByCategory=List.from(findProducts(GetIt.instance.get<AllProductModelView>().products!,findCategory!)) ;

  filterProductsByCategory=ProductsByCategory;
  notifyListeners();






  


  
  

}


CategoryModel? _findCategoryById(List<CategoryModel> categories, String categoryId) {
  for (var category in categories) {
    if (category.Id == categoryId) {
      return category;
    }
    if (category.categories.isNotEmpty) {
      CategoryModel? subcategory = _findCategoryById(category.categories, categoryId);
      if (subcategory != null) {
        return subcategory;
      }
    }
  }
  return null;
}


List<ProductModel> findProducts(List<ProductModel> products, CategoryModel category) {
  List<ProductModel> foundProducts = [];

  for (var product in products) {
    if (product.category_id == category.Id) {
      foundProducts.add(product);
    }
  }

  for (var subcategory in category.categories) {
    foundProducts.addAll(findProducts(products, subcategory));
  }

  return foundProducts;
}
 void Filter(String value){

    if(filterProductsByCategory==null){


    }


    else {

    


    filterProductsByCategory=List.from(ProductsByCategory!.where((element) => element.title.toUpperCase().contains(value.toUpperCase())).toList());
    notifyListeners();}
  }
}