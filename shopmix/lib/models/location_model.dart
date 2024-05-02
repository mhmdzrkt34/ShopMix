import 'package:shopmix/models/user_model.dart';
import 'package:uuid/uuid.dart';

class LocationModel {


  late String id;
  late String user_id;
  late UserModel user;
  late double langitude;

  late double latitude;
  bool defaultLocation=false;

  LocationModel({required this.user,required this.langitude,required this.latitude,required this.user_id}){
    id=Uuid().v4();
  }
}