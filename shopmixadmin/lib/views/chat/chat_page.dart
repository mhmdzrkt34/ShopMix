import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/chatprovider/chating_user_provider.dart';
import 'package:shopmixadmin/components/App_Bar_user_chat%20.dart';
import 'package:shopmixadmin/components/Side_Bar.dart';
import 'package:shopmixadmin/models/Message.dart';

class chatpage extends StatelessWidget {
  chatpage({super.key});

  Duration duration = new Duration();
  Duration position = new Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  late double _devicewidth;
  late double _devicehieght;

  @override
  Widget build(BuildContext context) {
    _devicewidth = MediaQuery.of(context).size.width;
    _devicehieght = MediaQuery.of(context).size.height;

    final now = new DateTime.now();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<userchatprovider>(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBarUserchat(_devicehieght, _devicewidth),
        drawer: SideBar(context),
        backgroundColor: Color.fromARGB(255, 227, 230, 231),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 100),
                  child: _messagesselctor(),
                ),
              ),
            ),
            MessageBar(
              onSend: (value) {
                GetIt.instance<userchatprovider>()
                    .SendMessage(value  );
              },
              actions: [
                InkWell(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 24,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.green,
                      size: 24,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Selector<userchatprovider, List<Message>?> _messagesselctor() {
    GetIt.instance<userchatprovider>().messagesgeting();
    return Selector<userchatprovider, List<Message>?>(
      selector: (context, provider) => provider.messages,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        return _messages(value);
      },
    );
  }

  Widget _messages(List<Message>? value) {
    if (value == null) {
      return Center(
        child: Text("no message"),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: value.length,
      itemBuilder: (BuildContext context, int index) {
        Message mess = value[index];
        return _buildMessage(mess);
      },
    );
  }

  Widget _buildMessage(Message message) {
    if (message.type == 'sender') {
      return BubbleSpecialTwo(
        text: message.message,
        isSender: true,
        color: Colors.blue,
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      );
    } else {
      return BubbleSpecialTwo(
        text: message.message,
        isSender: false,
        color: Colors.grey,
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      );
    }
  }
}
