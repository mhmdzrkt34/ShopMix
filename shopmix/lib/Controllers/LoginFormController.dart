import 'package:flutter/material.dart';

class LoginFormController {
  LoginFormController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  String email = "";

  String password = "";

  void clearData() {
    email = "";

    password = "";
  }

  void changeEmail(String? email) {
    this.email = email!;
  }

  void changePassword(String? password) {
    this.password = password!;
  }

  void onTap(BuildContext context) {
    print("validaing ...");
    if (key.currentState!.validate()) {}
  }
}
