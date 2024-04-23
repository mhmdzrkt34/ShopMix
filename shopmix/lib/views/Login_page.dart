import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/Controllers/LoginFormController.dart';
import 'package:shopmix/components/FormFielComonent.dart';
import 'package:shopmix/components/buttonComponent/button_component_kazem.dart';
import 'package:shopmix/components/logo/logo.dart';
import 'package:shopmix/darkmode/signup_dark_provider.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';

class Login extends StatelessWidget {
  Login({super.key});
  late double _deviceWidth;
  late double _deviceHeight;
  late Color color;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
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
          _context = context;
          final Color backgroundColor = isDark
              ? GetIt.instance<ColorsDesignkazem>().dark["background"]!
              : GetIt.instance<ColorsDesignkazem>().light["background"]!;

          return SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
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
                    _forgetpassword(),
                    _submit(),
                    _or(),
                    _sociallogin(),
                    _haveaccount(),
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
          key: GetIt.instance.get<LoginFormController>().key,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: _FormFields(),
          )),
    );
  }

  List<Widget> _FormFields() {
    return [
      _emailfeild(),
      _passwordfeild(),
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
        GetIt.instance<LoginFormController>().changeEmail,
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

  Widget _passwordfeild() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHeight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: FormFieldComponent(
        _passwordValidate,
        GetIt.instance<LoginFormController>().changePassword,
        "Password",
        GetIt.instance<ColorsDesignkazem>().isDark
            ? GetIt.instance<ColorsDesignkazem>().dark["input"]
            : GetIt.instance<ColorsDesignkazem>().light["input"],
        GetIt.instance<ColorsDesignkazem>().light["inputfoucs"],
        true,
        const Icon(Icons.security_sharp),
      ),
    );
  }

  String? _passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  Widget _haveaccount() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
        top: _deviceHeight * 0.009,
        left: _deviceWidth * 0.07,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Don't have account",
            style: TextStyle(
                fontSize: 16,
                color: GetIt.instance<ColorsDesignkazem>().isDark
                    ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                    : GetIt.instance<ColorsDesignkazem>().light["title"]),
          ),
          _Sigup(),
        ],
      ),
    );
  }

  Widget _Sigup() {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        "Register",
        style: TextStyle(
            fontWeight: FontWeight.w800,
            decoration: TextDecoration.underline,
            decorationColor: GetIt.instance<ColorsDesignkazem>().isDark
                ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                : GetIt.instance<ColorsDesignkazem>().light["title"],
            color: GetIt.instance<ColorsDesignkazem>().isDark
                ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                : GetIt.instance<ColorsDesignkazem>().light["title"]),
      ),
    );
  }

  Widget _forgetpassword() {
    return Container(
      margin: EdgeInsets.only(left: _deviceWidth * 0.029),
      child: Row(
        children: [
          MaterialButton(
            onPressed: () {},
            child: Text(
              "Forget Password",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: GetIt.instance<ColorsDesignkazem>().isDark
                      ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                      : GetIt.instance<ColorsDesignkazem>().light["title"],
                  color: GetIt.instance<ColorsDesignkazem>().isDark
                      ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                      : GetIt.instance<ColorsDesignkazem>().light["title"]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submit() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight * 0.005),
      child: buttonComponentkazem(
        [_deviceWidth * 0.9, _deviceHeight * 0.05],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        "Login",
        GetIt.instance<LoginFormController>().onTap,
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

  Widget _or() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight * 0.04),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Or Login with Social account",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: GetIt.instance<ColorsDesignkazem>().isDark
                    ? GetIt.instance<ColorsDesignkazem>().dark["title"]
                    : GetIt.instance<ColorsDesignkazem>().light["title"]),
          ),
        ],
      ),
    );
  }

  Widget _sociallogin() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight * 0.005),
      padding: EdgeInsets.only(bottom: _deviceHeight * 0.05),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_google(), _facebook()],
      ),
    );
  }

  Widget _facebook() {
    return Container(
      padding: EdgeInsets.only(
          top: _deviceHeight * 0.006,
          bottom: _deviceHeight * 0.006,
          right: _deviceWidth * 0.03,
          left: _deviceWidth * 0.03),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GetIt.instance<ColorsDesignkazem>().isDark
            ? GetIt.instance<ColorsDesignkazem>().dark["input"]
            : GetIt.instance<ColorsDesignkazem>().light["input"],
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        alignment: Alignment.center,
        icon: Icon(
          size: _deviceHeight * 0.05,
          Icons.facebook,
          color: Colors.blue,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _google() {
    return Container(
      padding: EdgeInsets.only(
          top: _deviceHeight * 0.02, bottom: _deviceHeight * 0.02),
      decoration: BoxDecoration(
        color: GetIt.instance<ColorsDesignkazem>().isDark
            ? GetIt.instance<ColorsDesignkazem>().dark["input"]
            : GetIt.instance<ColorsDesignkazem>().light["input"],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: _deviceWidth * 0.2,
        height: _deviceWidth * 0.08,
        child: GestureDetector(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/google_logo.png',
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
