import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmixadmin/chatprovider/chating_user_provider.dart';

import 'package:shopmixadmin/components/App_Bar_search_users.dart';

import 'package:shopmixadmin/components/Side_Bar.dart';

import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/model_views/user_model_view.dart';
import 'package:shopmixadmin/models/User.dart';

class userspage extends StatelessWidget {
  userspage({super.key});
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
          value: GetIt.instance.get<UserModelView>(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBarSearchusers(_deviceHight, _deviceWidth, "Users"),
        drawer: SideBar(context),
        body: _maincolumn(),
      ),
    );
  }

  Widget _maincolumn() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        _logofather(),
        _productsselctor(),
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

  Selector<UserModelView, List<user>?> _productsselctor() {
    return Selector<UserModelView, List<user>?>(
      selector: (context, provider) => provider.users,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        return _products(value);
      },
    );
  }

  Widget _products(List<user>? value) {
    if (value == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
        top: _deviceHight * 0.015,
        // left: _deviceWidth * 0.05,
        // right: _deviceWidth * 0.05,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) {
          user User = value[index];
          return _bulidusers(User);
        },
      ),
    );
  }

  Widget _bulidusers(user user) {
    Widget leadingWidget;

    if (user.ProfileURL != null && user.ProfileURL!.isNotEmpty) {
      leadingWidget = CircleAvatar(
        backgroundImage: NetworkImage(user.ProfileURL!),
      );
    } else {
      leadingWidget = CircleAvatar(
        child: Icon(Icons.person),
      );
    }

    return Card(
      shadowColor: Colors.blueGrey,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 5.5, vertical: 5),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: leadingWidget,
        title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(user.Email ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              user.Active ?? false ? Icons.check_circle : Icons.cancel,
              color: user.Active ?? false ? Colors.green : Colors.red,
            ),
            SizedBox(width: 5),
            Text(
              user.Active ?? false ? "Online" : "Offline",
              style: TextStyle(
                color: user.Active ?? false ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () {
          GetIt.instance<userchatprovider>().selectuser(user);
          Navigator.pushNamed(_context, "/Chat");
        },
        onLongPress: () {
          _showUserInfoDialog(user);
        },
      ),
    );
  }

  void _showUserInfoDialog(user user) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${user.name}'),
              Text('Email: ${user.Email ?? 'N/A'}'),
              Text('Active: ${user.Active ?? false}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
