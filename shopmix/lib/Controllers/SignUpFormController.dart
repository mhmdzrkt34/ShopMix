import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopmix/repositories/authRepository/IAuthRepository.dart';
import 'package:shopmix/repositories/authRepository/authRepository.dart';

class SignUpFormController {
    IAuthRepository authRepository=AuthRepository();
  SignUpFormController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  String username = "";
  String email = "";
  String phone = "";
  String country = "";
  String password = "";
  String comfirmpassword = "";

  void clearData() {
    username = "";
    email = "";
    phone = "";
    password = "";
    comfirmpassword = "";
  }

  void changeEmail(String? email) {
    this.email = email!;
  }

  void changePassword(String? password) {
    this.password = password!;
  }

  void changephone(String? phone) {
    this.phone = phone!;
  }

  void changecountry(String? country) {
    this.country = country!;
  }

  void changecomfirmpassword(String? comfirmpassword) {
    this.comfirmpassword = comfirmpassword!;
  }

  void changeusername(String? username) {
    this.username = username!;
  }

  void onTap(BuildContext context) async{
    print("validaing ...");

    if (key.currentState!.validate()) {

      key.currentState!.save();

      
      User? user= await authRepository.registerWithEmailPassword(email, password,phone,username);

      if(user==null){

                 Fluttertoast.showToast(
      msg: "Email already exists",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,  
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    
  );

      }
      else {
        CollectionReference carts=FirebaseFirestore.instance.collection("carts");

        await carts.add({

          "email":user.email,
          "total":0,


        });

        await FirebaseAuth.instance.currentUser!.sendEmailVerification();



        await

                         Fluttertoast.showToast(
      msg: "Email registered succesfully, we have sended you a verification email you need to verify before you login",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,  
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
    
  );
  Navigator.pushReplacementNamed(context, "/login");


      }

      


   
  

 
    }
  }
}
