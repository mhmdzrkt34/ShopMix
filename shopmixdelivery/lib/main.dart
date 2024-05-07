import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmixdelivery/apis/firebase_api.dart';
import 'package:shopmixdelivery/pages/map_distance_page.dart';
import 'package:shopmixdelivery/pages/map_page_provider.dart';
import 'package:shopmixdelivery/pages/order_search_page.dart';
import 'package:shopmixdelivery/pages/order_search_page_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await determinePosition();

    if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDa9uKGO3LxqChzBbhadlZ99xmhVNgRL18",
            appId: "1:541551018302:android:2530798e75f1cf8b4b2c6f",
            messagingSenderId: "541551018302",
            projectId: "shopmix-8019f"));
            
  }

  GetIt.instance.registerSingleton<MapPageProvider>(MapPageProvider());

  GetIt.instance.registerSingleton<OrderSearchPageProvider>(OrderSearchPageProvider());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
      MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "ShopMixAdmin",

      initialRoute: "/",

      routes: {

        "/":(Context)=>OrderPage(),
        "mapDistancePage":(context)=>MapDistancePage()


      },
      
    );
  }

}

    Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, prompt user to enable it.
      //print('Location services are disabled.');
      return;
    }

    // Check for location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied.
        //print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied.
      //print(
          //'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // Retrieve the current position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Print the obtained position
    //print('Current Position: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }
  