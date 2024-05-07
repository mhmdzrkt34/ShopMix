
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderSearchPageProvider  extends ChangeNotifier{ 

  Map<String, dynamic>? order;


  Future<void> getOrder(String id) async {

    try{

    Map<String,dynamic> orderresult=(await FirebaseFirestore.instance.collection("orders").doc(id).get()).data() as Map<String, dynamic>;
    orderresult['id']=id;
    order=orderresult;

        if(order!["delivered"]==true){
          throw Exception();
      


    }

    
    notifyListeners();




    }catch(e){

         Fluttertoast.showToast(
        msg: "Incorrect or delivered Order plz check with the store manager",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }





    
  }











}