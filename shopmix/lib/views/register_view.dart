import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/buttonComponent/button_component.dart';
import 'package:shopmix/components/formfieldComponent/form_field_component.dart';
import 'package:shopmix/components/labelComponent/label_component.dart';

import 'package:shopmix/controllers/formsControllers/register_form_controller.dart';
import 'package:shopmix/designs/colors_design.dart';

import 'package:shopmix/modelViews/register_model_view.dart';

class RegisterView extends StatelessWidget {
  late double _deviceWidth;
  late double _deviceHeight;
  late double _deviceTopPadding;
  @override
  Widget build(BuildContext context) {
    GetIt.instance.get<RegisterFormController>().putContextValue(context);
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceTopPadding=MediaQuery.of(context).padding.top;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<RegisterModeView>())],
    child: Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: SingleChildScrollView(child: SizedBox(width: _deviceWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [FormContainer(),alreadyHaveAnAccount(), RegisterButton(),socialSighnUpLabel()],)),)),

    ),);

  }
  Widget FormContainer(){
    return Form(
      key: GetIt.instance.get<RegisterFormController>().registerFormKey,
      child: Column(children: [NameFormField(),EmailFormField(),PasswordFormField()],));
  }

  Widget EmailFormField(){
    return FormFieldComponent([0,_deviceWidth*0.8],
     [0,0,0,7],
      [7,0,0,7],
       "Email",
        GetIt.instance.get<ColorsDesign>().light[0],
         0,
           GetIt.instance.get<ColorsDesign>().light[1],
            20,
                                    GetIt.instance.get<RegisterFormController>().changeEmail,
            GetIt.instance.get<RegisterFormController>().validators[0]
            );
  }
    Widget PasswordFormField(){
    return FormFieldComponent([0,_deviceWidth*0.8],
     [0,0,0,7],
      [7,0,0,7],
       "Password",
        GetIt.instance.get<ColorsDesign>().light[0],
         0,
           GetIt.instance.get<ColorsDesign>().light[1],
            20,
                                    GetIt.instance.get<RegisterFormController>().changePassword,
            GetIt.instance.get<RegisterFormController>().validators[1]
            );
  }
     Widget NameFormField(){
    return FormFieldComponent([0,_deviceWidth*0.8],
     [0,0,0,7],
      [7,0,0,7],
       "Name",
        GetIt.instance.get<ColorsDesign>().light[0],
         0,
           GetIt.instance.get<ColorsDesign>().light[1],
            20,
                                    GetIt.instance.get<RegisterFormController>().changeName,
            GetIt.instance.get<RegisterFormController>().validators[2]
             );
  }

  Widget RegisterButton(){

    return buttonComponent([0,_deviceWidth*0.8],
     [0,0,0,0],
      [0,0,0,0],
       "SIGN UP", 
       GetIt.instance.get<RegisterFormController>().onpress,
         GetIt.instance.get<ColorsDesign>().light[2],
            20,
             20,GetIt.instance.get<ColorsDesign>().light[0]);
  }

  Widget alreadyHaveAnAccount(){
    return
    
     SizedBox(
      width: _deviceWidth*0.8,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          LabelComponent([0,0,0,0], [0,0,0,0], "Already have an account?",GetIt.instance.get<ColorsDesign>().light[1],20, alreadyHaveAnAccountPress),
        ],
      ));

  }

  Widget socialSighnUpLabel(){
    return LabelComponent([0,0,0,0], [0,0,0,0], "Or sign up with social account",GetIt.instance.get<ColorsDesign>().light[1],20, emptyFunction);
  }



  void alreadyHaveAnAccountPress(){
     Navigator.pushNamed(GetIt.instance.get<RegisterFormController>().getFormPageContext(), "/login");

  }

  void emptyFunction(){

  }
}