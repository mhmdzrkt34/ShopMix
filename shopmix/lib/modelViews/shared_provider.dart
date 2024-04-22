import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/modelViews/all_new_product_model_view.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/all_sales_model_view.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';

class sharedProvider extends ChangeNotifier {



  IProductRepository productRepository=ProductFirebase();




  sharedProvider(){

onInit();


  }

  Future<void> onInit() async{

    List<ProductModel>? allproducts=await productRepository.getProducts();

    GetIt.instance.get<AllProductModelView>().GetProducts(allproducts);

    List<ProductModel>? allSales=allproducts!.where((element) => element.salePercentage>0).toList();

    List<ProductModel>? allnewproducts=allproducts!.where((element) => element.isNew==true).toList();

    GetIt.instance.get<AllSalesModelView>().getSalesproducts(allSales);
    GetIt.instance.get<AllNewProductModelView>().getAllNewProducts(allnewproducts);

  }

  






}