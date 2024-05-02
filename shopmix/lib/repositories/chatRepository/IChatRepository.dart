import 'package:shopmix/models/chat_model.dart';

abstract class IChatRepository {



  Future<List<ChatModel>?> getChats();
}