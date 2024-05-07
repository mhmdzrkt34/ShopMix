import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmixadmin/image_provider/product_image_provider.dart';
import 'package:shopmixadmin/notifications/notifications.dart';

class ADDProductFormController {
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

  String Title = "";
  String Description = "";
  double? Price;
  double? sale;
  int? quantity;
  String? category;

  void clearData() {
    Title = "";
    Description = "";
    Price = 0;
    quantity = 0;
    sale = 0;
  }

  void changeTitle(String? _Title) {
    print(" title chnging: " + _Title!);
    Title = _Title;
  }

  void changecategory(String? _category) {
    category = _category;
  }

  void changeDescription(String? Description) {
    this.Description = Description!;
  }

  void changePrice(String? Price) {
    this.Price = double.parse(Price!);
  }

  void changesale(String? salee) {
    this.sale = double.parse(salee!);
  }

  void changequantity(String? quantity) {
    this.quantity = int.parse(quantity!);
  }

  Future<void> onTap(BuildContext context) async {
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

        CollectionReference products =
            FirebaseFirestore.instance.collection("products");
        CollectionReference productimages =
            FirebaseFirestore.instance.collection("productImages");

        final docRef = await products.add({
          "category_id": category,
          "created_time": DateTime.now(),
          "description": Description,
          "price": Price,
          "quantity": quantity,
          "salePercent": sale,
          "title": Title,
        }).then((DocumentReference documentRef) {
          GetIt.instance<notification>().sendaddproduct();
          Fluttertoast.showToast(
              msg: "Product added successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }).catchError((error) {
          Fluttertoast.showToast(
              msg: "error while adding Product",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });

        String productId = "";

        FirebaseFirestore.instance
            .collection("products")
            .where("category_id", isEqualTo: category)
            .where("description", isEqualTo: Description)
            .where("price", isEqualTo: Price)
            .where("quantity", isEqualTo: quantity)
            .where("salePercent", isEqualTo: sale)
            .where("title", isEqualTo: Title)
            .limit(1)
            .snapshots()
            .listen((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            DocumentSnapshot doc = snapshot.docs.first;
            productId = doc.id;
            print(doc.data());
            print(doc.id);
            print(productId);
          }
        });
        clearData();
        List<XFile>? images =
            GetIt.instance<ProductImageProvider>().imagefileList;
        for (int i = 0; i < images!.length; i++) {
          String result = await uploadImage(images![i]);
          if (result == "Error") {
            Fluttertoast.showToast(
                msg: "error uploading image bad connection $i",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Image Uploaded Successfully  $i",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          await productimages
              .add({"product_id": productId, "ImageUrl": result}).then(
                  (DocumentReference documentRef) {
            Fluttertoast.showToast(
                msg: "Product image added successfully to firebase",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }).catchError((error) {
            Fluttertoast.showToast(
                msg: "error while adding Product image to firebase",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        }
        GetIt.instance<ProductImageProvider>().imagefileList = [];
        Navigator.pushReplacementNamed(context, "/AllProducts");
      }
    }
  }

  Future<String> uploadImage(XFile imageFile) async {
    var storageRef = FirebaseStorage.instance.ref();
    var imageRef =
        storageRef.child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");

    File file = File(imageFile.path);

    try {
      Fluttertoast.showToast(
          msg: "Starting upload for file: ${imageFile.path}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);

      UploadTask uploadTask = imageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      // Once the image upload completes, retrieve the public download URL
      String imageUrl = await snapshot.ref.getDownloadURL();
      Fluttertoast.showToast(
          msg: "Image Uploaded Successfully: $imageUrl",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return imageUrl;
    } catch (e) {
      print(
        "Error uploading image: $e",
      );
      Fluttertoast.showToast(
          msg: "Error uploading image: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return "Error";
    }
  }
}
