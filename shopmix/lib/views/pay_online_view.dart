import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopmix/components/cartProductComponent/cart_product_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/cart_model_view.dart';
import 'package:shopmix/modelViews/order_model_view.dart';

class PayOnlineView extends StatefulWidget {
  PayOnlineView({Key? key}) : super(key: key); // Ensure keys are handled properly.

  @override
  payOnlineViewState createState() =>
      payOnlineViewState(); // Correctly return an instance of the state.
}

class payOnlineViewState extends State<PayOnlineView> {
  late Razorpay _razorpay;
  final TextEditingController amtController = TextEditingController();
  late double _deviceWidth;
  late double _deviceHeight;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout(double amount) async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount':
          amount * 100, // Convert to the smallest unit expected by Razorpay
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
   GetIt.instance.get<OrderModelView>().addOrder();
   Navigator.pushNamed(context,"/orders" );
   setState(() {
     
   });

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Gateway'),
      ),
      body:
      SingleChildScrollView(child:  Column(children: [Container(
        
            width: _deviceWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
             
              Container(
                    padding:EdgeInsets.only(left: 20,right: 20,top: 10,),
    margin: EdgeInsets.only(left: 20,right: 20,top: 10,),
                child: Text("number of items:"+GetIt.instance.get<CartModelView>().cartItems.length.toString(),style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().light[1] ),),),
              Container(
                    padding:EdgeInsets.only(left: 20,right: 20,top: 10,),
    margin: EdgeInsets.only(left: 20,right: 20,top: 10,),
                child: Text("Total price:"+GetIt.instance.get<CartModelView>().cart!.total.toString()+"\$",style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().light[1] ),),),
            
              Container(width: _deviceWidth,
              
                child:Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Container(
                          padding:EdgeInsets.only(left: 20,right: 20,top: 10,),
    margin: EdgeInsets.only(left: 20,right: 20,top: 10,),
                      child: Text("Cart Product details:",style: TextStyle(fontSize:_deviceWidth*0.05,color:GetIt.instance.get<ColorsDesign>().light[1]),),),
        

                    ],
                  ),
                ) ,),
                                    Visibility(
                                      visible: true,
                                      child: Container(
                      
                      child:
                       SingleChildScrollView(child: 
                       
                       
                       
                       Column(children: [Column(children:GetIt.instance.get<CartModelView>().cartItems.map<Widget>((e){

                        return CartProductComponent(product: e.product, quantity: e.quantity, deviceWidth: _deviceWidth, deviceHeight: _deviceHeight, isremoveVisible:false,context: context,);
                       }).toList(),),ConfirmPaymentButton()],),)
                      
               ,))
              
            
            ],),
          ),


        
      ],))
      
      /* Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: amtController,
              decoration: InputDecoration(hintText: 'Enter Amount'),
            ),
            ElevatedButton(
              onPressed: () {
                openCheckout(double.parse(amtController.text));
              },
              child: Text('Pay Now'),
            )
          ],
        ),
      ),*/
    );
  }
  Widget ConfirmPaymentButton(){
  return   

  Visibility(
    visible:GetIt.instance.get<CartModelView>().cartItems.length!=0,
    child: Container(
   
    width: _deviceWidth,
     padding:EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
  
  child: MaterialButton(
    color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],
    textColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    
    
    
    onPressed: (){
      openCheckout(GetIt.instance.get<CartModelView>().cart!.total);
     
    


    },
  child: Text("Confirm Payment"),),)) ;
}
}
