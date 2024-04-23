import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/buttonComponent/button_component.dart';
import 'package:shopmix/components/formfieldComponent/form_field_component.dart';
import 'package:shopmix/components/labelComponent/label_component.dart';
import 'package:shopmix/controllers/formsControllers/login_form_controller.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/login_model_view.dart';

class LoginView extends StatelessWidget {
  late double _deviceWidth;
  late double _deviceHeight;
  late double _deviceTopPadding;
  @override
  Widget build(BuildContext context) {
    GetIt.instance.get<LoginZaraketFormController>().putContextValue(context);
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceTopPadding=MediaQuery.of(context).padding.top;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<LoginModelView>())],
    child: Scaffold(
     
      appBar: AppBar(),
      body: SafeArea(child: SingleChildScrollView(child: SizedBox(width: _deviceWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [FormContainer(),forgetpassword(), LoginButton(),socialLoginlabel()],)),)),

    ),);

  }
  Widget FormContainer(){
    return Form(
      key: GetIt.instance.get<LoginZaraketFormController>().loginFormKey,
      child: Column(children: [EmailFormField(),PasswordFormField()],));
  }

  Widget EmailFormField(){
    return FormFieldComponent([0,_deviceWidth*0.8],
     [0,0,0,7],
      [7,0,7,0],

       "Email",
        GetIt.instance.get<ColorsDesign>().light[0],
         0,
           GetIt.instance.get<ColorsDesign>().light[1],
            20,
            GetIt.instance.get<LoginZaraketFormController>().changeEmail,
            GetIt.instance.get<LoginZaraketFormController>().validators[0]
             );
  }
    Widget PasswordFormField(){
    return FormFieldComponent([0,_deviceWidth*0.8],
     [0,0,0,7],
      [7,0,7,0],
       "Password",
        GetIt.instance.get<ColorsDesign>().light[0],
         0,
           GetIt.instance.get<ColorsDesign>().light[1],
            20,
                        GetIt.instance.get<LoginZaraketFormController>().changePassword,
            GetIt.instance.get<LoginZaraketFormController>().validators[1]
            );
  }
  Widget LoginButton(){

    return buttonComponent([0,_deviceWidth*0.8],
     [0,0,0,0],
      [0,0,0,0],
       "Login", 
       GetIt.instance.get<LoginZaraketFormController>().onpress,
         GetIt.instance.get<ColorsDesign>().light[2],
            20,
             20,GetIt.instance.get<ColorsDesign>().light[0]);
  }

  Widget forgetpassword(){
    return
    
     SizedBox(
      width: _deviceWidth*0.8,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          LabelComponent([0,0,0,0], [0,0,0,0], "Forgot your password?",GetIt.instance.get<ColorsDesign>().light[1],20, forgetYourPaswordPress),
        ],
      ));

  }

  Widget socialLoginlabel(){
    return LabelComponent([0,0,0,0], [0,0,0,0], "Or login with social account",GetIt.instance.get<ColorsDesign>().light[1],20, emptyFunction);
  }



  void forgetYourPaswordPress(){
    print("hey");
   
    

  }

  void emptyFunction(){

  }
}