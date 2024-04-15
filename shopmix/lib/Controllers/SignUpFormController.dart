import 'package:flutter/material.dart';

class SignUpFormController {
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

  void onTap(BuildContext context) {
    print("validaing ...");
    if (key.currentState!.validate()) {}
  }
}
