import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';

class SignupDarkprovider extends ChangeNotifier {
  bool isDark = GetIt.instance<ColorsDesignkazem>().isDark;
  void changeMode() {
    GetIt.instance<ColorsDesignkazem>().isDark =
        !GetIt.instance<ColorsDesignkazem>().isDark;
    isDark = GetIt.instance<ColorsDesignkazem>().isDark;
    notifyListeners();
  }
}
