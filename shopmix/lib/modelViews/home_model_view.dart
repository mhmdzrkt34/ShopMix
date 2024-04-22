

import 'package:flutter/material.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';
import 'package:shopmix/views/categories_view.dart';
import 'package:shopmix/views/favourites_view.dart';
import 'package:shopmix/views/home_body_view.dart';
import 'package:shopmix/views/profile_view.dart';
import 'package:shopmix/views/shop_view.dart';
import 'package:shopmix/views/cart_view.dart';

class HomeModelView extends ChangeNotifier {

  



 

  bool moreTapView=false;

  

  int currentPageIndex=0;

  int cartItems=0;
  

  
  List<Widget> pages=[HomeBodyView(),CartView(), FavouritesView(),CategoriesView(), ProfileView()];
  Widget currentPage=HomeBodyView();
  HomeModelView();

  void changeCurrentPage(int index){

    currentPageIndex=index;
    currentPage=pages[currentPageIndex];
    notifyListeners();
  }
  void addToCart(){
    cartItems=cartItems+1;
    notifyListeners();

  }

  void removeFromCart(){
     cartItems=cartItems-1;
      notifyListeners();

  }

  void changeMoreTapViewToOpposite(){
        moreTapView=!moreTapView;
    notifyListeners();

  }

  void removeCountFromCart(int count){
    cartItems=cartItems-count;
    notifyListeners();

  }

  void hideMoreTapView(){
    moreTapView=false;
    notifyListeners();

  }




  

}