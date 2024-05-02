import 'package:flutter/material.dart';
import 'package:shopmix/controllers/formsControllers/form_controller.dart';
import 'package:shopmix/repositories/authRepository/IAuthRepository.dart';
import 'package:shopmix/repositories/authRepository/authRepository.dart';


class RegisterFormController extends FormController {

  
  IAuthRepository authRepository=AuthRepository();

  final GlobalKey<FormState> registerFormKey=GlobalKey<FormState>();
    late BuildContext _context;

  Map registerInputs={
    "email":"",
    "password":"",
    "name":""
  };

  void changeEmail(String email){
    registerInputs["email"]=email;

  }
  void changePassword(String password){
    registerInputs["password"]=password;


  }
  void changeName(String name){
    registerInputs["name"]=name;


  }

  void onpress(){
    if(registerFormKey.currentState!.validate()){
      registerFormKey.currentState!.save();

      clearRegisterInputs();
    }


  }

  void clearRegisterInputs(){
    registerInputs={
    "email":"",
    "password":"",
    "name":""
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

  },
  (value){
                bool result=value!.length<4?false:true;
            return result? null:"the name field must be at least 4 characters";
  }
  ];





}