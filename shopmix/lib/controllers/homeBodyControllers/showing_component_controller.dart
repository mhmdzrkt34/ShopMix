import 'package:flutter/material.dart';

class ShowingComponentController {

  ShowingComponentController();



  void emptyFunction(){


  }

  void viewAllProductClick(BuildContext context){

    Navigator.pushNamed(context, "/AllProducts");
  }

  void viewAllSalesClick(BuildContext context){

    Navigator.pushNamed(context, "/AllSalesView");



  }

    void viewAllNewClick(BuildContext context){

    Navigator.pushNamed(context, "/AllNewView");



  }
}