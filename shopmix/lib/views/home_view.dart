import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/ChatButtonComponent/chat_button_component.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/components/bottomBarComponent/bottom_bar_component.dart';
import 'package:shopmix/components/moreTapComponent/more_tap_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';
import 'package:tuple/tuple.dart';

class HomeView extends StatelessWidget  {



  late double _deviceWidth,_deviceHeight,_deviceTopPadding;
  late BuildContext currentPageContext;


  @override
  Widget build(BuildContext context) {
    currentPageContext=context;
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceTopPadding=MediaQuery.of(context).padding.top;
    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<HomeModelView>()
    
    ),ChangeNotifierProvider.value(value: GetIt.instance.get<darkModeProvider>())
    ],
    child: ScaffoldSelector(),
    
    );

  }

  Selector<darkModeProvider,bool> ScaffoldSelector(){
    return Selector<darkModeProvider,bool>(selector: (context,provider)=>provider.isDark,
    shouldRebuild: (previous,next)=>!identical(previous,next),
    builder: (context, value, child){
      return Scaffold(
       body:
       Stack(children: [ BodySelector(),Positioned(top: 0,right: 10, child: MoreTapWidgetSelector()) ],),
      
        
      
      appBar: AppBarComponent(height: _deviceHeight*0.14,backtickenabled: false,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: true,searchVisible: false,filter: Filter,),
      bottomNavigationBar:BottomBarComponentSelector(),
      floatingActionButton: ChatButtonComponent(deviceHeight: _deviceHeight,deviceWidth: _deviceWidth,deviceTopPadding: _deviceTopPadding),

    );

     

    },
    );
   

  }
  Selector<HomeModelView,Widget> BodySelector(){

    return Selector<HomeModelView,Widget>(selector: (context,provider)=>provider.currentPage,
    shouldRebuild: (previous, next) => !identical(previous, next),
    builder: (context, value, child){

      return value;

    },
    );
    
  }
  Widget BottomBarComponentSelector(){

    return Selector<HomeModelView,Tuple2<int,int>> (selector: (context,provider)=>Tuple2(provider.currentPageIndex, provider.cartItems),
    shouldRebuild: (previous, next) => !identical(previous.item1, next.item1) || !identical(previous.item2, next.item2),
    builder: (context,value,child){

      return BottomBarComponent(selectedItemColor:  GetIt.instance.get<ColorsDesign>().light[2],unSelectedItemColor: GetIt.instance.get<ColorsDesign>().light[3],backgroundColor: GetIt.instance.get<ColorsDesign>().light[0],index: value.item1,cartitems: value.item2,);


    },
    );
  }
  Selector<HomeModelView,bool> MoreTapWidgetSelector(){


    return Selector<HomeModelView,bool>(selector: (context,provider)=>provider.moreTapView,
    shouldRebuild: (previous, next) =>!identical(previous,next),
   
    
    builder: (context, value, child){
      if(value){
        return MoreTapWidget(currentPageContext);
      }
      return SizedBox();


      
    });
  }

  Widget MoreTapWidget(BuildContext context){

  return MoreTapComponent(deviceWidth: _deviceWidth*0.4,HomePageContext: context,);
  }




    



void Filter(String value){

  print(value);
}




  

  

  
}