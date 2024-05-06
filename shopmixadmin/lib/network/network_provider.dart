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
          _showSnackbar(" The internet is now connected");
          notifyListeners();
          break;
        case InternetStatus.disconnected:
          _showSnackbar(" The internet is now disconnected");
          notifyListeners();
          break;
      }
    });
  }

  void _showSnackbar(String message) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 5),
      ),
    );
  }

  GlobalKey<ScaffoldMessengerState> get scaffoldKey => _scaffoldKey;
}
