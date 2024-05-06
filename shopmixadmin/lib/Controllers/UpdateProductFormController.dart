import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shopmixadmin/image_provider/product_update_image_provider.dart';
import 'package:shopmixadmin/models/product.dart';

class UpdateProductFormController {
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  ProductModel? updatedproduct;

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
    String productId = updatedproduct!.id;
    bool verfied = true;
    if (GetIt.instance<ProductupdateImageProvider>().imagefileList!.isEmpty) {
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

        await deleteProductImages(productId);

        await updateProductData(productId);

        await uploadNewImages(productId);
        clearData();
        GetIt.instance<ProductupdateImageProvider>().imagefileList = [];
        Navigator.pushReplacementNamed(context, "/AllProducts");
      }
    }
  }

  Future<void> updateProductData(String productId) async {
    
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({
        "category_id": category,
        "description": Description,
        "price": Price,
        "quantity": quantity,
        "salePercent": sale,
        "title": Title,
      });
      Fluttertoast.showToast(
        msg: "Product updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error updating product: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> deleteProductImages(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('productImages')
          .where('product_id', isEqualTo: productId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } catch (error) {
      print('Error deleting product images: $error');
    }
  }

  Future<void> uploadNewImages(String productId) async {
    // Upload new images
    List<XFile>? images =
        GetIt.instance<ProductupdateImageProvider>().imagefileList;
    for (int i = 0; i < images!.length; i++) {
      String result = await uploadImage(images[i]);
      if (result == "Error") {
        Fluttertoast.showToast(
          msg: "Error updating product images",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        await FirebaseFirestore.instance.collection('productImages').add({
          "product_id": productId,
          "ImageUrl": result,
        }).then((DocumentReference documentRef) {
          Fluttertoast.showToast(
            msg: "Product image added successfully to firebase",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }).catchError((error) {
          Fluttertoast.showToast(
            msg: "Error while adding product image to firebase: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      }
    }
  }

  Future<String> uploadImage(XFile imageFile) async {
    try {
      var storageRef = FirebaseStorage.instance.ref();
      var imageRef = storageRef
          .child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");
      File file = File(imageFile.path);
      UploadTask uploadTask = imageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return "Error";
    }
  }
}
