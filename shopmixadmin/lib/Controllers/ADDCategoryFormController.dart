import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ADDCategoryFormController {
  static GlobalKey<FormState> keyaddcategory = GlobalKey<FormState>();

  String Title = "";
  String parentcategoryid = "";

  void clearData() {
    Title = "";
    this.parentcategoryid = "";
  }

  void changeTitle(String? _Title) {
    print(_Title! + "changingg title");
    this.Title = _Title;
  }

  void changeparentid(String? _id) {
    if (_id != null) {
      this.parentcategoryid = _id;
    }
  }

  Future<void> onTap(BuildContext context) async {
    if (keyaddcategory.currentState!.validate()) {
      keyaddcategory.currentState!.save();

      print("title: " + this.Title + " parentcategoryid: " + parentcategoryid);

      CollectionReference categories =
          FirebaseFirestore.instance.collection("categories");

      categories.add({
        "name": this.Title,
        "parent_id": this.parentcategoryid,
      }).then((DocumentReference documentRef) {
        Fluttertoast.showToast(
            msg: "Category added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        clearData();
        Navigator.pushNamed(context, "/");
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "error while adding category",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }
}
