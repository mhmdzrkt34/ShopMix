import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googleapis/servicemanagement/v1.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

import 'package:flutter/services.dart' show rootBundle;




class MapPageProvider extends ChangeNotifier {
  LatLng? startPosition;
  LatLng? endPosition;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  double distanceInMeters = 0.0;
  Timer? _locationUpdateTimer;
  Map<String, dynamic>? data;

  MapPageProvider();

  void _calculateDistanceAndPath() async {
    double distance = Geolocator.distanceBetween(
      startPosition!.latitude,
      startPosition!.longitude,
      endPosition!.latitude,
      endPosition!.longitude
    );

    distanceInMeters = distance;
    markers = {
      Marker(
        markerId: MarkerId('start'),
        position: startPosition!,
        infoWindow: InfoWindow(title: 'Start Position'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: MarkerId('end'),
        position: endPosition!,
        infoWindow: InfoWindow(title: 'End Position'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };

    notifyListeners();
    _getRouteBetweenCoordinates();
  }

  void _getRouteBetweenCoordinates() async {
    if (startPosition != null && endPosition != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      String googleApiKey = 'AIzaSyAhn4fApbM3vHegcDBzBN73BYLFtwBzZ4Q';

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(startPosition!.latitude, startPosition!.longitude),
        PointLatLng(endPosition!.latitude, endPosition!.longitude),
      );

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        polylines = {
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: polylineCoordinates,
          ),
        };
        notifyListeners();
      }
    }
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //print('Location services are disabled.');
      return;
    }

    // Check for location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //print('Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //print('Current Position: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }

  Future<void> determinePositionThread(Map<String, dynamic> orderData) async {
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      startPosition = LatLng(position.latitude, position.longitude);

      await FirebaseFirestore.instance.collection("orderlocations").add({
        "order_id": orderData["id"],
        "lattitude": position.latitude,
        "langitude": position.longitude,
        "timestamp": FieldValue.serverTimestamp()
      });

      _calculateDistanceAndPath();
    });
  }

  void start(Map<String, dynamic> orderData) {
    data=orderData;
    endPosition = LatLng(orderData["lattitude"], orderData["langitude"]);
    determinePositionThread(orderData);
  }

  void stopPositionThread() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;
   startPosition=null;
   endPosition=null;
  markers = {};
  polylines = {};
 polylineCoordinates = [];
 distanceInMeters = 0.0;

  data=null;
  }


Future<void> sendNotification({
  

  

  required String user_email
}) async {
  final jsonString = await rootBundle.loadString('assets/shopmix-8019f-f6a139b71f04.json');
  // Load the service account credentials
 final accountCredentials = ServiceAccountCredentials.fromJson(json.decode(jsonString));

  // Define the required scopes
  final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

  // Authenticate using the service account credentials
  final authClient = await clientViaServiceAccount(accountCredentials, scopes);

  // Construct the FCM HTTP v1 API endpoint
  final String fcmUrl = 'https://fcm.googleapis.com/v1/projects/shopmix-8019f/messages:send';

  var jsonNotloc=(await FirebaseFirestore.instance.collection("devicesloc").where("user_email",isEqualTo: user_email).get()).docs;


  for(var item in jsonNotloc){
    Map<String,dynamic> dt=item.data() as Map<String,dynamic>;


     final Map<String, dynamic> message = {
    'message': {
      'token': dt['token'],
      'notification': {
        'title': "order delivered",
        'body': "your order is delivered come and check",
      },
      'data': {'extra_info': 'you are welcome'},
    },
  };

  // Send the notification via HTTP request
  final http.Response response = await authClient.post(
    Uri.parse(fcmUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(message),
  );

  if (response.statusCode == 200) {
    //print('FCM notification sent successfully!');
    //print(response.body);
  } else {
    //print('Failed to send FCM notification');
    //print('Status Code: ${response.statusCode}');
    //print('Response Body: ${response.body}');
  }



  }
  

  // Construct the FCM notification request payload
 
}
}
