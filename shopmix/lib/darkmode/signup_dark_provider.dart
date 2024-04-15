import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';

class SignupDarkprovider extends ChangeNotifier {
  bool isDark = GetIt.instance<ColorsDesign>().isDark;
  void changeMode() {
    GetIt.instance<ColorsDesign>().isDark =
        !GetIt.instance<ColorsDesign>().isDark;
    isDark = GetIt.instance<ColorsDesign>().isDark;
    notifyListeners();
  }
}
