import 'package:flutter/material.dart';

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
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: _label,
        prefixIcon: _icon,
        labelStyle: const TextStyle(
          fontSize: 20.0,
          color: Color(0xFF9B9B9B),
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
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 170, 169, 169),
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
