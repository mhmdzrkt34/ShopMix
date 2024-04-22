import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmixadmin/Controllers/ADDCategoryFormController.dart';
import 'package:shopmixadmin/Controllers/ADDProductFormController.dart';
import 'package:shopmixadmin/image_provider/product_image_provider.dart';
import 'package:shopmixadmin/model_views/category_model_view.dart';
import 'package:shopmixadmin/views/ALL_Categories.dart';
import 'package:shopmixadmin/views/ALL_Products.dart';
import 'package:shopmixadmin/views/Add_Category.dart';
import 'package:shopmixadmin/views/Add_Product.dart';
import 'package:shopmixadmin/views/Dashboard.dart';
import 'package:shopmixadmin/views/Settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance
      .registerSingleton<ADDProductFormController>(ADDProductFormController());
  GetIt.instance.registerSingleton<ADDCategoryFormController>(
      ADDCategoryFormController());
  GetIt.instance.registerSingleton<CategoryModelView>(CategoryModelView());
  GetIt.instance
      .registerSingleton<ProductImageProvider>(ProductImageProvider());
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
      initialRoute: "/",
      routes: {
        "/": (context) => dashboard(),
        "/AddProduct": (context) => addProduct(),
        "/AllProducts": (context) => allProduct(),
        "/AllCategory": (context) => allCategories(),
        "/AddCategory": (context) => addCategory(),
        "/Setting": (context) => Setting(),
      },
    );
  }
}
