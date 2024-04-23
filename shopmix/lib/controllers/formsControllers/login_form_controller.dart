import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopmix/controllers/formsControllers/form_controller.dart';


class LoginZaraketFormController extends FormController {

  final GlobalKey<FormState> loginFormKey=GlobalKey<FormState>();
  late BuildContext _context;

  Map loginInputs={
    "email":"",
    "password":""
  };

  void changeEmail(String email){
    loginInputs["email"]=email;

  }
  void changePassword(String password){
    loginInputs["password"]=password;


  }

  void onpress(){
    if(loginFormKey.currentState!.validate()){
      loginFormKey.currentState!.save();

      clearLoginInputs();
    }


  }

  void clearLoginInputs(){
    loginInputs={
    "email":"",
    "password":""
  };
   
  }
      void putContextValue(BuildContext context){
    _context=context;
  }

  BuildContext getFormPageContext(){
    return this._context;
  }


  List<Function> validators=[(value){
                bool result=value!.contains(RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+'));
            return result? null:"invalid email";

  },(value){
                bool result=value!.contains(RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{10,}$'));
            return result? null:"weak password";

  }];







}