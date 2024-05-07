import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmix/apis/firebase_api.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/favourites_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/modelViews/locations_model_view.dart';
import 'package:shopmix/modelViews/order_model_view.dart';
import 'package:shopmix/repositories/authRepository/IAuthRepository.dart';
import 'package:shopmix/repositories/authRepository/authRepository.dart';

class LoginFormController {
   IAuthRepository authRepository=AuthRepository();
  LoginFormController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  String email = "";

  String password = "";

  void clearData() {
    email = "";

    password = "";
  }

  void changeEmail(String? emaill) {
   
    this.email = emaill!;
  }

  void changePassword(String? passwordd) {
    
    this.password = passwordd!;
  }

  void onTap(BuildContext context) async{
    print("validaing ...");

     print(this.email);
      print(this.password);

    if (key.currentState!.validate()) {
      key.currentState!.save();
    
       
  
      User? u=await authRepository.signInWithEmailPassword(this.email, this.password);
            
          
         if(u==null || u.emailVerified==false){
           Fluttertoast.showToast(
      msg: "Invalid Credentials or unverified email",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,  
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    
  );

         }else{

          final SharedPreferences prefs = await SharedPreferences.getInstance();

          String cartId=(await FirebaseFirestore.instance.collection("carts").where("email",isEqualTo: u!.email).limit(1).get()).docs.first.reference.id;


          prefs.setString("cart_id", cartId);

          await FirebaseApi().initNotification(u!.email!);


           Navigator.pushReplacementNamed(context, "/home");
           sleep(Duration(seconds: 2));
        Fluttertoast.showToast(
      msg: "Welcom to the app enjoy",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,  
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
  clearData();

  GetIt.instance.get<CartModelView>().fetchCarts();
   GetIt.instance.get<FavouritesModelView>().fetchFavourites();
   GetIt.instance.get<OrderModelView>().fetchOrders();
    GetIt.instance.get<HomeModelView>().getChats();

    GetIt.instance.get<LocationsModelView>().fetchLocations();
  
      
       
         }

    }
  }

void showCustomToast(BuildContext context, String message, bool isSuccess) {
  IconData icon = isSuccess ? Icons.check_circle_outline : Icons.error_outline;
  Color bgColor = isSuccess ? Colors.green : Colors.red;

  var overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.8, // Position towards the bottom of the screen
      left: MediaQuery.of(context).size.width * 0.1, // Horizontal padding
      width: MediaQuery.of(context).size.width * 0.8, // Take 80% of screen width
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 8,
                offset: Offset(0, 4), // Shadow direction: moving down 4px
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}




}
