import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopmixdelivery/pages/map_page_provider.dart';
import 'package:tuple/tuple.dart';


class MapDistancePage extends StatefulWidget {
  @override
  _MapDistancePageState createState() => _MapDistancePageState();
}

class _MapDistancePageState extends State<MapDistancePage> {
  GoogleMapController? mapController;
  late double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GetIt.instance.get<MapPageProvider>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Distance Far From You'),
          leading: IconButton(

            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (){
              GetIt.instance.get<MapPageProvider>().stopPositionThread();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(child: MapSelector()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showConfirmationDialog(context),
          child: Icon(Icons.check),
          tooltip: 'Confirm Order',
        ),
      ),
    );
  }

  Selector<MapPageProvider, Tuple6> MapSelector() {
    return Selector<MapPageProvider, Tuple6>(
      selector: (context, provider) => Tuple6(
        provider.startPosition,
        provider.endPosition,
        provider.distanceInMeters,
        provider.polylines,
        provider.polylineCoordinates,
        provider.markers,
      ),
      shouldRebuild: (previous, next) =>
          !identical(previous.item1, next.item1) ||
          !identical(previous.item2, next.item2) ||
          !identical(previous.item3, next.item3) ||
          !identical(previous.item4, next.item4) ||
          !identical(previous.item5, next.item5) ||
          !identical(previous.item6, next.item6),
      builder: (context, value, child) {
        if (value.item1 == null || value.item2 == null || value.item3 == null || value.item4 == null || value.item5 == null || value.item6 == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Container(
              height: _deviceHeight * 0.75,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: value.item1,
                  zoom: 10,
                ),
                markers: value.item6,
                polylines: value.item4,
                onMapCreated: (controller) {
                  mapController = controller;
                },
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Distance: ${(value.item3 / 1000).toStringAsFixed(2)} km',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Order'),
          content: Text('Are you sure you want to confirm this order?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.pushNamed(context,"/");
                _confirmOrder();
              },
            ),
          ],
        );
      },
    );
  }

  // Perform your desired action
  void _confirmOrder() async{

    String id=GetIt.instance.get<MapPageProvider>().data!['id'];
    String email=GetIt.instance.get<MapPageProvider>().data!['user_email'];

    (await FirebaseFirestore.instance.collection("orders").doc(GetIt.instance.get<MapPageProvider>().data!['id'])).update({
      "delivered":true
    });
    GetIt.instance.get<MapPageProvider>().stopPositionThread();

    (await FirebaseFirestore.instance.collection("orderlocations").where("order_id",isEqualTo:id ).get()).docs.forEach((element) async{

       await element.reference.delete();


     });

     GetIt.instance.get<MapPageProvider>().sendNotification(user_email: email);
   

  }
}
