import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopmix/models/location_model.dart';

class LocationMapView extends StatefulWidget {
  final LocationModel location;

  const LocationMapView({Key? key, required this.location}) : super(key: key);

  @override
  _LocationMapViewState createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  GoogleMapController? mapController;
  late Marker initialMarker;
  final Set<Marker> markers = {}; // Define an empty set for markers

  @override
  void initState() {
    super.initState();
    initialMarker = Marker(
      markerId: MarkerId('initial'),
      position: LatLng(widget.location.latitude, widget.location.langitude),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _updateMapLocation();
  }

  void _updateMapLocation() {
    mapController?.animateCamera(CameraUpdate.newLatLng(initialMarker.position));
    setState(() {
      markers.add(initialMarker); // Add the marker to the set
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location on Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: initialMarker.position, // Use dynamic location from initialMarker
          zoom: 17.0,
        ),
        markers: markers, // Use the defined set of markers
      ),
    );
  }
}