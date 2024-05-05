import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/chatprovider/chating_user_provider.dart';

import 'package:shopmixadmin/models/User.dart';

class AdminAppBarUserchat extends StatelessWidget
    implements PreferredSizeWidget {
  final double _height;
  final double _width;
  late BuildContext _context;

  AdminAppBarUserchat(this._height, this._width);

  @override
  Widget build(BuildContext context) {
    _context = context;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<userchatprovider>(),
        ),
      ],
      child: AppBar(
        centerTitle: true,
        title: _usertsselctor(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height * 0.08);

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

  Selector<userchatprovider, user?> _usertsselctor() {
    return Selector<userchatprovider, user?>(
      selector: (context, provider) => provider.u,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        return _userinfo(value);
      },
    );
  }

  Widget _userinfo(user? selecteduser) {
    if (selecteduser != null) {
      Widget leadingWidget;

      if (selecteduser.ProfileURL != null &&
          selecteduser.ProfileURL!.isNotEmpty) {
        leadingWidget = CircleAvatar(
          backgroundImage: NetworkImage(selecteduser.ProfileURL!),
        );
      } else {
        leadingWidget = CircleAvatar(
          child: Icon(Icons.person),
        );
      }

      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: leadingWidget,
        title: Text(selecteduser.name,
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(selecteduser.Email ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selecteduser.Active ?? false ? Icons.check_circle : Icons.cancel,
              color: selecteduser.Active ?? false ? Colors.green : Colors.red,
            ),
            SizedBox(width: 5),
            Text(
              selecteduser.Active ?? false ? "Online" : "Offline",
              style: TextStyle(
                color: selecteduser.Active ?? false ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () {},
        onLongPress: () {
          _showUserInfoDialog(selecteduser);
        },
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("you must choose user  !",
            style: TextStyle(fontWeight: FontWeight.bold)),
      );
    }
  }
}
