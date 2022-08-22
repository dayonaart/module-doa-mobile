import 'package:eform_modul/src/components/dropdown.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_html/html_parser.dart';

/// items = [], readonly = false, maxLines = 1, params = '1', label = ''
class CustomDropDownWidgets extends StatefulWidget {
  final TextEditingController controller;

  final bool readOnly;
  final int maxLines;
  final String? Function(String?)? validator;
  final String label;
  final Color borderColor;
  final AutovalidateMode autovalidateMode;
  final VoidCallback onTap;
  CustomDropDownWidgets(
      {Key? key,
      required this.controller,
      this.maxLines = 1,
      this.readOnly = true,
      required this.label,
      this.borderColor = CustomThemeWidget.formBorder,
      required this.onTap,
      this.validator,
      this.autovalidateMode = AutovalidateMode.disabled})
      : super(key: key);

  @override
  State<CustomDropDownWidgets> createState() => _CustomDropDownWidgetsState();
}

class _CustomDropDownWidgetsState extends State<CustomDropDownWidgets> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(left: 8, bottom: 20),
        errorMaxLines: 3,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: CustomThemeWidget.formBorder),
        ),
        suffixIconConstraints: BoxConstraints(maxHeight: 20),
        suffixIcon: SizedBox(
          width: 50,
          child: Transform.rotate(
            angle: -90 * math.pi / 180,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 10,

              // Add this
              color: CustomThemeWidget.formOrange, // Add this
            ),
          ),
        ),
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor, // or any other color
        ),
      ),
      style: CustomStyleForm,
      controller: widget.controller,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      readOnly: true,
      inputFormatters: [UpperCaseTextField()],
    );
  }
}
