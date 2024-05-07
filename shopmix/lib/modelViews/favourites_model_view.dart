import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';

class FavouritesModelView extends ChangeNotifier{


  List<ProductModel> favouriteProducts=[];


  FavouritesModelView();

  void addToFavourites(ProductModel product){

    var result=favouriteProducts.where((element) => element.id==product.id);

    if(result.length==0){

      favouriteProducts.add(product);


    }
    else {

    }



    

    favouriteProducts=List.from(favouriteProducts);
    notifyListeners();



  }

  void deleteFromFavourites(ProductModel product){

    favouriteProducts.removeWhere((element) => element.id==product.id);

    favouriteProducts=List.from(favouriteProducts);
    notifyListeners();
  }

  Future<void> fetchFavourites() async{

    User? user=await FirebaseAuth.instance.currentUser;

    QuerySnapshot resultQuery=await FirebaseFirestore.instance.collection("favourites").where("user_email",isEqualTo: user!.email).get();

    if(resultQuery.docs.isEmpty){


    }
    else {

      for(var item in resultQuery.docs){


        Map<String,dynamic> productJson=(await FirebaseFirestore.instance.collection("products").doc((item.data() as Map<String,dynamic>)['product_id']).get()).data() as Map<String,dynamic>;
        
        productJson['id']=(item.data() as Map<String,dynamic>)['product_id'];
        ProductModel product=await ProductModel.FromJson(productJson);
        //print(product.title+" "+product.images.length.toString());
        

        favouriteProducts.add(product);


      }
      favouriteProducts=List.from(favouriteProducts);
      //print("length:"+favouriteProducts.length.toString());
      //print("images"+favouriteProducts[0].images.length.toString());

   
      notifyListeners();
    }


    
  }

  void clearFavourite(){
    favouriteProducts=[];
    
  }
}