import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmix/designs/colors_design.dart';

class buttonComponent extends StatelessWidget {
  late List<double> _size, _padding, _margin;
  late String _title;
  late Function _toDoOnPress;
  late Color _backgroundColor;
  late double _borderRadius;
  late Color _fontColor;
  late BuildContext _context;
  buttonComponent(
    List<double> size,
    List<double> padding,
    List<double> margin, // Add margin parameter
    String title,
    Function toDoOnPress,
    Color bgcolor,
    double borderRadius,
    Color fontColor,
    BuildContext context,
  ) {
    _size = size;
    _padding = padding;
    _margin = margin;
    _title = title;
    _toDoOnPress = toDoOnPress;
    _backgroundColor = bgcolor;
    _borderRadius = borderRadius;
    _fontColor = fontColor;
    _context = context;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        _toDoOnPress(_context);
      },
      minWidth: _size[0],
      height: _size[1],
      padding: EdgeInsets.fromLTRB(
        _padding[0],
        _padding[1],
        _padding[2],
        _padding[3],
      ),
      color: _backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Text(
        _title,
        style: TextStyle(
          color: _fontColor,
        ),
      ),
    );
  }

  void getColor() {
    String label =
        GetIt.instance.get<ColorsDesign>().getLabelFromColor(_backgroundColor);
    changecolor(label, _backgroundColor);
    String label2 =
        GetIt.instance.get<ColorsDesign>().getLabelFromColor(_fontColor);
    changecolor(label2, _fontColor);
  }

  void changecolor(String label, Color color) {
    GetIt.instance.get<ColorsDesign>().isDark
        ? color = GetIt.instance.get<ColorsDesign>().dark[label]!
        : color = GetIt.instance.get<ColorsDesign>().light[label]!;
  }
}
