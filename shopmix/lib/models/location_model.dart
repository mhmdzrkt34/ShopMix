import 'package:shopmix/models/user_model.dart';
import 'package:uuid/uuid.dart';

class LocationModel {


  late String id;
  late String email;
 
  late double langitude;

  late double latitude;
  late bool defaultLocation;

  LocationModel({required this.id,required this.langitude,required this.latitude,required this.email,required this.defaultLocation});

  static LocationModel FromJson(Map<String,dynamic> jsonData){


    return LocationModel(id: jsonData["id"],email: jsonData["email"],langitude:jsonData["langitude"].toDouble(),latitude: jsonData["latitude"].toDouble(),defaultLocation:jsonData["defaultLocation"] );


    
  }
}