import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/Controllers/LoginFormController.dart';
import 'package:shopmix/Controllers/SignUpFormController.dart';
import 'package:shopmix/darkmode/signup_dark_provider.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';
import 'package:shopmix/views/Login_page.dart';
import 'package:shopmix/views/Sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.instance.registerSingleton<ColorsDesignkazem>(ColorsDesignkazem());
  GetIt.instance.registerSingleton<SignupDarkprovider>(SignupDarkprovider());
  GetIt.instance.registerSingleton<LoginFormController>(LoginFormController());

  GetIt.instance
      .registerSingleton<SignUpFormController>(SignUpFormController());

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDa9uKGO3LxqChzBbhadlZ99xmhVNgRL18",
            appId: "1:541551018302:android:2530798e75f1cf8b4b2c6f",
            messagingSenderId: "541551018302",
            projectId: "shopmix-8019f"));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "shopmix",
      home: Signup(),
    );
  }
}
