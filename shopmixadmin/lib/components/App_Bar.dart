import 'package:flutter/material.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  late double _height;
  late double _width;
  late String _title;

  AdminAppBar(this._height, this._width, this._title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: appbarricons(),
      centerTitle: true,
      title: Text(_title),
      
    );
  }

  List<Widget> appbarricons() {
    return [
      Container(
        margin: EdgeInsets.only(right: _width * 0.05),
        child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
      ),
    ];
  }

  @override
  Size get preferredSize => Size.fromHeight(_height * 0.06);
}
