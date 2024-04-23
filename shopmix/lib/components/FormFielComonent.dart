import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design_kazem.dart';

class FormFieldComponent extends StatelessWidget {
  final String? Function(String?)? _validate;
  final Function(String?)? _onSave;
  final String? _label;
  final Icon? _icon;
  final Color? color;
  final Color? focuscolor;
  final bool ispassword;

  FormFieldComponent(this._validate, this._onSave, this._label, this.color,
      this.focuscolor, this.ispassword,
      [this._icon]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: ispassword,
      decoration: InputDecoration(
        labelText: _label,
        prefixIcon: _icon,
        labelStyle: TextStyle(
          fontSize: 20.0,
          color: GetIt.instance<ColorsDesignkazem>().isDark
              ? GetIt.instance<ColorsDesignkazem>().dark['label']
              : GetIt.instance<ColorsDesignkazem>().light['label'],
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
            color: GetIt.instance<ColorsDesignkazem>().isDark
                ? GetIt.instance<ColorsDesignkazem>().dark['focusedBorder'] ??
                    Colors.white
                : GetIt.instance<ColorsDesignkazem>().light['focusedBorder'] ??
                    Colors.black,
            // Color.fromARGB(255, 170, 169, 169),
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
        fillColor: color,
        focusColor: focuscolor,
      ),
      onSaved: (value) {
        _onSave!(value);
      },
      validator: (value) {
        return _validate!(value);
      },
    );
  }
}
