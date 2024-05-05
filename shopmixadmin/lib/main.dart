import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/Controllers/ADDCategoryFormController.dart';
import 'package:shopmixadmin/Controllers/ADDProductFormController.dart';
import 'package:shopmixadmin/Controllers/UpdateProductFormController.dart';
import 'package:shopmixadmin/chatprovider/chating_user_provider.dart';
import 'package:shopmixadmin/image_provider/product_image_provider.dart';
import 'package:shopmixadmin/image_provider/product_update_image_provider.dart';
import 'package:shopmixadmin/model_views/category_model_view.dart';
import 'package:shopmixadmin/model_views/product_model_view.dart';
import 'package:shopmixadmin/model_views/user_model_view.dart';
import 'package:shopmixadmin/network/network_provider.dart';
import 'package:shopmixadmin/views/ALL_Products.dart';
import 'package:shopmixadmin/views/Add_Category.dart';
import 'package:shopmixadmin/views/Add_Product.dart';
import 'package:shopmixadmin/views/Dashboard.dart';
import 'package:shopmixadmin/views/Edit_Product.dart';
import 'package:shopmixadmin/views/Settings.dart';

import 'package:shopmixadmin/views/chat/Users_page.dart';
import 'package:shopmixadmin/views/chat/chat_page.dart';
import 'package:shopmixadmin/voiceprovider/SpeechRecognitionProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDa9uKGO3LxqChzBbhadlZ99xmhVNgRL18",
            appId: "1:541551018302:android:2530798e75f1cf8b4b2c6f",
            messagingSenderId: "541551018302",
            projectId: "shopmix-8019f",
            storageBucket: "gs://shopmix-8019f.appspot.com"));
  }

  GetIt.instance
      .registerSingleton<ADDProductFormController>(ADDProductFormController());
  GetIt.instance.registerSingleton<ADDCategoryFormController>(
      ADDCategoryFormController());
  GetIt.instance.registerSingleton<CategoryModelView>(CategoryModelView());

  GetIt.instance.registerSingleton<ProductModelView>(ProductModelView());
  GetIt.instance.registerSingleton<UserModelView>(UserModelView());
  GetIt.instance.registerSingleton<UpdateProductFormController>(
      UpdateProductFormController());
  GetIt.instance.registerSingleton<ProductupdateImageProvider>(
      ProductupdateImageProvider());

  GetIt.instance.registerSingleton<userchatprovider>(userchatprovider());

  GetIt.instance
      .registerSingleton<ProductImageProvider>(ProductImageProvider());

  await FirebaseMessaging.instance.requestPermission(provisional: true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => SpeechRecognitionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: context.read<NetworkProvider>().scaffoldKey,
      title: 'Shopmix',
      initialRoute: '/',
      routes: {
        "/": (context) => dashboard(),
        "/AddProduct": (context) => addProduct(),
        "/AllProducts": (context) => allProduct(),
        "/AddCategory": (context) => addCategory(),
        "/Setting": (context) => Setting(),
        "/users": (context) => userspage(),
        "/Chat": (context) => chatpage(),
    
      },
    );
  }
}
