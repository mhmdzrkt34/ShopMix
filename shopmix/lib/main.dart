import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';

import 'package:shopmix/controllers/ChatController/scrlController.dart';
import 'package:shopmix/controllers/formsControllers/login_form_controller.dart';
import 'package:shopmix/controllers/formsControllers/register_form_controller.dart';
import 'package:shopmix/controllers/homeBodyControllers/showing_component_controller.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/env.dart';
import 'package:shopmix/modelViews/add_credit_cart_model_view.dart';
import 'package:shopmix/modelViews/all_new_product_model_view.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/all_sales_model_view.dart';
import 'package:shopmix/modelViews/categories_model_view.dart';
import 'package:shopmix/modelViews/category_search_model_view.dart';
import 'package:shopmix/modelViews/credit_carts_model_view.dart';
import 'package:shopmix/modelViews/currency_pay_model_view.dart';
import 'package:shopmix/modelViews/favourites_model_view.dart';
import 'package:shopmix/modelViews/home_body_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/modelViews/locations_model_view.dart';
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
import 'package:shopmix/repositories/authRepository/authRepository.dart';
import 'package:shopmix/views/LocationSelectionScreen.dart';

import 'package:shopmix/views/add_credit_cart_view.dart';
import 'package:shopmix/views/all_new_products_view.dart';
import 'package:shopmix/views/all_product_view.dart';
import 'package:shopmix/views/all_sales_view.dart';
import 'package:shopmix/views/category_search_view.dart';
import 'package:shopmix/views/credit_carts_view.dart';
import 'package:shopmix/views/currency_pay_view.dart';
import 'package:shopmix/views/home_view.dart';
import 'package:shopmix/views/locations_view.dart';
import 'package:shopmix/views/login_view.dart';
import 'package:shopmix/views/map_view.dart';
import 'package:shopmix/views/order_method_view.dart';
import 'package:shopmix/views/order_view.dart';
import 'package:shopmix/views/pay_online_view.dart';
import 'package:shopmix/views/phone_otp_view.dart';
import 'package:shopmix/views/product_details_view.dart';
import 'package:shopmix/views/register_view.dart';
import 'package:shopmix/views/reset_Password_view.dart';
import 'package:shopmix/views/setting_view.dart';
import 'package:shopmix/Controllers/LoginFormController.dart';
import 'package:shopmix/Controllers/SignUpFormController.dart';
import 'package:shopmix/darkmode/signup_dark_provider.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';
import 'package:shopmix/views/Login_page.dart';
import 'package:shopmix/views/Sign_up_page.dart';
import 'package:workmanager/workmanager.dart';


void main() async {
WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDa9uKGO3LxqChzBbhadlZ99xmhVNgRL18",
            appId: "1:541551018302:android:2530798e75f1cf8b4b2c6f",
            messagingSenderId: "541551018302",
            projectId: "shopmix-8019f"));
  }

  FirebaseAuth auth=FirebaseAuth.instance;
    final String initialRoute = auth.currentUser != null && auth.currentUser!.emailVerified==true ? "/home" : "/";


  /*WidgetsFlutterBinding.ensureInitialized();

 GeocodingPlatform.instance!.locationFromAddress("lebanon").then((value){

  if(value.isNotEmpty){

    print(value);
  }
  });*/
   initializeNotifications();
    Workmanager().initialize(
    callbackDispatcher, // The top-level function, defined below
  );

    Workmanager().registerPeriodicTask(
    "1",
    "simpleTask",
    frequency: Duration(seconds: 350),
  );
  


  GetIt.instance.registerSingleton<env>(env());

  GetIt.instance.registerSingleton<Seeding>(Seeding());

  GetIt.instance.registerSingleton<AuthRepository>(AuthRepository());

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
  GetIt.instance.registerSingleton<CreditCartsModelView>(CreditCartsModelView());
  GetIt.instance.registerSingleton<AddCreditCartModelView>(AddCreditCartModelView());
  GetIt.instance.registerSingleton<LocationsModelView>(LocationsModelView());
  GetIt.instance.registerSingleton<CurrencyPayModelView>(CurrencyPayModelView());
  
  

  GetIt.instance
      .registerSingleton<SignUpFormController>(SignUpFormController());

      GetIt.instance.registerSingleton<scrlController>(scrlController());



      /*Stripe.publishableKey=GetIt.instance.get<env>().stripePublishableKey;
      await Stripe.instance.applySettings();*/


      
    if(auth.currentUser!=null && auth.currentUser!.emailVerified==true){
      GetIt.instance.get<CartModelView>().fetchCarts();
      GetIt.instance.get<FavouritesModelView>().fetchFavourites();
      GetIt.instance.get<OrderModelView>().fetchOrders();

       GetIt.instance.get<HomeModelView>().getChats();

       GetIt.instance.get<LocationsModelView>().fetchLocations();
      
    }



  runApp( MyApp(init: initialRoute,));
    // Schedule periodic task
  
}

class MyApp extends StatelessWidget {
  late String init;
   MyApp({Key? key,required this.init}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: "shopmix",
      initialRoute: init,
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
        "/categorySearchView":(context) => CategorySearchView(),
        "/MapView":(context)=>MapView(),
        "/CreditCartsView":(context)=>creditCartView(),
        "/addCreditCartView":(context)=>AddCreditCartView(),
        "/payOnlineView":(context)=>PayOnlineView(),
        "/locationsView":(context)=>LocationsView(),
        "/locationSelectionView":(context)=>LocationSelectionScreen(),
        "/currencypayview":(context)=>CurrencyPayView(),
        "/resetPasswordView":(context)=>ResetPasswordView(),
       
       
      },

    );
  }
}


void initializeNotifications() async {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(android: androidSettings);
  await flip.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Here, you can handle the notification tap
      print("Notification tapped");
    },
  );
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flip.initialize(initializationSettings);

    const AndroidNotificationDetails notificationDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: notificationDetails);
    await flip.show(
      0,
      'Long time no see!',
      'Tap to open the app',
      platformChannelSpecifics,
    );

    return Future.value(true);
  });
}

void showNotification() async {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id', 'your_channel_name', 
    importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flip.show(
    0, 'Long time no see!', 'Tap to open the app', platformChannelSpecifics);
}