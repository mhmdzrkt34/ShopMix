import 'dart:async';
import 'dart:convert';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/env.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:http/http.dart' as http;
import 'package:shopmix/modelViews/order_model_view.dart';

class CurrencyPayModelView extends ChangeNotifier {
  CurrencyPayModelView();

  double? ltcValue;
  final String blockCypherToken = "dc04bbd3de7f451585840d72433d73bf";
  bool isPaymentReceived = false;

  bool exit=false;

 int secondsremaining=60;
 String RemaininTime="1:00";



  /// Format minutes and seconds
  String  formattedTime(int secondsremaining ) {
    final minutes = (secondsremaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsremaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  /// Wait for LTC payment and start periodic checking
  void waitForLtcPayment(BuildContext context) async {
    double? ltcPrice;
    CoinGeckoApi api = CoinGeckoApi();
    final marketChart = await api.coins.getCoinMarketChart(
      id: 'litecoin',
      vsCurrency: 'usd',
      days: 1,
    );

    if (!marketChart.isError) {
      double ltcUsdPrice = marketChart.data.last.price!;
      ltcPrice = (GetIt.instance.get<CartModelView>().cart!.total + 5) / ltcUsdPrice;
      ltcValue = double.parse(ltcPrice.toStringAsFixed(2));

      startPeriodicPaymentCheck(GetIt.instance.get<env>().ltcWallet, ltcValue!, context);
    } else {
      Fluttertoast.showToast(
        msg: "Error fetching LTC market data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  /// Check if a specific Litecoin payment is received
  Future<void> checkLTCPayment(String walletAddress, double targetAmount, BuildContext context) async {
    final String url =
        "https://api.blockcypher.com/v1/ltc/main/addrs/$walletAddress/full?token=$blockCypherToken";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final transactions = data['txs'] as List<dynamic>;

        double totalReceived = 0.0;

        for (var tx in transactions) {
          final outputs = tx['outputs'] as List<dynamic>;
          for (var output in outputs) {
            final addresses = output['addresses'] as List<dynamic>;
            if (addresses.contains(walletAddress)) {
              final valueInSatoshis = output['value'] as int;
              final valueInLTC = valueInSatoshis / 100000000;
              totalReceived += valueInLTC;
            }
          }
        }

        isPaymentReceived = totalReceived >= targetAmount;
        if (isPaymentReceived) {
          Fluttertoast.showToast(
            msg: "Payment success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

        }

       
      } else {
        //print('Error fetching transaction data: ${response.statusCode}');
      }
    } catch (e) {
      //print('Error: $e');


    }
  }

  /// Start periodically checking for Litecoin payments
  void startPeriodicPaymentCheck(String walletAddress, double targetAmount, BuildContext context) async{

    for(int i=0;i<60;i++){

      if(exit==true){

                   isPaymentReceived=false;
            
               secondsremaining=60;
             RemaininTime="1:00";
             exit=false;
        return;
      }

      await Future.delayed(Duration(seconds: 1));

      checkLTCPayment(walletAddress, targetAmount, context);
      if(isPaymentReceived==true){
           isPaymentReceived=false;
            
               secondsremaining=60;
             RemaininTime="1:00";
        
        
          GetIt.instance.get<OrderModelView>().addOrder(context);
          
        return;
      }
      secondsremaining=secondsremaining-1;
      
      RemaininTime=formattedTime(secondsremaining);
      notifyListeners();
      if(i==59){
           isPaymentReceived=false;
            
               secondsremaining=60;
             RemaininTime="1:00";

             stopPeriodicPaymentCheck(context);


      }




    }

    }




    
  /// Stop periodically checking for payments
  void stopPeriodicPaymentCheck(BuildContext context) {

    Fluttertoast.showToast(
      msg: "Time expired",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    Navigator.pushReplacementNamed(context, "/home");
  }

  }
