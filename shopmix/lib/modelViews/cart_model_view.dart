import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/models/cart_items_model.dart';
import 'package:shopmix/models/cart_model.dart';
import 'package:shopmix/models/cart_product_model.dart';
import 'package:shopmix/models/product_model.dart';


class CartModelView extends ChangeNotifier {



  List<CartItemsModel> cartItems=[];

  CartModel cart=CartModel(id: "12",total: 0,user_id: "1");

  CartModelView();




  void addProductTocart(ProductModel product){

    if(cartItems.where((item) => item.product_id==product.id).isEmpty){

      cartItems.add(new CartItemsModel(id: "1", cart_id: "12", product_id: product.id, cart: cart, product: product, quantity: 1));
      cart.total=cart.total+(product.price-(product.price*(product.salePercentage/100)));


    }

    else {


      cartItems.firstWhere((element) => element.product_id==product.id).quantity=cartItems.firstWhere((element) => element.product_id==product.id).quantity+1;

      cart.total=cart.total+(product.price-(product.price*(product.salePercentage/100)));
    }

    cartItems=List.from(cartItems);
    notifyListeners();


    
  }

  void removeProductFromCart(ProductModel product,int quantity){

    cartItems.removeWhere((element) => element.product_id==product.id);

    cartItems=List.from(cartItems);
    cart.total=cart.total-(product.price-((product.price*(product.salePercentage/100))))*quantity;
    notifyListeners();
  }

  void addProductQuantity(ProductModel product){
    GetIt.instance.get<HomeModelView>().addToCart();

    cartItems.firstWhere((element) => element.product_id==product.id).quantity=cartItems.firstWhere((element) => element.product_id==product.id).quantity+1;
    cartItems=List.from(cartItems);
    cart.total=cart.total+(product.price-(product.price*(product.salePercentage/100)));
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
         cart.total=cart.total-(product.price-(product.price*(product.salePercentage/100)));
    notifyListeners();
    }

  }
}