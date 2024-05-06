import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/modelViews/all_new_product_model_view.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/all_sales_model_view.dart';
import 'package:shopmix/modelViews/home_body_model_view.dart';
import 'package:shopmix/models/image_slider_model.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/imageSliderRepository/IImageSliderRepository.dart';
import 'package:shopmix/repositories/imageSliderRepository/imageSLiderApi.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';
import 'package:shopmix/repositories/productRepository/productFirebase.dart';

class sharedProvider extends ChangeNotifier {



  IProductRepository productRepository=ProductFirebase();

  IImageSliderRepository imageSliderRepository=ImageSliderApi();




  sharedProvider(){

onInit();


  }

  Future<void> onInit() async{


    /*List<ProductModel>? allproducts=await productRepository.getProducts();

    GetIt.instance.get<AllProductModelView>().GetProducts(allproducts);

    List<ProductModel>? allSales=allproducts!.where((element) => element.salePercentage>0).toList();

    List<ProductModel>? allnewproducts=allproducts!.where((element) => element.isNew==true).toList();

    GetIt.instance.get<HomeBodyModelView>().getSomeNewProducts(allnewproducts);

    GetIt.instance.get<HomeBodyModelView>().getSomeProducts(allproducts);
     GetIt.instance.get<HomeBodyModelView>().getSomeSalesProducts(allSales);

    

    GetIt.instance.get<AllSalesModelView>().getSalesproducts(allSales);
    GetIt.instance.get<AllNewProductModelView>().getAllNewProducts(allnewproducts);




    List<ImageSliderModel>? imageSliders=await imageSliderRepository.getImageSliders();
    print(imageSliders!.length);

    GetIt.instance.get<HomeBodyModelView>().getImageSliders(imageSliders);*/

      Stream<QuerySnapshot> productImagesStream = FirebaseFirestore.instance.collection('productImages').snapshots();
  Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance.collection('products').snapshots();
   StreamGroup<QuerySnapshot> streamGroup = StreamGroup<QuerySnapshot>();
  streamGroup.add(productImagesStream);
   streamGroup.add(productsStream);

  // Combine the streams
  

   streamGroup.stream.listen((QuerySnapshot snapshot) async {



    
      List<ProductModel> allproducts=[];
     

      var documents=(await FirebaseFirestore.instance.collection("products").get()).docs;
      for(var item in documents){
        

        Map<String,dynamic> json=item.data() as Map<String,dynamic>;

        json['id']=item.id;
        ProductModel product=await ProductModel.FromJson(json);

        allproducts.add(product);


        

        
      }

                  GetIt.instance.get<AllProductModelView>().GetProducts(allproducts);

    List<ProductModel>? allSales=allproducts.where((element) => element.salePercentage>0).toList();

    List<ProductModel>? allnewproducts=allproducts.where((element) => element.isNew==true).toList();

    GetIt.instance.get<HomeBodyModelView>().getSomeNewProducts(allnewproducts);

    GetIt.instance.get<HomeBodyModelView>().getSomeProducts(allproducts);
     GetIt.instance.get<HomeBodyModelView>().getSomeSalesProducts(allSales);

    

    GetIt.instance.get<AllSalesModelView>().getSalesproducts(allSales);
    GetIt.instance.get<AllNewProductModelView>().getAllNewProducts(allnewproducts);




    List<ImageSliderModel>? imageSliders=await imageSliderRepository.getImageSliders();
    

    GetIt.instance.get<HomeBodyModelView>().getImageSliders(imageSliders);
        


     
       
    });
    


   }


    





  
     




  }

  

  






