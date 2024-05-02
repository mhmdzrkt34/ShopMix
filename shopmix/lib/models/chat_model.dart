import 'package:shopmix/models/user_model.dart';

class ChatModel {



late String id;

late UserModel user;

late String message;

late String type;
late DateTime date;


ChatModel({required this.id,required this.user,required this.type,required this.message,required this.date});


}