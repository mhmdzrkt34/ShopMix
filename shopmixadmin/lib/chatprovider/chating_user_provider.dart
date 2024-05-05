import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopmixadmin/models/Message.dart';
import 'package:shopmixadmin/models/User.dart';

class userchatprovider extends ChangeNotifier {
  user? u;
  List<Message>? messages;

  void selectuser(user selectedu) {
    u = selectedu;
    messagesgeting();
    notifyListeners();
  }

  void messagesgeting() async {
    if (u == null) {
      return;
    } else {
      FirebaseFirestore.instance
          .collection("chats")
          .where("email", isEqualTo: u!.Email)
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> snapshot) async {
        List<Message> newMessages = await Future.wait(snapshot.docs
            .map((DocumentSnapshot<Map<String, dynamic>> doc) async {
          return Message.fromJson(doc.data(), doc.id);
        }));
        if (newMessages == null) {
          return;
        }
        newMessages.sort((a, b) => a.time.compareTo(b.time));

        messages = newMessages;
        notifyListeners();
      });
    }
  }

  void SendMessage(String message) {
    if(u!=null){

   
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("chats").add({
      "date": DateTime.now(),
      "email": u!.Email,
      "message": message,
      "type": "receiver",
    });
  } else{
       Fluttertoast.showToast(
        msg: "Error ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
  }
  
  }
}
