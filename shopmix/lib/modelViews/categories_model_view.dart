import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/models/category_model.dart';
import 'package:tuple/tuple.dart';

class CategoriesModelView extends ChangeNotifier {
  List<CategoryModel> categories=[];

  CategoriesModelView(){
    _listenToFirestore();
  }

  





  void CategoryPress(String CategoryId){
    //print(CategoryId);
    for(var category in categories){

      if(category.Id==CategoryId){

        if(category.downward==true){

        category.downward=false;
        for(var subcategory in category.categories){

          subcategory.visible=true;
        }
        }
        else {
                  category.downward=true;
        for(var subcategory in category.categories){

          subcategory.visible=false;
        }



        }

       

        }
     
     List<CategoryModel> subcategories = category.categories;


     while(!subcategories.isEmpty){

      for(int j=0;j<subcategories.length;j++){


        if(subcategories[j].Id==CategoryId){

          if(subcategories[j].downward==true){
                       subcategories[j].downward=false;
                  for(var subcategory in subcategories[j].categories){

          subcategory.visible=true;
        }

          }
          else {
                                   subcategories[j].downward=true;
                  for(var subcategory in subcategories[j].categories){

          subcategory.visible=false;
        }


          }


          

     }

     subcategories=subcategories[j].categories;

        

        

        


          
        

      
      }





    }


  }

  categories=List.from(categories);
  notifyListeners();


  






  





}

Future<void> _listenToFirestore() async {
  FirebaseFirestore.instance.collection("categories").snapshots().listen((snapshot) async {
     List<CategoryModel> categoriesFetched = [];

    // Convert snapshot to list of maps
    List<Map<String, dynamic>> allCategories = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      };
    }).toList();

    // Find top-level categories and build their full model including subcategories
    for (var json in allCategories.where((cat) => cat['parent_id'] == null || cat['parent_id'].isEmpty)) {
      CategoryModel category = await CategoryModel.fromJson(json, allCategories);
      category.toggleVisibility();
      categoriesFetched.add(category);
    }

    // Here, `categories` will have all the top-level categories along with their subcategories
    // You can now use `categories` for your UI or state management



    categories=List.from(categoriesFetched);
    
    notifyListeners();
    //print("Updated categories: ${categories.length}");
  }, onError: (error) {
    //print("Error listening to Firestore: $error");
  });
}
}