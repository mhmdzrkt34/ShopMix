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
}