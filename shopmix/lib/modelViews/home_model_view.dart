

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  
    int ii=-1;

  IChatRepository chatRepository=ChatApi();

  HomeModelView(){
    
  }







  



 

  bool moreTapView=false;

  

  int currentPageIndex=0;

  int cartItems=0;
  String message="";
  

  
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


    
    User? user=await FirebaseAuth.instance.currentUser;

    
    
    
    FirebaseFirestore.instance.collection("chats"). where("email",isEqualTo: user!.email).snapshots().listen((snapshots) {
      List<ChatModel> chatts=[];

      var data=snapshots.docs;
      //print("firestoreLength:"+data.length.toString());


      for(var item in data){
        

        ChatModel ch=ChatModel(id: item.id, email: user!.email!, type: item['type'], message: item['message'], date: item['date'].toDate());
        //print(ch.date.toString()+""+ch.id+""+ch.email+""+ch.message+""+ch.type);
      
        chatts.add(ch);
      }
      chatts.sort((a,b)=>a.date.compareTo(b.date));
      chats=List.from(chatts);
      //print("length "+chats!.length.toString());
      notifyListeners();
      if(ii<=0){

      }
      else {
 addChat();

      }
       ii++;
     

     });

    



   
  }

  void addChat(){



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

  void clearMEssage(){
    message="";
    notifyListeners();
  }

  void changeValue(String value){

    message=value;
    notifyListeners();

  }




  

}