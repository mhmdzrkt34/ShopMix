import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmixdelivery/pages/map_distance_page.dart';
import 'package:shopmixdelivery/pages/map_page_provider.dart';
import 'package:shopmixdelivery/pages/order_search_page_provider.dart';

class OrderPage extends StatelessWidget {

  late double _deviceWidth;
  late double _deviceHeight;

  String orderId="";

  final GlobalKey<FormState> key=GlobalKey<FormState>();

  




  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;

    _deviceHeight=MediaQuery.of(context).size.height;




    return 
    
    MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<OrderSearchPageProvider>())],
    
    child:    Scaffold(

      body: SafeArea(child: SingleChildScrollView(

        child: Container(
          
          margin: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(children: [FormSearch(),searchButton(),OrderSelector()],)),
      )),
    )
 ,
    );

  }

  Widget FormSearch(){

    return Form(
      key: key,
      child: Column(children: [

        Container(width:_deviceWidth,
        
        child: TextFormField(

          decoration: InputDecoration(label: Text("Search by order id")),
          validator: (value){
            bool result=value!.length==0? false:true;

            return result? null:"empty field";


          },
          onSaved: (value){
            orderId=value!;



          },
          
        ),)
      ],));
  }


  Widget searchButton(){


    return  Container(
   
   
    width: _deviceWidth,
     
  
  child: MaterialButton(
    color: Colors.red,
    textColor: Colors.white,
    
    
    
    onPressed: (){
      //Navigator.pushNamed(currentcontext, "/orderMethodView");

      if(key.currentState!.validate()){
        key.currentState!.save();

        GetIt.instance.get<OrderSearchPageProvider>().getOrder(orderId);

       
  
      }
      else {

        
      }


    },
  child: Text("search"),),) ;
  }

  Selector<OrderSearchPageProvider,Map<String,dynamic>?> OrderSelector(){


    return  Selector<OrderSearchPageProvider,Map<String,dynamic>?>(selector: (context,provider)=>provider.order,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),
    builder: (context,value,child){

      if(value==null){
        return SizedBox();
      }

      return Container(width: _deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(child: Text("order details:"),),
        
          Container(child: Text("quantity:"+value!["quantity"].toString()),),
          Container(child: Text("price with vat:"+value!["totalPrice"].toStringAsFixed(2)+"\$"),),
        
          Container(child: Text("user Email:"+value!["user_email"]),),
          MaterialButton(
    color: Colors.red,
    textColor: Colors.white,
    
    
    
    onPressed: (){
      //Navigator.pushNamed(currentcontext, "/orderMethodView");

      GetIt.instance.get<MapPageProvider>().start(value);
      Navigator.pushNamed(context, "mapDistancePage");



    },
  child: Text("Start Delivery proccess"),)
        
        
        ],),
      );


    },
    );
  }


 


}