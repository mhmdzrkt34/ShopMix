import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {


  late String Id;
  late String name;
  late List<CategoryModel> categories;
  bool visible;
  bool downward;
  
CategoryModel({required this.Id,required this.name,required this.categories,this.visible=false, this.downward=true});

void toggleVisibility(){
  visible = !visible;
}





    static Future<CategoryModel> fromJson(Map<String, dynamic> json, List<Map<String, dynamic>> allCategories) async {
    // Create a list of future subcategories
    var futureSubcategories = allCategories.where((cat) => cat['parent_id'] == json['id']).map((cat) async {
      return await fromJson(cat, allCategories);
    }).toList();

    // Wait for all the future subcategories to complete
    List<CategoryModel> subcategories = await Future.wait(futureSubcategories);

    return CategoryModel(
      Id: json['id'],
      name: json['name'],
      categories: subcategories,
    );
  }

}




