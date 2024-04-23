import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';

class HomeBodyModelView extends ChangeNotifier {
IProductRepository productRepository=ProductFirebase();

 List<ProductModel> someproducts=[];

 List<ProductModel> somenewProducts=[];

 List<ProductModel> somesalesProducts=[];

  HomeBodyModelView(){
    
  }



  Future<void> getSomeProducts(List<ProductModel> p) async{

    
    for(int i=p.length-1;i>p.length-1-5 && i>-1;i--){
      someproducts.add(p[i]);


      
    }
    someproducts=List.from(someproducts);
       notifyListeners();

  }

  Future<void> getSomeNewProducts(List<ProductModel> p) async {

    for(int i=p.length-1;i>p.length-1-5 && i>-1;i--){

      somenewProducts.add(p[i]);



    }

    somenewProducts=List.from(somenewProducts); 
       notifyListeners();//


  }

  Future<void> getSomeSalesProducts(List<ProductModel> p) async{

    
    for(int i=p.length-1;i>p.length-1-5 && i>-1;i--){
      somesalesProducts.add(p[i]);


      
    }
    somesalesProducts=List.from(somesalesProducts);
    notifyListeners();


  }


}