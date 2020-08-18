import 'package:flutter/material.dart';

class ConstantData {
  static final _obj = ConstantData._internal();
  ConstantData._internal();
  factory ConstantData() {
    return _obj;
  }

  final url = 'https://fontyback.clicktopass.com';
  final Color red = Color(0xffE0454B);
  final Color gray  = Color(0xffF2F2F2);
  final Color yellow  = Color(0xffFFD877);
  final Color black = Color(0xff383838);
}
