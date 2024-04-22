import 'package:flutter/material.dart';

class ADDCategoryFormController {
  final GlobalKey<FormState> keyaddcategory = GlobalKey<FormState>();

  String Title = "";
  String parentcategoryid = "";

  void clearData() {
    Title = "";
    this.parentcategoryid = "";
  }

  void changeTitle(String? _Title) {
    print(_Title! + "changingg title");
    this.Title = _Title!;
  }

  void changeparentid(String? _id) {
    if (_id != null) {
      this.parentcategoryid = _id!;
    }
  }

  void onTap(BuildContext context) {
    if (keyaddcategory.currentState!.validate()) {
      keyaddcategory.currentState!.save();

      print("title: " + this.Title + " parentcategoryid: " + parentcategoryid);
    }
  }
}
