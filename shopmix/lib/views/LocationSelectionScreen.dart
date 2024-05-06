import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/modelViews/locations_model_view.dart';
import 'package:shopmix/models/location_model.dart';

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  Set<Marker> markers = {}; // Set to store markers
  final TextEditingController _searchController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _onSearch(String location) async {
    try {
      final results = await locationFromAddress(location);
      if (results.isNotEmpty) {
        final firstPlace = results.first;
        final coordinates = LatLng(firstPlace.latitude!, firstPlace.longitude!);
        setState(() {
          selectedLocation = coordinates;
          markers.clear(); // Clear existing markers
        });
        mapController?.animateCamera(CameraUpdate.newLatLng(coordinates));
      } else {
        // Show message to user: "No results found for your search."
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No results found for your search.'),
          ),
        );
      }
    } on NoResultFoundException {
      // ... (existing code for handling no results)
    } catch (e) {
      // ... (existing code for handling other exceptions)
    }
  }

  void _onMarkerTap(LatLng tappedPosition) {
    setState(() {
      selectedLocation = tappedPosition;
      markers.clear(); // Clear existing markers
      markers.add(Marker(
        markerId: MarkerId(tappedPosition.toString()),
        position: tappedPosition,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(
        children: [
          // Google Map with some top padding
          Padding(
            padding: const EdgeInsets.only(top: 64.0), // Adjust padding as needed
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: selectedLocation ?? LatLng(33.8872, 35.4954), // Default to Beirut
                zoom: 12.0,
              ),
              markers: markers,
              onTap: _onMarkerTap,
            ),
          ),
          // Search bar positioned above the keyboard
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 64.0, // Adjust height as needed
              color: Colors.white, // Set background color
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location...',
                ),
                onChanged: (text) => _onSearch(text), // Call search on each change
              ),
            ),
          ),
          // Optional button alignment (consider adjusting position)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () async{
                  if (selectedLocation != null) {
                     DocumentReference? docRef;
                    
                    // Handle selected location (navigation, saving, etc.)
                    // For example:
                    // - Navigate back with the selected location
                    User? user=FirebaseAuth.instance.currentUser;


                    CollectionReference<Map<String, dynamic>> locationCollection = FirebaseFirestore.instance.collection("locations");
                    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection("locations").where("email", isEqualTo: user!.email);
                    QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();

                    if(snapshot.docs.length==0){
                      
                      
                       docRef=await locationCollection.add({
                        "defaultLocation":true,
                        "email":user!.email,
                        "langitude":selectedLocation!.longitude,
                        "lattitude":selectedLocation!.latitude

                        

                      });
                    }
                    else {

                                             docRef=await locationCollection.add({
                        "defaultLocation":false,
                        "email":user!.email,
                        "langitude":selectedLocation!.longitude,
                        "lattitude":selectedLocation!.latitude

                        

                      });

                    }
                    Map<String,dynamic> jsonLocAdded=(await docRef.get()).data() as Map<String,dynamic>;

                    


                    LocationModel location=LocationModel(id: docRef.id, email: user!.email!, langitude: selectedLocation!.longitude, latitude: selectedLocation!.latitude,defaultLocation:jsonLocAdded["defaultLocation"]);
                    
                    GetIt.instance.get<LocationsModelView>().addLocation(location);
                    Navigator.pop(context);
                  }
                },
                child: Icon(Icons.check),
              ),
            ),
          ),
        ],
      ),)
    );
  }
}