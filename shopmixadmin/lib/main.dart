import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/Controllers/ADDCategoryFormController.dart';
import 'package:shopmixadmin/Controllers/ADDProductFormController.dart';
import 'package:shopmixadmin/Controllers/UpdateProductFormController.dart';
import 'package:shopmixadmin/chartsprovider/category_chart_provider.dart';
import 'package:shopmixadmin/chartsprovider/charts_orders_provider.dart';
import 'package:shopmixadmin/chatprovider/chating_user_provider.dart';
import 'package:shopmixadmin/image_provider/product_image_provider.dart';
import 'package:shopmixadmin/image_provider/product_update_image_provider.dart';
import 'package:shopmixadmin/model_views/category_model_view.dart';
import 'package:shopmixadmin/model_views/product_model_view.dart';
import 'package:shopmixadmin/model_views/user_model_view.dart';
import 'package:shopmixadmin/network/network_provider.dart';
import 'package:shopmixadmin/notifications/notifications.dart';
import 'package:shopmixadmin/views/ALL_Products.dart';
import 'package:shopmixadmin/views/Add_Category.dart';
import 'package:shopmixadmin/views/Add_Product.dart';
import 'package:shopmixadmin/views/Auth.dart';
import 'package:shopmixadmin/views/Dashboard.dart';
import 'package:shopmixadmin/views/Orders.dart';

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

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('Permission granted: ${settings.authorizationStatus}');
  String? token = await messaging.getToken();
  String adminEmail = 'admin@gmail.com';
  if (token != null) {
    updateUserToken(adminEmail, token);
  } else {
    print('Token does not exist.');
  }

  print('Registration Token=$token');

  GetIt.instance
      .registerSingleton<ADDProductFormController>(ADDProductFormController());
  GetIt.instance.registerSingleton<ADDCategoryFormController>(
      ADDCategoryFormController());
  GetIt.instance.registerSingleton<CategoryModelView>(CategoryModelView());
  GetIt.instance.registerSingleton<CategoriesWithCountprovider>(
      CategoriesWithCountprovider());

  GetIt.instance.registerSingleton<ProductModelView>(ProductModelView());
  GetIt.instance.registerSingleton<notification>(notification());
  GetIt.instance.registerSingleton<Ordersmodelview>(Ordersmodelview());
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

Future<void> updateUserToken(String email, String token) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore
      .collection("devicesloc")
      .where("user_email", isEqualTo: email)
      .where("token", isEqualTo: token)
      .get();

  if (querySnapshot.docs.isEmpty) {
    await firestore.collection("devicesloc").add({
      "user_email": email,
      "token": token,
    });
  }
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
        "/auth": (context) => const AuthScreen(),
        "/AddProduct": (context) => addProduct(),
        "/AllProducts": (context) => allProduct(),
        "/AddCategory": (context) => addCategory(),
        "/Orders": (context) => ordersview(),
        "/users": (context) => userspage(),
        "/Chat": (context) => chatpage(),
      },
    );
  }
}
