import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/home_model_view.dart';

class BottomBarComponent extends StatelessWidget {
  
  late Color selectedItemColor,unSelectedItemColor,backgroundColor;
  late int index;
  late int cartitems;

  Color cartItemFontColor=GetIt.instance.get<ColorsDesign>().light[2];

  BottomBarComponent({required this.selectedItemColor,required this.unSelectedItemColor,required this.backgroundColor,required this.index,required this.cartitems}){
    getpropertyColor(selectedItemColor,backgroundColor,unSelectedItemColor,cartItemFontColor);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      onTap: (value){
        GetIt.instance.get<HomeModelView>().changeCurrentPage(value);
        GetIt.instance.get<HomeModelView>().hideMoreTapView();

      },
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
       selectedItemColor: selectedItemColor,
       unselectedItemColor:unSelectedItemColor,
       backgroundColor: backgroundColor,

      items: [HomebottomNavigationBarItem(),CartNavigationBarItem(),FavouriteNavigationBarItem(),CategoriesNavigationBarItem(), ProfileNavigationBarItem()]);
  }


  BottomNavigationBarItem HomebottomNavigationBarItem(){

    return 
    BottomNavigationBarItem( icon: Icon(Icons.home),label: "Home");
  }

    BottomNavigationBarItem bottomNavigationBarItem(){

    return 
    BottomNavigationBarItem( icon: Icon(Icons.shopping_cart_outlined),label: "Shop");
  }

  
    BottomNavigationBarItem CartNavigationBarItem(){

    return 
    BottomNavigationBarItem( icon: 
    Stack(
      clipBehavior: Clip.none,
      children: [ Icon(Icons.card_travel_outlined),Visibility(
        visible: cartitems==0?false:true,
        child: Positioned(
        top: -10,
        right: -10,
      

      child: Text(cartitems.toString(),style: TextStyle(fontSize: 20,color: cartItemFontColor),)))],)
   ,label: "Cart");
  }

      BottomNavigationBarItem FavouriteNavigationBarItem(){

    return 
    BottomNavigationBarItem( icon: Icon(Icons.favorite),label: "Favorites");
  }

  
      BottomNavigationBarItem ProfileNavigationBarItem(){

    return 
    BottomNavigationBarItem( icon: Icon(Icons.person),label: "Profile");
  }

        BottomNavigationBarItem CategoriesNavigationBarItem(){

    return 
    BottomNavigationBarItem( icon: Icon(Icons.category),label: "Categories");
  }



      void getpropertyColor(Color _selectedItemColor,Color _backgroundColor,Color _unselectedItemColor,Color _cartItemFontColor) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

      backgroundColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_backgroundColor);
      selectedItemColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_selectedItemColor);
      unSelectedItemColor==GetIt.instance.get<ColorsDesign>().getdarkColor(_unselectedItemColor);
      cartItemFontColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_cartItemFontColor);
      
    }
    else {
      backgroundColor=_backgroundColor;
      selectedItemColor=_selectedItemColor;
      unSelectedItemColor = _unselectedItemColor;
      

    }
    

  }

  


}