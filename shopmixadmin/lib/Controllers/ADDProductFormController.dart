import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmixadmin/image_provider/product_image_provider.dart';

class ADDProductFormController {
   GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

  String Title = "";
  String Description = "";
  double? Price;
  int? quantity;

  void clearData() {
    Title = "";
    Description = "";
    Price = 0;
    quantity = 0;
  }

  void changeTitle(String? _Title) {
    print(" title chnging: " + _Title!);
    Title = _Title;
  }

  void changeDescription(String? Description) {
    this.Description = Description!;
  }

  void changePrice(String? Price) {
    this.Price = double.parse(Price!);
  }

  void changequantity(String? quantity) {
    this.quantity = int.parse(quantity!);
  }

  void onTap(BuildContext context) {
    bool verfied = true;
    if (GetIt.instance<ProductImageProvider>().imagefileList!.isEmpty) {
      verfied = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Image Selected'),
            content: Text('At least one image is required.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    if (productFormKey.currentState!.validate()) {
      if (verfied) {
        productFormKey.currentState!.save();
        print("adding product");

        print("title: " +
            Title +
            Description +
            Price.toString() +
            quantity.toString());
      }
    }
  }
}
