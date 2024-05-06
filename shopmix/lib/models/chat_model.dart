import 'package:shopmix/models/user_model.dart';

class ChatModel {



late String id;

late String email;

late String message;

late String type;
late DateTime date;


ChatModel({required this.id,required this.email,required this.type,required this.message,required this.date});


}