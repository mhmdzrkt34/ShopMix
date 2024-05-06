import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/models/chat_model.dart';

class ChatMessageComponent extends StatelessWidget {


  late double deviceWidth;

  late double deviceHeight;

  Color NameColor=GetIt.instance.get<ColorsDesign>().light[1];
  Color MessageColor= GetIt.instance.get<ColorsDesign>().light[0];
  Color DateColor=GetIt.instance.get<ColorsDesign>().light[1];

  ChatModel chat;

  ChatMessageComponent({required this.deviceWidth,required this.deviceHeight,required this.chat}){
    getpropertyColor(NameColor,MessageColor,DateColor);
  }


  


  @override
  Widget build(BuildContext context) {

    return Container(
                         margin: EdgeInsets.only(top: 10),
                  width: deviceWidth,
      child: Row(
                      mainAxisAlignment: chat.type=="receiver"? MainAxisAlignment.start:MainAxisAlignment.end,
                      children: [
                                 Container(
                                   margin: EdgeInsets.only(right: 2),
                                  width: deviceWidth*0.1,height: deviceHeight*0.05,
                       
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage("https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector-PNG-File.png"),fit: BoxFit.cover),
                          
                          borderRadius: BorderRadius.circular(100)),
                        ),
                
                        Column(children: [ 
                          Container(
                            width: deviceWidth*0.45,
                            child: Text(chat.type=="receiver"?"Admin": chat.email,style: TextStyle(color: NameColor),),)
                          
                          ,                         Container(
                               
                                width: deviceWidth*0.45,
                                padding: EdgeInsets.all(10),
                                child: Text(chat.message,style: TextStyle(color: MessageColor)),
                                color: chat.type=="receiver"?Colors.red:Colors.green,
                                
                              )

                              ,                Container(
                               
                                width: deviceWidth*0.45,
                                padding: EdgeInsets.all(10),
                                child: Text(chat.date.hour.toString()+":"+chat.date.minute.toString()+":"+chat.date.second.toString(),style: TextStyle(color: DateColor)),
                                
                                
                              )
                              
                              ],)
                
                        
                    
                
                            ],),
    );
  
  }



        void getpropertyColor(Color _nameColor,Color _messageColor,Color _dateColor) {

    if(GetIt.instance.get<ColorsDesign>().isDark==true){

      NameColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_nameColor);
      MessageColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_messageColor);
      DateColor=GetIt.instance.get<ColorsDesign>().getdarkColor(_dateColor);
      
    }
    else {
     
      
      

    }
    

  }

}
