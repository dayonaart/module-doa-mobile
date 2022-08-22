import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
InputDecoration mainInputDecoration(String placeHolder, double vPadding, double hPadding) {
  return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(),
      hintText: placeHolder,
      hintStyle: CustomThemeWidget.regularTextField,
      contentPadding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding));
}
