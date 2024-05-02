import 'package:flutter/material.dart';
import 'package:shopmix/models/location_model.dart';

class LocationsModelView extends ChangeNotifier {


  List<LocationModel> locations=[];




  LocationsModelView();


  void addLocation(LocationModel location){
    print(location.langitude.toString()+" "+location.latitude.toString());

    if(locations.length==0){
      location.defaultLocation=true;
    }
    locations.add(location);
    locations=List.from(locations);
    print(locations.length);
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
      print('hey');
      locations.firstWhere((element) => element.id==locationId).defaultLocation=false;

    }
    else {
    locations.firstWhere((element) => element.defaultLocation==true).defaultLocation=false;
    locations.firstWhere((element) => element.id==locationId).defaultLocation=true;
 

    }

    locations=List.from(locations);
    notifyListeners();
  }
}