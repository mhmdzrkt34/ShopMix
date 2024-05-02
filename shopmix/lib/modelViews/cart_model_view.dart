import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/models/cart_items_model.dart';
import 'package:shopmix/models/cart_model.dart';
import 'package:shopmix/models/cart_product_model.dart';
import 'package:shopmix/models/product_model.dart';


class CartModelView extends ChangeNotifier {



  List<CartItemsModel> cartItems=[];

  CartModel? cart;

  CartModelView();




  void addProductTocart(ProductModel product){

    if(cartItems.where((item) => item.product_id==product.id).isEmpty){

      cartItems.add(new CartItemsModel(id: "1", cart_id: "12", product_id: product.id, cart: cart!, product: product, quantity: 1));
      cart!.total=cart!.total+(product.price-(product.price*(product.salePercentage/100)));


    }

    else {


      cartItems.firstWhere((element) => element.product_id==product.id).quantity=cartItems.firstWhere((element) => element.product_id==product.id).quantity+1;

      cart!.total=cart!.total+(product.price-(product.price*(product.salePercentage/100)));
    }

    cartItems=List.from(cartItems);
    notifyListeners();


    
  }

  void removeProductFromCart(ProductModel product,int quantity){

    cartItems.removeWhere((element) => element.product_id==product.id);

    cartItems=List.from(cartItems);
    cart!.total=cart!.total-(product.price-((product.price*(product.salePercentage/100))))*quantity;
    notifyListeners();
  }

  Future<void> addProductQuantity(ProductModel product) async{


    
    GetIt.instance.get<HomeModelView>().addToCart();



    cartItems.firstWhere((element) => element.product_id==product.id).quantity=cartItems.firstWhere((element) => element.product_id==product.id).quantity+1;
    cartItems=List.from(cartItems);
    cart!.total=cart!.total+(product.price-(product.price*(product.salePercentage/100)));
    notifyListeners();
    

  }

  void subProductquantity(ProductModel product){
    if(cartItems.firstWhere((element) => element.product_id==product.id).quantity==1){
      //do nothing

    }
    else{

      GetIt.instance.get<HomeModelView>().removeFromCart();

    cartItems.firstWhere((element) => element.product_id==product.id).quantity=cartItems.firstWhere((element) => element.product_id==product.id).quantity-1;
        cartItems=List.from(cartItems);
         cart!.total=cart!.total-(product.price-(product.price*(product.salePercentage/100)));
    notifyListeners();
    }

  }

  void clearCart(){
  cart!.total=0;
  cartItems=[];
  GetIt.instance.get<HomeModelView>().cleartCartIcon();
  notifyListeners();

  }

  Future<void> fetchCarts() async{
    int itemsCount=0;
    cartItems=[];
    cart=null;

    User? user=await FirebaseAuth.instance.currentUser;
   

    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("carts").where("email",isEqualTo: user!.email).limit(1).get(); 

      if (querySnapshot.docs.isNotEmpty) {
      var data=querySnapshot.docs.first;

      Map<String,dynamic> json=data.data() as Map<String,dynamic>;
      json["id"]=data.id;
     
      cart=await CartModel.fromJson(json);
      print(cart!.id);


      QuerySnapshot cartItemsSnapshot=await FirebaseFirestore.instance.collection("cartItems").where("cart_id",isEqualTo: cart!.id).get();
   
      for(var cartitem in cartItemsSnapshot.docs){
        

        var jsonCartItemData=cartitem.data() as Map<String,dynamic>;
        jsonCartItemData['id']=cartitem.id;
      
       

       CartItemsModel cartItemsModel=await CartItemsModel.FromJson(jsonCartItemData, cart!);


       itemsCount=itemsCount+cartItemsModel.quantity;
     

       cartItems.add(cartItemsModel);


      }
              final SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString("cart_id", cart!.id);
      
      GetIt.instance.get<HomeModelView>().changeCartItems(itemsCount);
      notifyListeners();
  } else {
    throw Exception('No user found with that email');
  }
    





  }
}