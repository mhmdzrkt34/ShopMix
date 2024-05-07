import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shopmix/models/location_model.dart';

class LocationsModelView extends ChangeNotifier {


  List<LocationModel> locations=[];




  LocationsModelView();


  void addLocation(LocationModel location){
    //print(location.langitude.toString()+" "+location.latitude.toString());

    if(locations.length==0){
      location.defaultLocation=true;
    }
    locations.add(location);
    locations=List.from(locations);
    //print(locations.length);
    notifyListeners();

  }

  void removeLocation(String locationId){


    locations.removeWhere((element) => element.id==locationId);
    locations=List.from(locations);
    notifyListeners();
  }

  void changeDefault(String locationId){
    LocationModel locationTochange=locations.firstWhere((element) => element.id==locationId);
    //locations.firstWhere((element) => element.id==locationId).defaultLocation=!locations.firstWhere((element) => element.id==locationId).defaultLocation;

    if(locationTochange.defaultLocation==true){
      //print('hey');
      locations.firstWhere((element) => element.id==locationId).defaultLocation=false;

    }
    else {
      if(locations.where((element) => element.defaultLocation==true).toList().length==0){
        locations.firstWhere((element) => element.id==locationId).defaultLocation=true;

      }
      else {
    locations.firstWhere((element) => element.defaultLocation==true).defaultLocation=false;
    locations.firstWhere((element) => element.id==locationId).defaultLocation=true;
      }
 

    }

    locations=List.from(locations);
    notifyListeners();
  }



  Future<void> fetchLocations() async{
    
    List<LocationModel> locationsList=[];

    User? user=FirebaseAuth.instance.currentUser;

    var locationsFirebase=(await FirebaseFirestore.instance.collection("locations").where("email",isEqualTo: user!.email).get()).docs;


    for(var item in locationsFirebase){

      Map<String,dynamic> locationJson=item.data() as Map<String,dynamic>;


      locationJson["id"]=item.id;

      LocationModel locModel=LocationModel.FromJson(locationJson);

      locationsList.add(locModel);







    }

    locations=List.from(locationsList);
    notifyListeners();


  }

  void clearLocations(){
    locations=[];
  }


  LocationModel? getDefaultLocation(){

    List<LocationModel> locationss=locations.where((element) => element.defaultLocation==true).toList();

    if(locationss.isEmpty){
      return null;
    }
    return locationss[0];
   


  }
}