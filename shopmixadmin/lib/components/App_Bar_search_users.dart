import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/model_views/user_model_view.dart';
import 'package:shopmixadmin/voiceprovider/SpeechRecognitionProvider.dart';

class AdminAppBarSearchusers extends StatelessWidget
    implements PreferredSizeWidget {
  final double _height;
  final double _width;
  final String _title;
  final TextEditingController _textController = TextEditingController();

  AdminAppBarSearchusers(this._height, this._width, this._title);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SpeechRecognitionProvider>(
          create: (_) => SpeechRecognitionProvider(),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final speechProvider = Provider.of<SpeechRecognitionProvider>(context,
              listen: false); // Listen: false to avoid unnecessary rebuilds

          _requestMicrophonePermission(context, speechProvider);

          _textController.text = speechProvider.lastWords;

          return AppBar(
            actions: appbarricons(),
            centerTitle: true,
            title: Text(_title),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: TextField(
                  onChanged: (value) {
                    Provider.of<UserModelView>(context, listen: false)
                        .searchusers(value);
                  },
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 6, 10),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    suffixIcon: Consumer<SpeechRecognitionProvider>(
                      builder: (context, provider, child) {
                        return IconButton(
                          icon: Icon(provider.isListening
                              ? Icons.mic_off_outlined
                              : Icons.mic_none_rounded),
                          onPressed: () {
                            if (provider.isListening) {
                              provider.stopListening();
                            } else {
                              provider.startListening();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _requestMicrophonePermission(
      BuildContext context, SpeechRecognitionProvider speechProvider) async {
    PermissionStatus permissionStatus = await Permission.microphone.request();
    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Microphone permission is required.'),
      ));
    } else if (permissionStatus.isGranted) {
      await speechProvider.initialize();
    }
  }

  List<Widget> appbarricons() {
    return [
      Container(
        margin: EdgeInsets.only(right: _width * 0.05),
        child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
      ),
    ];
  }

  @override
  Size get preferredSize => Size.fromHeight(_height * 0.12);
}
