import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ConnectivityStatus {
  WiFi,
  Cellular,
  Ethernet,
  VPN,
  Bluetooth,
  Other,
  None,
}

class NetworkProvider extends ChangeNotifier {
  ConnectivityStatus _status = ConnectivityStatus.None;

  ConnectivityStatus get status => _status;

  NetworkProvider() {
    getConnection();
  }

  Future<void> getConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      _status = ConnectivityStatus.Cellular;
      showToast('Connected via Cellular');
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      _status = ConnectivityStatus.WiFi;
      showToast('Connected via WiFi');
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      _status = ConnectivityStatus.Ethernet;
      showToast('Connected via Ethernet');
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      _status = ConnectivityStatus.VPN;
      showToast('Connected via VPN');
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      _status = ConnectivityStatus.Bluetooth;
      showToast('Connected via Bluetooth');
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      _status = ConnectivityStatus.Other;
      showToast('Connected via Other');
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      _status = ConnectivityStatus.None;
      showToast('No internet connection');
    }

    notifyListeners();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
