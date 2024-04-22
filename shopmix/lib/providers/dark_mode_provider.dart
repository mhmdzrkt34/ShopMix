import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:shopmix/designs/colors_design.dart';

class darkModeProvider extends ChangeNotifier {



  bool isDark=false;

  void changeisDark(){
    GetIt.instance.get<ColorsDesign>().isDark=!isDark;
    isDark=!isDark;
    notifyListeners();
    
  }


}