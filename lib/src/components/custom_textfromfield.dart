import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFromField extends StatefulWidget {
  const CustomTextFromField({
    Key? key,
    required this.controller,
    this.borderColor = CustomThemeWidget.formBorder,
    this.keyboardType = TextInputType.text,
    this.inputFormater,
    this.validator,
    this.onChanged,
    this.textAlign = TextAlign.left,
    this.contentPaddingLeft = 8,
    this.readOnly = false,
    this.autovalidateMode,
    this.isColorGrey = false,
    this.filled = false,
    this.fillcolor = const Color(0xffF8F8F8),
  }) : super(key: key);
  final TextEditingController controller;
  final Color borderColor;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormater;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final double contentPaddingLeft;
  final TextAlign textAlign;
  final bool readOnly;
  final AutovalidateMode? autovalidateMode;
  final bool isColorGrey;
  final Color fillcolor;
  final bool filled;

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      textAlign: widget.textAlign,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormater,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        fillColor: widget.fillcolor,
        filled: widget.filled,
        isDense: true,
        contentPadding: EdgeInsets.only(left: widget.contentPaddingLeft, bottom: 20),
        errorMaxLines: 5,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: CustomThemeWidget.formBorder),
        ),
      ),
      style: widget.isColorGrey ? CustomStyleFormGrey : CustomStyleForm,
    );
  }
}
