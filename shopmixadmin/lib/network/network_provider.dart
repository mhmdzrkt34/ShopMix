import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late InternetConnection listener;

  NetworkProvider() {
    final listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      print(status.toString());
      switch (status) {
        case InternetStatus.connected:
          _scaffoldKey.currentState?.removeCurrentSnackBar();
          _scaffoldKey.currentState?.showSnackBar(
            SnackBar(
              duration: Duration(seconds: 5),
              content: const Row(
                children: [
                  Icon(
                    Icons.wifi,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "The internet is now Connected",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          );
          notifyListeners();
          break;
        case InternetStatus.disconnected:
          _scaffoldKey.currentState?.showSnackBar(
            SnackBar(
              duration: Duration(days: 1),
              content: const Row(
                children: [
                  Icon(
                    Icons.wifi_off_sharp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "The internet is now disconnected",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          );
          notifyListeners();
          break;
      }
    });
  }

  GlobalKey<ScaffoldMessengerState> get scaffoldKey => _scaffoldKey;
}
