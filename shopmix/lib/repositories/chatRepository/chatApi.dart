import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/models/chat_model.dart';
import 'package:shopmix/repositories/chatRepository/IChatRepository.dart';

class ChatApi extends IChatRepository {
  @override
  Future<List<ChatModel>?> getChats() async{


    try {

      return GetIt.instance.get<Seeding>().chats;

    }catch(e){
      return null;
    }

  }

  
}