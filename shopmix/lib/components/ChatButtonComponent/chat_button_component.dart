import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/chatMessageComponent/chat_message_component.dart';
import 'package:shopmix/controllers/ChatController/scrlController.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/home_model_view.dart';
import 'package:shopmix/models/chat_model.dart';

class ChatButtonComponent extends StatelessWidget {

  Color backgroundIconColor=GetIt.instance.get<ColorsDesign>().light[2];


  Color IconColor=GetIt.instance.get<ColorsDesign>().light[0];
  Color chatZoneBackground=GetIt.instance.get<ColorsDesign>().light[0];

  Color formHintColor=GetIt.instance.get<ColorsDesign>().light[1];
  Color FormColor=GetIt.instance.get<ColorsDesign>().light[1];


  late double deviceHeight;
  late double deviceWidth;
  late double deviceTopPadding;








  ChatButtonComponent({required this.deviceHeight,required this.deviceWidth,required this.deviceTopPadding}){
getpropertyColor();

  }



  


@override
  Widget build(BuildContext context) {
    String mes="";
      

    final GlobalKey<FormState> key=GlobalKey<FormState>();
    // TODO: implement build
    return FloatingActionButton(
      child: Icon(Icons.chat,color: IconColor,),
      backgroundColor: backgroundIconColor,
      
      onPressed: (){
        showDialog(context: context, builder: (BuildContext context){

          
 
                    
        
         return ChangeNotifierProvider.value(value: GetIt.instance.get<HomeModelView>(),child:   AlertDialog(
            
            backgroundColor: chatZoneBackground,
            

            content:IntrinsicHeight(child: SingleChildScrollView(
              
              
              child: Column(children: [Container(   width: deviceWidth*0.8,
              height: deviceHeight*0.6,
              child: SingleChildScrollView(
                controller: GetIt.instance.get<scrlController>().scrollController,
                child: Column(children: [       Container(
         
                child:Column(children: [                             
chats()    ],)),],),),
            ),
            
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [ 

             Container(width: deviceWidth*0.55,
  child: Form(
                key: key,
                child: Column(children: [Container(
                  
                  child: TextFormField(
                    style: TextStyle(color: FormColor),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: formHintColor),
                      
                      hintText: "Message",border: InputBorder.none),
                    
                  
                   onSaved: (value){
                    mes=value!;
                  
                   },
                   validator: (value){
                    bool result=value!.length==0?false:true;
                    return result?null:"empty message";
                  
                   },
                  ),
                )],)),
), 
  

 GestureDetector(
  onTap: (){

    if(key.currentState!.validate()){

      key.currentState!.save();
      GetIt.instance.get<HomeModelView>().addChat(mes);
     

      
    };
  },
  child:  Icon(Icons.send,color: Colors.green,size: deviceWidth*0.05,),),],)
            ],),))
              
              
            
      
          ));
        


        });



    


    });
  }

              void getpropertyColor(
        ) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){
      backgroundIconColor=GetIt.instance.get<ColorsDesign>().getdarkColor(backgroundIconColor);
      IconColor=GetIt.instance.get<ColorsDesign>().getdarkColor(IconColor);
      chatZoneBackground=GetIt.instance.get<ColorsDesign>().getdarkColor(chatZoneBackground);
      formHintColor=GetIt.instance.get<ColorsDesign>().getdarkColor(formHintColor);
      FormColor=GetIt.instance.get<ColorsDesign>().getdarkColor(FormColor);
      



      
    }
    else {
      
      
      

    }
    

}

Selector<HomeModelView,List<ChatModel>?> chats(){

  return Selector<HomeModelView,List<ChatModel>?>(selector: (context,provider)=>provider.chats,
  shouldRebuild: (previous,next)=>!identical(previous, next),


  builder: (context,value,child){

    return ChatWidget(value);

    


  },


  );


}

Widget ChatWidget(List<ChatModel>? chats){

  if(chats==null){
    return Center(child: CircularProgressIndicator(),);
  }

  return Column(children:chats.map<Widget>((e){

    return ChatMessageComponent(deviceWidth: deviceWidth, deviceHeight: deviceHeight, chat: e);

  }).toList(),);
}
}