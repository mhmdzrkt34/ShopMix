import 'package:flutter/material.dart';

class AdminAppBarchart extends StatelessWidget implements PreferredSizeWidget {
  late double _height;
  late double _width;
  late String _title;

  AdminAppBarchart(this._height, this._width, this._title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: appbarricons(),
      centerTitle: true,
      title: Text(_title),
      bottom: const TabBar(tabs: [
        Tab(
          icon: Icon(Icons.area_chart_outlined),
        ),
        Tab(
          icon: Icon(Icons.pie_chart),
        ),
        Tab(
          icon: Icon(Icons.bar_chart_sharp),
        ),
      ]),
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
  Size get preferredSize => Size.fromHeight(_height * 0.1);
}
