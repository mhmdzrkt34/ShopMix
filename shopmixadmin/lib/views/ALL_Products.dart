import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:shopmixadmin/components/App_Bar.dart';

import 'package:shopmixadmin/components/Side_Bar.dart';

import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/image_provider/product_image_provider.dart';
import 'package:shopmixadmin/model_views/category_model_view.dart';

class allProduct extends StatelessWidget {
  allProduct({super.key});
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
          value: GetIt.instance.get<CategoryModelView>(),
        ),
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<ProductImageProvider>(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBar(_deviceHight, _deviceWidth, "ALL Products"),
        drawer:  SideBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _maincolumn(),
          ),
        ),
      ),
    );
  }

  Widget _maincolumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _logofather(),
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
}
