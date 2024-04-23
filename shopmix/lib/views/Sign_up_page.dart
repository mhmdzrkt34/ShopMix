import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/Controllers/SignUpFormController.dart';
import 'package:shopmix/components/FormFielComonent.dart';
import 'package:shopmix/components/buttonComponent/button_component.dart';
import 'package:shopmix/components/logo/logo.dart';
import 'package:shopmix/darkmode/signup_dark_provider.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  late double _deviceWidth;
  late double _deviceHeight;
  late Color color;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    color = GetIt.instance<ColorsDesign>().light["background"]!;
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
              ? GetIt.instance<ColorsDesign>().dark["background"]!
              : GetIt.instance<ColorsDesign>().light["background"]!;

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: Text(
                "Sign Up",
                style: TextStyle(
                    color: GetIt.instance<ColorsDesign>().isDark
                        ? GetIt.instance<ColorsDesign>().dark["title"]
                        : GetIt.instance<ColorsDesign>().light["title"]),
              ),
              backgroundColor: backgroundColor,
              actions: <Widget>[
                IconButton(
                  icon: GetIt.instance<ColorsDesign>().isDark
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
                  _haveaccount(),
                  _submit(),
                  _or(),
                  _socialsignup(),
                ],
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
          key: GetIt.instance.get<SignUpFormController>().key,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: _FormFields(),
          )),
    );
  }

  List<Widget> _FormFields() {
    return [
      _namefeild(),
      _emailfeild(),
      _phoneinput(),
      _passwordfeild(),
      _confirmpasswordfeild(),
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
              GetIt.instance<ColorsDesign>().isDark
                  ? GetIt.instance<ColorsDesign>().dark["title"]
                  : GetIt.instance<ColorsDesign>().light["title"],
              30),
        ],
      ),
    );
  }

  Widget _phoneinput() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHeight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: PhoneFormField(
        initialValue: PhoneNumber.parse('+961'),
        validator: PhoneValidator.compose([
          PhoneValidator.required(_context),
          PhoneValidator.validMobile(_context)
        ]),
        countrySelectorNavigator: const CountrySelectorNavigator.page(),
        onChanged: (phoneNumber) {
          GetIt.instance<SignUpFormController>()
              .changephone(phoneNumber.toString());
          GetIt.instance<SignUpFormController>()
              .changecountry(phoneNumber.countryCode);
        },
        enabled: true,
        isCountrySelectionEnabled: true,
        isCountryButtonPersistent: true,
        countryButtonStyle: const CountryButtonStyle(
            showDialCode: true,
            showIsoCode: true,
            showFlag: true,
            flagSize: 16),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: 'Phone Number',
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: GetIt.instance<ColorsDesign>().isDark
                ? GetIt.instance<ColorsDesign>().dark['label']
                : GetIt.instance<ColorsDesign>().light['label'],
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 241, 233, 233),
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: GetIt.instance<ColorsDesign>().isDark
                  ? GetIt.instance<ColorsDesign>().dark['focusedBorder'] ??
                      Colors.white
                  : GetIt.instance<ColorsDesign>().light['focusedBorder'] ??
                      Colors.black,
              width: 2.0,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: GetIt.instance<ColorsDesign>().isDark
              ? GetIt.instance<ColorsDesign>().dark["input"]
              : GetIt.instance<ColorsDesign>().light["input"],
          focusColor: GetIt.instance<ColorsDesign>().light["inputfoucs"],
        ),
      ),
    );
  }

  Widget _namefeild() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHeight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: FormFieldComponent(
        Namevalidate,
        GetIt.instance<SignUpFormController>().changeusername,
        "Name",
        GetIt.instance<ColorsDesign>().isDark
            ? GetIt.instance<ColorsDesign>().dark["input"]
            : GetIt.instance<ColorsDesign>().light["input"],
        GetIt.instance<ColorsDesign>().light["inputfoucs"],
        false,
        const Icon(Icons.person),
      ),
    );
  }

  String? Namevalidate(String? value) {
    bool result = value == null || value.length < 4 ? false : true;
    return result ? null : "Name must be at least 4 characters";
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
        GetIt.instance<SignUpFormController>().changeEmail,
        "Email",
        GetIt.instance<ColorsDesign>().isDark
            ? GetIt.instance<ColorsDesign>().dark["input"]
            : GetIt.instance<ColorsDesign>().light["input"],
        GetIt.instance<ColorsDesign>().light["inputfoucs"],
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
        GetIt.instance<SignUpFormController>().changePassword,
        "Password",
        GetIt.instance<ColorsDesign>().isDark
            ? GetIt.instance<ColorsDesign>().dark["input"]
            : GetIt.instance<ColorsDesign>().light["input"],
        GetIt.instance<ColorsDesign>().light["inputfoucs"],
        true,
        const Icon(Icons.security_sharp),
      ),
    );
  }

  String? _passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  Widget _confirmpasswordfeild() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHeight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: FormFieldComponent(
        _confirmPasswordValidate,
        GetIt.instance<SignUpFormController>().changecomfirmpassword,
        "Confirm Password",
        GetIt.instance<ColorsDesign>().isDark
            ? GetIt.instance<ColorsDesign>().dark["input"]
            : GetIt.instance<ColorsDesign>().light["input"],
        GetIt.instance<ColorsDesign>().light["inputfoucs"],
        true,
        const Icon(Icons.security_sharp),
      ),
    );
  }

  String? _confirmPasswordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != GetIt.instance<SignUpFormController>().password) {
      return 'Passwords do not match';
    }

    return null;
  }

  Widget _haveaccount() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
        top: _deviceHeight * 0.005,
        left: _deviceWidth * 0.07,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "already have account",
            style: TextStyle(
                fontSize: 16,
                color: GetIt.instance<ColorsDesign>().isDark
                    ? GetIt.instance<ColorsDesign>().dark["title"]
                    : GetIt.instance<ColorsDesign>().light["title"]),
          ),
          _login(),
        ],
      ),
    );
  }

  Widget _login() {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        "Login",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: GetIt.instance<ColorsDesign>().isDark
                ? GetIt.instance<ColorsDesign>().dark["title"]
                : GetIt.instance<ColorsDesign>().light["title"],
            color: GetIt.instance<ColorsDesign>().isDark
                ? GetIt.instance<ColorsDesign>().dark["title"]
                : GetIt.instance<ColorsDesign>().light["title"]),
      ),
    );
  }

  Widget _submit() {
    return buttonComponent(
      [_deviceWidth * 0.9, _deviceHeight * 0.05],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      "Sign UP",
      GetIt.instance<SignUpFormController>().onTap,
      GetIt.instance<ColorsDesign>().light["button"]!,
      20,
      GetIt.instance<ColorsDesign>().isDark
          ? GetIt.instance<ColorsDesign>().dark["buttontext"] ?? Colors.white
          : GetIt.instance<ColorsDesign>().light["buttontext"] ?? Colors.black,
      _context,
    );
  }

  Widget _or() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight * 0.02),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Or Sign Up with Social account",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: GetIt.instance<ColorsDesign>().isDark
                    ? GetIt.instance<ColorsDesign>().dark["title"]
                    : GetIt.instance<ColorsDesign>().light["title"]),
          ),
        ],
      ),
    );
  }

  Widget _socialsignup() {
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
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        alignment: Alignment.center,
        icon: Icon(
          size: _deviceHeight * 0.05,
          Icons.facebook,
          color: GetIt.instance<ColorsDesign>().isDark
            ? GetIt.instance<ColorsDesign>().dark["socilafb"]
            : GetIt.instance<ColorsDesign>().light["socilafb"],
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
        color: GetIt.instance<ColorsDesign>().isDark
            ? GetIt.instance<ColorsDesign>().dark["socilagooogle"]
            : GetIt.instance<ColorsDesign>().light["socilagooogle"],
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
