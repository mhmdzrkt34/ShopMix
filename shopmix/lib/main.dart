import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/controllers/formsControllers/login_form_controller.dart';
import 'package:shopmix/controllers/formsControllers/register_form_controller.dart';
import 'package:shopmix/controllers/homeBodyControllers/showing_component_controller.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/all_new_product_model_view.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/all_sales_model_view.dart';
import 'package:shopmix/modelViews/categories_model_view.dart';
import 'package:shopmix/modelViews/category_search_model_view.dart';
import 'package:shopmix/modelViews/favourites_model_view.dart';
import 'package:shopmix/modelViews/home_body_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/modelViews/login_model_view.dart';
import 'package:shopmix/modelViews/order_method_model_view.dart';
import 'package:shopmix/modelViews/order_model_view.dart';
import 'package:shopmix/modelViews/product_details_model_view.dart';
import 'package:shopmix/modelViews/profile_model_view.dart';
import 'package:shopmix/modelViews/register_model_view.dart';
import 'package:shopmix/modelViews/setting_model_view.dart';
import 'package:shopmix/modelViews/shared_provider.dart';
import 'package:shopmix/modelViews/shop_model_view.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/models/order_model.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';
import 'package:shopmix/views/all_new_products_view.dart';
import 'package:shopmix/views/all_product_view.dart';
import 'package:shopmix/views/all_sales_view.dart';
import 'package:shopmix/views/category_search_view.dart';
import 'package:shopmix/views/home_view.dart';
import 'package:shopmix/views/login_view.dart';
import 'package:shopmix/views/order_method_view.dart';
import 'package:shopmix/views/order_view.dart';
import 'package:shopmix/views/product_details_view.dart';
import 'package:shopmix/views/register_view.dart';
import 'package:shopmix/views/setting_view.dart';
import 'package:shopmix/Controllers/LoginFormController.dart';
import 'package:shopmix/Controllers/SignUpFormController.dart';
import 'package:shopmix/darkmode/signup_dark_provider.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';
import 'package:shopmix/views/Login_page.dart';
import 'package:shopmix/views/Sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.instance.registerSingleton<Seeding>(Seeding());

  //seeding only in development
GetIt.instance.registerSingleton<LoginZaraketFormController>(LoginZaraketFormController());
  GetIt.instance.registerSingleton<ColorsDesign>(ColorsDesign());
  GetIt.instance.registerSingleton<LoginFormController>(LoginFormController());
  GetIt.instance.registerSingleton<RegisterFormController>(RegisterFormController());
  GetIt.instance.registerSingleton<RegisterModeView>(RegisterModeView());
  GetIt.instance.registerSingleton<LoginModelView>(LoginModelView());
  GetIt.instance.registerSingleton<HomeModelView>(HomeModelView());
  GetIt.instance.registerSingleton<darkModeProvider>(darkModeProvider());

  GetIt.instance.registerSingleton<HomeBodyModelView>(HomeBodyModelView());
  GetIt.instance.registerSingleton<ShopModelView>(ShopModelView());
  GetIt.instance.registerSingleton<CartModelView>(CartModelView());

  GetIt.instance.registerSingleton<FavouritesModelView>(FavouritesModelView());
  GetIt.instance.registerSingleton<ProfileModelView>(ProfileModelView());

  GetIt.instance.registerSingleton<SettingModelView>(SettingModelView());
  GetIt.instance.registerSingleton<CategoriesModelView>(CategoriesModelView());
  GetIt.instance.registerSingleton<OrderModelView>(OrderModelView());


  GetIt.instance.registerSingleton<ShowingComponentController>(ShowingComponentController());
  GetIt.instance.registerSingleton<AllProductModelView>(AllProductModelView());

  GetIt.instance.registerSingleton<AllSalesModelView>(AllSalesModelView());
  GetIt.instance.registerSingleton<AllNewProductModelView>(AllNewProductModelView());

  GetIt.instance.registerSingleton<sharedProvider>(sharedProvider());
  GetIt.instance.registerSingleton<ProductDetailsModelView>(ProductDetailsModelView());

  GetIt.instance.registerSingleton<OrderMethodModelView>(OrderMethodModelView());
  
  GetIt.instance.registerSingleton<CategorySearchModelView>(CategorySearchModelView());
  GetIt.instance.registerSingleton<ColorsDesignkazem>(ColorsDesignkazem());
  GetIt.instance.registerSingleton<SignupDarkprovider>(SignupDarkprovider());
  

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
      initialRoute: "/home",
      routes: {
        "/login":(context)=>Login(),
        "/":(context)=>Signup(),
        "/home":(context)=>HomeView(),
        "/setting":(context)=>SettingView(),
        "/orders":(context)=>OrderView(),
        "/AllProducts":(context)=>AllProductView(),
        "/AllSalesView":(context)=>AllSalesView(),
        "/AllNewView":(context)=>AllNewProductsView(),
        "/productDetail":(context)=>productDetailsView(),
        "/orderMethodView":(context)=>OrderMethodView(),
        "/categorySearchView":(context) => CategorySearchView()
      },

    );
  }
}
