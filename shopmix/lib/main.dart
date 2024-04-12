
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
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
      home: Scaffold(backgroundColor: Colors.red,),

    );


  }
}