import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {

  final _firebaseMessaging=FirebaseMessaging.instance;

  Future<void> initNotification(String userEmail) async {


    await _firebaseMessaging.requestPermission();

    final fcmtoken= await _firebaseMessaging.getToken();
    //print("token: "+fcmtoken.toString());
  }
}