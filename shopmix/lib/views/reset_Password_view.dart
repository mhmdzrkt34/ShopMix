import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:shopmix/components/FormFielComonent.dart';
import 'package:shopmix/components/buttonComponent/button_component_kazem.dart';
import 'package:shopmix/components/logo/logo.dart';
import 'package:shopmix/darkmode/signup_dark_provider.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';


class ResetPasswordView extends StatelessWidget {
 
  late double _deviceWidth;
  late double _deviceHeight;
  late Color color;
  late BuildContext _context;
  final GlobalKey<FormState> key=GlobalKey<FormState>();

  String email="";

  @override
  Widget build(BuildContext context) {
     _context = context;
    color = GetIt.instance<ColorsDesignkazem>().light["background"]!;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<SignupDarkprovider>(),
        )
      ],
      child: Selector<SignupDarkprovider, bool>(
        selector: (context, provider) => provider.isDark,
        shouldRebuild: (previous, next) => !identical(previous, next),
        builder: (context, isDark, child) {
         
          final Color backgroundColor = isDark
              ? GetIt.instance<ColorsDesignkazem>().dark["background"]!
              : GetIt.instance<ColorsDesignkazem>().light["background"]!;

          return SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,

                title: Text(
                  "Login",
                  style: TextStyle(
                      color: GetIt.instance<ColorsDesignkazem>().isDark
                          ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                          : GetIt.instance<ColorsDesignkazem>().light["title"]),
                ),
                backgroundColor: backgroundColor,
                actions: <Widget>[
                  IconButton(
                    icon: GetIt.instance<ColorsDesignkazem>().isDark
                        ? const Icon(
                            Icons.light_mode,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.dark_mode,
                            color: Colors.black,
                          ),
                    onPressed: () {
                      GetIt.instance.get<SignupDarkprovider>().changeMode();

                      print("Background render");
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _logofather(),
                    _form(),
                 
                    _submit(),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight * 0.025),
      child: Form(
          key:key,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: _FormFields(),
          )),
    );
  }

  List<Widget> _FormFields() {
    return [
      _emailfeild(),
     
    ];
  }

  Widget _logofather() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight * 0.005),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo(
              _deviceHeight * 0.1,
              _deviceWidth * 0.3,
              GetIt.instance<ColorsDesignkazem>().isDark
                  ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                  : GetIt.instance<ColorsDesignkazem>().light["title"],
              30),
        ],
      ),
    );
  }

  Widget _emailfeild() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHeight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: FormFieldComponent(
        _emailValidate,
        this.changeEmail,
        "Email",
        GetIt.instance<ColorsDesignkazem>().isDark
            ? GetIt.instance<ColorsDesignkazem>().dark["input"]
            : GetIt.instance<ColorsDesignkazem>().light["input"],
        GetIt.instance<ColorsDesignkazem>().light["inputfoucs"],
        false,
        const Icon(Icons.email_outlined),
      ),
    );
  }

  String? _emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }








  Widget _submit() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight * 0.005),
      child: buttonComponentkazem(
        [_deviceWidth * 0.9, _deviceHeight * 0.05],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        "Send Email",
        onTap,
        GetIt.instance<ColorsDesignkazem>().light["button"]!,
        20,
        GetIt.instance<ColorsDesignkazem>().isDark
            ? GetIt.instance<ColorsDesignkazem>().dark["buttontext"] ??
                Colors.white
            : GetIt.instance<ColorsDesignkazem>().light["buttontext"] ??
                Colors.black,
        _context,
      ),
    );
  }

  
  
  void changeEmail(String? emaill) {
   
    email = emaill!;
  }

 void onTap(BuildContext context) async{


    if (key.currentState!.validate()) {
      key.currentState!.save();

    }






}
}
