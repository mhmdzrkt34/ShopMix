import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/models/category_model.dart';
import 'package:tuple/tuple.dart';

class CategoriesModelView extends ChangeNotifier {

  CategoriesModelView();

  List<CategoryModel> categories=GetIt.instance.get<Seeding>().categoris;





  void CategoryPress(String CategoryId){
    print(CategoryId);
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
}