import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/categories_model_view.dart';
import 'package:shopmix/models/category_model.dart';

import 'package:shopmix/providers/dark_mode_provider.dart';


class CategoriesView extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;



  
  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<CategoriesModelView>()),

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

      body: 
      
      categoriesSelector()
    );
      



    }
    );
}

Widget CategoryComponent(double deviceWidth, double deviceHeight, CategoryModel category, double marginleftright) {
  if (category.categories.isEmpty) {
    // Base case: If no subcategories, return a simple widget for the category
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Visibility( 
        visible: category.visible,
        child: Container(
        
        
        margin: EdgeInsets.only(left: marginleftright),
        width: deviceWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                category.name,
                style: TextStyle(fontSize: deviceWidth * 0.05,color:  GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1]),
              ),
            ),
            
          ],
        ),
      )),
    );
  } else {
    // Recursive case: Render the category and its subcategories
    return Container(
       margin: EdgeInsets.only(top: 5),
      child: Visibility(
        visible: category.visible,
        child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: marginleftright),
            width: deviceWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    category.name,
                    style: TextStyle(fontSize: deviceWidth * 0.05,color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),
                  ),
                ),
                GestureDetector(
                  
                  onTap: (){
                    GetIt.instance.get<CategoriesModelView>().CategoryPress(category.Id);
                    
                  },
                  child: Icon(category.downward?Icons.arrow_drop_down:Icons.arrow_drop_up,color:  GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[1]:GetIt.instance.get<ColorsDesign>().light[1],),)
              ],
            ),
          ),
          Container(
            // Adjust this based on your UI needs
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: category.categories.length,
              itemBuilder: (BuildContext context, int indexx) {
                return CategoryComponent(deviceWidth, deviceHeight, category.categories[indexx], marginleftright + 20,);
              },
            ),
          )
        ],
      )),
    );
  }
}

Selector<CategoriesModelView,List<CategoryModel>> categoriesSelector(){

  return Selector<CategoriesModelView,List<CategoryModel>>(selector: (context,provider)=>provider.categories,
  shouldRebuild: (previous, next) => !identical(previous,next),
  builder: (context,value,child){
    return Container(

      padding: EdgeInsets.all(10),
      child: ListView.builder(itemCount: value.length, itemBuilder: (BuildContext context,int index){
        return CategoryComponent(_deviceWidth, _deviceHeight, value[index], 0);
      
      
      
      }),
    );



  },);
}


}