import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shopmixadmin/components/App_Bar.dart';

import 'package:shopmixadmin/components/Side_Bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/model_views/product_model_view.dart';
import 'package:shopmixadmin/models/product.dart';

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
          value: GetIt.instance.get<ProductModelView>(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBar(_deviceHight, _deviceWidth, "ALL Products"),
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

  Selector<ProductModelView, List<ProductModel>?> _productsselctor() {
    return Selector<ProductModelView, List<ProductModel>?>(
      selector: (context, provider) => provider.products,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        print("product selector is rendered");
        return _products(value);
      },
    );
  }

  Widget _products(List<ProductModel>? value) {
    if (value == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
        top: _deviceHight * 0.015,
        left: _deviceWidth * 0.05,
        right: _deviceWidth * 0.05,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel product = value[index];
          return _buildProductItem(product);
        },
      ),
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              width: _deviceWidth,
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        CachedNetworkImage(
                          width: 200,
                          height: 160,
                          imageUrl: product.images[index].ImageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                  Colors.red,
                                  BlendMode.colorBurn,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Image.asset(
                            "assets/images/placeholder_image.png",
                            width: 160,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 160,
                            height: 120,
                            color: Colors.grey,
                            child: const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.share_outlined),
                          color: Colors.grey,
                          onPressed: () {
                            _onShareXFileFromAssets(_context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _onShareXFileFromAssets(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final data = await rootBundle.load('assets/images/logo.png');
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'flutter_logo.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }
}
