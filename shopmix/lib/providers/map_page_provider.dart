import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopmix/models/order_model.dart';

class MapPageProvider extends ChangeNotifier {


LatLng? startPosition;
LatLng? endPosition;
Set<Marker> markers = {};
  Set<Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];
     double distanceInMeters = 0.0;

     StreamSubscription<QuerySnapshot>? _orderLocationSubscription;
  MapPageProvider(){
    
   
    
  }








    void _calculateDistanceAndPath() async {
    double distance = Geolocator.distanceBetween(
      startPosition!.latitude,
      startPosition!.longitude,
      endPosition!.latitude,
      endPosition!.longitude,
    );

    
      distanceInMeters = distance;
      markers = {
        Marker(
          markerId: MarkerId('start'),
          position: startPosition!,
          infoWindow: InfoWindow(title: 'Start Position'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          rotation: 90.0, // Rotate if needed
        ),
        Marker(
          markerId: MarkerId('end'),
          position: endPosition!,
          infoWindow: InfoWindow(title: 'End Position'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          rotation: 270.0, // Rotate if needed
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


  Future<void> determinePositionThread(OrderModel order) async{

    _orderLocationSubscription= FirebaseFirestore.instance.collection("orderlocations").where("order_id",isEqualTo: order.id).snapshots().listen((event) {

      if(event.docs.length==0){


      }
      else {
        
              Map<String, dynamic> mostRecentDoc = event.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .reduce((a, b) {
        DateTime aTime = (a['timestamp'] as Timestamp).toDate();
        DateTime bTime = (b['timestamp'] as Timestamp).toDate();
        return aTime.isAfter(bTime) ? a : b;
      });

      

      

    
      endPosition=LatLng(mostRecentDoc['lattitude'], mostRecentDoc['langitude']);

      print(endPosition!.latitude.toString()+" "+endPosition!.latitude.toString());
      _calculateDistanceAndPath();

      }


      

    });






  }

  void start(OrderModel order){

    startPosition=LatLng(order.lattitude, order.langitude);

    determinePositionThread(order);





  }

    void stopListening() {
    _orderLocationSubscription?.cancel();
    _orderLocationSubscription = null;
    startPosition=null;
   endPosition=null;
  markers = {};
  polylines = {};
 polylineCoordinates = [];
 distanceInMeters = 0.0;
  
  }


  
}

