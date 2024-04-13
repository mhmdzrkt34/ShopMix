
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/controllers/formsControllers/login_form_controller.dart';
import 'package:shopmix/controllers/formsControllers/register_form_controller.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/login_model_view.dart';
import 'package:shopmix/modelViews/register_model_view.dart';
import 'package:shopmix/views/login_view.dart';
import 'package:shopmix/views/register_view.dart';

void main() async{

  GetIt.instance.registerSingleton<ColorsDesign>(ColorsDesign());
  GetIt.instance.registerSingleton<LoginFormController>(LoginFormController());
  GetIt.instance.registerSingleton<RegisterFormController>(RegisterFormController());
  GetIt.instance.registerSingleton<RegisterModeView>(RegisterModeView());
  GetIt.instance.registerSingleton<LoginModelView>(LoginModelView());

  
   WidgetsFlutterBinding.ensureInitialized();
   if(Platform.isAndroid){ await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDa9uKGO3LxqChzBbhadlZ99xmhVNgRL18",
      appId: "1:541551018302:android:2530798e75f1cf8b4b2c6f",
      messagingSenderId: "541551018302",
      projectId: "shopmix-8019f")

   );
 
   }

   
  
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "shopmix",
      initialRoute: "/",
      routes: {
        "/login":(context)=>LoginView(),
        "/":(context)=>RegisterView()
      },

    );


  }
}