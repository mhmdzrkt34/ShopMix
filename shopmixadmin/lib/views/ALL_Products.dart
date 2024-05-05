import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shopmixadmin/components/App_Bar_search.dart';

import 'package:shopmixadmin/components/Side_Bar.dart';

import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/model_views/product_model_view.dart';
import 'package:shopmixadmin/models/product.dart';
import 'package:shopmixadmin/views/Edit_Product.dart';

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
        appBar: AdminAppBarSearch(_deviceHight, _deviceWidth, "ALL Products"),
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
    double discountedPrice =
        product.price - (product.price * (product.salePercentage / 100));
    bool onSale = product.salePercentage > 0;

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
                  onPressed: () {
                    GetIt.instance<ProductModelView>().deleteDocument(product);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      _context,
                      MaterialPageRoute(
                        builder: (context) => EditProduct(product),
                      ),
                    );
                  },
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
                        Image.network(
                          product.images[index].ImageUrl,
                          width: 200,
                          height: 160,
                          fit: BoxFit.fill,
                          color: Colors.red,
                          colorBlendMode: BlendMode.colorBurn,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              width: 160,
                              height: 120,
                              color: Colors.grey,
                              child: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            );
                          },
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
            onSale
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price: \$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        'Discounted Price: \$${discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
            SizedBox(height: 8),
            product.quantiy > 0
                ? Text(
                    'Quantity: ${product.quantiy}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  )
                : Text(
                    'Out of Stock',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
            Text(
              'ID: ${product.id}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Is New: ${product.isNew ? 'Yes' : 'No'}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Sale Percentage: ${product.salePercentage}%',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
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
