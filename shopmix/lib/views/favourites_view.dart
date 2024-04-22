import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/components/FavouriteProductComponent/favourite_product_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/favourites_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';


class FavouritesView extends StatelessWidget {

late double _deviceWidth;
late double _deviceHeight;

  
  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<FavouritesModelView>()),

    ],
    child: ScaffoldSelector()
    );

  }

      Selector<darkModeProvider,bool> ScaffoldSelector(){
    return Selector<darkModeProvider,bool>(selector: (context,provider)=>provider.isDark,
    shouldRebuild: (previous,next)=>!identical(previous,next),
    builder: (context, value, child){

      return Scaffold(

      backgroundColor:value?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],

      body: SingleChildScrollView(child: favouriteProductsSelector()),
      
    );
      



    }
    );
}

Selector<FavouritesModelView,List<ProductModel>> favouriteProductsSelector(){

  return Selector<FavouritesModelView,List<ProductModel>>(selector: (context,provider)=>provider.favouriteProducts,
  shouldRebuild: (previous, next) => !identical(previous,next),
  builder: (context,value,child){

    return favouriteProducts(value,context);
    //!!

  }
  );
}

Widget favouriteProducts(List<ProductModel> value,BuildContext context){
  if(value.isEmpty){

    return Center(child: Text("The favourite List is empty",style: TextStyle(color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),),);
  }


  return Column(children:value.asMap().entries.map<Widget>((e){

    return FavouriteProductComponent(product: e.value, deviceWidth: _deviceWidth,context: context);



  }).toList());


  
}




}

