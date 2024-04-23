import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  double _width, _height, _size;
  Color? _color;
  logo(this._height, this._width, this._color, this._size);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [logoContainer(), title()],
    );
  }

  Widget logoContainer() {
    return Container(
      child: Image.asset(
        'assets/images/logo.png',
        width: _width,
        height: _height,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget title() {
    return Text(
      "Shop Mix",
      style: TextStyle(color: _color ?? Colors.black, fontSize: _size),
    );
  }
}
