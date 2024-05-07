import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopmixadmin/chartsprovider/charts_orders_provider.dart';
import 'package:shopmixadmin/components/App_Bar.dart';

import 'package:shopmixadmin/components/Side_Bar.dart';

import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:provider/provider.dart';

import 'package:shopmixadmin/models/order.dart';

class ordersview extends StatelessWidget {
  ordersview({super.key});
  late double _deviceHight;
  late double _deviceWidth;

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<Ordersmodelview>(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBar(_deviceHight, _deviceWidth, "Orders"),
        drawer: SideBar(context),
        body: SafeArea(
          child: _maincolumn(),
        ),
      ),
    );
  }

  Widget _maincolumn() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        _logofather(),
        _orderselctor(),
      ],
    );
  }

  Widget _logofather() {
    return Container(
      width: _deviceWidth,
      height: _deviceHight * 0.1,
      margin: EdgeInsets.only(top: _deviceHight * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          logo(_deviceHight * 0.05, _deviceWidth * 0.3, const Color(0xFF1A1A1A),
              20),
        ],
      ),
    );
  }

  Selector<Ordersmodelview, List<order>?> _orderselctor() {
    return Selector<Ordersmodelview, List<order>?>(
      selector: (context, provider) => provider.orders,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        return _orders(value);
      },
    );
  }

  Widget _orders(List<order>? value) {
    if (value == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
        top: _deviceHight * 0.015,
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) {
          order odr = value[index];
          return _bulidorders(odr);
        },
      ),
    );
  }

  Widget _bulidorders(order odr) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ID: ${odr.id}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: Colors.blueAccent,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share_outlined),
                    color: Colors.grey,
                    onPressed: () {
                      _onShareString(_context, 'Order ID: ${odr.id}');
                    },
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Text(
                'Date: ${odr.date.toDate()}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Quantity: ${odr.quantity}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Total Price: \$${odr.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'User Email: ${odr.userEmail}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    odr.delivered
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: odr.delivered ? Colors.green : Colors.red,
                  ),
                  Text(
                    odr.delivered ? 'Order Completed' : 'Order Not Completed',
                    style: TextStyle(
                      color: odr.delivered ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onShareString(BuildContext context, String content) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await Share.share(content);
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Error sharing: $e"),
        ),
      );
    }
  }
}
