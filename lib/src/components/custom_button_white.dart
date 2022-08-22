import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

class CustomButtonWhiteWidgets extends StatelessWidget {
  const CustomButtonWhiteWidgets(
      {Key? key,
      this.text = "isi text",
      required this.onPressed,
      this.radius = 5,
      this.elevation = 0})
      : super(key: key);
  final String text;
  final double radius;
  final VoidCallback onPressed;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          side: BorderSide(width: 2, color: CustomThemeWidget.mainOrange)),
      onPressed: onPressed,
      child: Text(
        text,
        style: buttonStyleOrange,
      ),
    );
  }
}
