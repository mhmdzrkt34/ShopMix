import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

import 'package:flutter/services.dart' show rootBundle;

class notification {
  Future<void> sendchat({required String user_email}) async {
    final jsonString =
        await rootBundle.loadString('assets/shopmix-8019f-f6a139b71f04.json');

    final accountCredentials =
        ServiceAccountCredentials.fromJson(json.decode(jsonString));

    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    final authClient =
        await clientViaServiceAccount(accountCredentials, scopes);

    final String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/shopmix-8019f/messages:send';

    var jsonNotloc = (await FirebaseFirestore.instance
            .collection("devicesloc")
            .where("user_email", isEqualTo: user_email)
            .get())
        .docs;

    for (var item in jsonNotloc) {
      Map<String, dynamic> dt = item.data() as Map<String, dynamic>;

      final Map<String, dynamic> message = {
        'message': {
          'token': dt['token'],
          'notification': {
            'title': "message recived",
            'body': "open to see recived message",
          },
          'data': {'extra_info': 'you are welcome'},
        },
      };

      final http.Response response = await authClient.post(
        Uri.parse(fcmUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('FCM notification sent successfully!');
        print(response.body);
      } else {
        print('Failed to send FCM notification');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    }
  }

  Future<void> sendaddproduct() async {
    final jsonString =
        await rootBundle.loadString('assets/shopmix-8019f-f6a139b71f04.json');

    final accountCredentials =
        ServiceAccountCredentials.fromJson(json.decode(jsonString));

    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    final authClient =
        await clientViaServiceAccount(accountCredentials, scopes);

    final String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/shopmix-8019f/messages:send';

    var jsonNotloc =
        (await FirebaseFirestore.instance.collection("devicesloc").get()).docs;

    for (var item in jsonNotloc) {
      Map<String, dynamic> dt = item.data() as Map<String, dynamic>;

      final Map<String, dynamic> message = {
        'message': {
          'token': dt['token'],
          'notification': {
            'title': "New Product is avilabel",
            'body': "open to see new product detials",
          },
          'data': {'extra_info': 'you are welcome'},
        },
      };

      // Send the notification via HTTP request
      final http.Response response = await authClient.post(
        Uri.parse(fcmUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('FCM notification sent successfully!');
        print(response.body);
      } else {
        print('Failed to send FCM notification');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    }
  }
}
