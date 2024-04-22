import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/components/productComponent/product_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/all_product_model_view.dart';
import 'package:shopmix/modelViews/all_sales_model_view.dart';
import 'package:shopmix/modelViews/home_body_model_view.dart';
import 'package:shopmix/modelViews/setting_model_view.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';

class AllSalesView extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;


  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<AllSalesModelView>()),
       ChangeNotifierProvider.value(value: GetIt.instance.get<darkModeProvider>()),


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

      body:SingleChildScrollView(child: Column(children: [AllProductsSelector()],),),
        appBar: AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,),

      
      
    );
      



    }
    );
}

Selector<AllSalesModelView,List<ProductModel>?> AllProductsSelector(){

  return Selector<AllSalesModelView,List<ProductModel>?>(selector: (context,provider)=>provider.SalesProduct,
  
  shouldRebuild: (previous,context)=>!identical(previous, context),
  builder: (context,value,child){

    if(value==null){

      return Center(child: CircularProgressIndicator(),);
    }

    return Container(width: _deviceWidth,
      child: Wrap(alignment: WrapAlignment.center,
        
        
      
        children: value.map((e){
      
          return Container( child: ProductComponent(product: e,deviceHeight: _deviceHeight,deviceWidth: _deviceWidth,context: context,));
      
        }).toList(),
      ),
    );

  },
  );


}







}