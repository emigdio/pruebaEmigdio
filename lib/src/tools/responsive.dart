import 'package:flutter/material.dart';

class Responsive {
  
  late double _width, _height, _topPadding, _bottomPadding;

  double get width => _width;
  double get height => _height;
  double get topPadding => _topPadding;
  double get bottomPadding => _bottomPadding;

  static Responsive of(BuildContext context) => Responsive.of(context);

  Responsive(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _topPadding = MediaQuery.of(context).padding.top;
    _bottomPadding = MediaQuery.of(context).padding.bottom;
  }

  double hp(double percent) => _height * percent / 100;
  double wp(double percent) => _width * percent / 100;

}