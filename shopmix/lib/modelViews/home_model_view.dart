

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/controllers/ChatController/scrlController.dart';
import 'package:shopmix/models/chat_model.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/chatRepository/IChatRepository.dart';
import 'package:shopmix/repositories/chatRepository/chatApi.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';
import 'package:shopmix/views/categories_view.dart';
import 'package:shopmix/views/favourites_view.dart';
import 'package:shopmix/views/home_body_view.dart';
import 'package:shopmix/views/profile_view.dart';
import 'package:shopmix/views/shop_view.dart';
import 'package:shopmix/views/cart_view.dart';

class HomeModelView extends ChangeNotifier {

  


  IChatRepository chatRepository=ChatApi();

  HomeModelView(){
    getChats();
  }







  



 

  bool moreTapView=false;

  

  int currentPageIndex=0;

  int cartItems=0;
  

  
  List<Widget> pages=[HomeBodyView(),CartView(), FavouritesView(),CategoriesView(), ProfileView()];
  Widget currentPage=HomeBodyView();

  List<ChatModel>? chats;
 

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
  void cleartCartIcon(){
    cartItems=0;
    notifyListeners();
  }

  Future<void> getChats() async{

    chats=await chatRepository.getChats();

    notifyListeners();
  }

  void addChat(String mes){

    chats!.add(new ChatModel(id: "213312312", user: GetIt.instance.get<Seeding>().userMod, type: "sender", message: mes, date: DateTime.now()));
    chats=List.from(chats!);
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) { 


                      GetIt.instance.get<scrlController>().scrollController.animateTo(
                GetIt.instance.get<scrlController>().scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
    });


  }

  void changeCartItems(int index){

    cartItems=index;
    notifyListeners();


  }




  

}