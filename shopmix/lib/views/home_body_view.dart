

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/components/ShowingComponent/showing_component.dart';
import 'package:shopmix/components/productComponent/product_component.dart';
import 'package:shopmix/controllers/homeBodyControllers/showing_component_controller.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/home_body_model_view.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';

class HomeBodyView extends StatelessWidget {
  late double _deviceWidth;
  late double _deviceHeight;
  late double _deviceTopPadding;

  
  @override
  Widget build(BuildContext context) {
        _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceTopPadding=MediaQuery.of(context).padding.top;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<HomeBodyModelView>()
      
      ),

      ChangeNotifierProvider.value(value: GetIt.instance.get<HomeModelView>())



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
      body:SingleChildScrollView(
        child: Container(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [SaleZone(context),
          
          
          AllSaleProductSelector(context),
              NewZone(context),
              AllNewProductSelector(context),
          
            ProductZone(context),
            AllProductSelector(context)
            
            
          ],),
        ),

      ),
    );
      



    }
    );
}

Widget SaleZone(BuildContext context){
 return ShowingComponent(title: "Sale", subtitle: "Super summer sale", trailing: "View All", trailingOnPressToDo: GetIt.instance.get<ShowingComponentController>().viewAllSalesClick, deviceWidth: _deviceWidth,context: context,);
}

Widget NewZone(BuildContext context){
  return ShowingComponent(title: "New", subtitle: "You have never seen it before!", trailing: "View All", trailingOnPressToDo: GetIt.instance.get<ShowingComponentController>().viewAllNewClick, deviceWidth: _deviceWidth,context: context,);


}

Widget ProductZone(BuildContext context){

   return ShowingComponent(title: "Products", subtitle: "Some of Our products", trailing: "View All", trailingOnPressToDo: GetIt.instance.get<ShowingComponentController>().viewAllProductClick, deviceWidth: _deviceWidth,context: context,);



}






Selector<HomeBodyModelView,List<ProductModel>> AllProductSelector(BuildContext context){


  return Selector<HomeBodyModelView,List<ProductModel>>(selector: (context,provider)=>provider.someproducts,
  
  shouldRebuild: (previous,next)=>!identical(previous, next),
  builder: (context, value, child){

    return AllProducts(value,context);



  },
  );
}


Widget AllProducts(value,BuildContext context){

if(value.length==0){

  return Center(child: CircularProgressIndicator(),);
}

return 

         
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
          child: Row(  
            
            children:value.map<Widget>((e){

            return ProductComponent(product: e,deviceWidth: _deviceWidth,deviceHeight: _deviceHeight,context: context,);

          }).toList(),
          ),
          );
           


          }


          Selector<HomeBodyModelView,List<ProductModel>> AllNewProductSelector(BuildContext context){


  return Selector<HomeBodyModelView,List<ProductModel>>(selector: (context,provider)=>provider.somenewProducts,
  
  shouldRebuild: (previous,next)=>!identical(previous, next),
  builder: (context, value, child){

    return AllNewProducts(value,context);



  },
  );
}


Widget AllNewProducts(value,BuildContext context){

if(value.length==0){

  return Center(child: CircularProgressIndicator(),);
}

return 

         
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
          child: Row(children:value.map<Widget>((e){

            return ProductComponent(product: e,deviceWidth: _deviceWidth,deviceHeight: _deviceHeight,context: context,);

          }).toList(),
          ),
          );
           


          }





                    Selector<HomeBodyModelView,List<ProductModel>> AllSaleProductSelector(BuildContext context){


  return Selector<HomeBodyModelView,List<ProductModel>>(selector: (context,provider)=>provider.somesalesProducts,
  
  shouldRebuild: (previous,next)=>!identical(previous, next),
  builder: (context, value, child){

    return AllNewProducts(value,context);



  },
  );
}


Widget AllSaleProducts(value,BuildContext context){

if(value.length==0){

  return Center(child: CircularProgressIndicator(),);
}

return 

         
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
          child: Row(children:value.map<Widget>((e){

            return ProductComponent(product: e,deviceWidth: _deviceWidth,deviceHeight: _deviceHeight,context: context,);

          }).toList(),
          ),
          );
           


          }


}












