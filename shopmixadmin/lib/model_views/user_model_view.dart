import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopmixadmin/models/User.dart';

class UserModelView extends ChangeNotifier {
  List<user>? users;
  List<user>? originalusers;

  UserModelView() {
    getUsers();
  }

  Future<void> getUsers() async {
    FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<Future<user>> futures =
          snapshot.docs.map((DocumentSnapshot doc) async {
        return await user.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      Future.wait(futures).then((List<user> userslist) {
        users = userslist;
        originalusers = List.from(users!);
        notifyListeners();
      }).catchError((error) {
        print("Error fetching users: $error");
      });
    });
  }

  Future<void> searchusers(String search) async {
    if (search.isEmpty) {
      users = List.from(originalusers!);
    } else {
      users = originalusers!
          .where(
              (user) => user.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Map<String, int> getUserCountByCountry() {
    Map<String, int> userCountByCountry = {};
  
    if (users != null) {
      for (user currentUser in users!) {
        String? countryCode = currentUser.extractCountryCode();
        print("countryCode" + countryCode.toString());
        if (countryCode != null) {
          userCountByCountry[countryCode] =
              (userCountByCountry[countryCode] ?? 0) + 1;
        }
      }
    }

    return userCountByCountry;
  }
}
