import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/designs/colors_design.dart';

import 'package:shopmix/modelViews/shop_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';


class ShopView extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<ShopModelView>()),

    ],
    child:ScaffoldSelector()
    );

  }
          Selector<darkModeProvider,bool> ScaffoldSelector(){
    return Selector<darkModeProvider,bool>(selector: (context,provider)=>provider.isDark,
    shouldRebuild: (previous,next)=>!identical(previous,next),
    builder: (context, value, child){

      return Scaffold(

      backgroundColor:value?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    );
      



    }
    );
}
}