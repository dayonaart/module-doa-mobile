import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../components/theme_const.dart';

class TextFormCustom extends StatefulWidget {
  const TextFormCustom({
    Key? key,
    this.hintText = '',
    this.minimalChar = 5,
    this.maximalChar = 40,
    this.withSymbol = false,
    this.keyboardType = TextInputType.text,
    required this.textController,
    this.itCantEmpty = true,
    this.idFormField = 1,
    required this.keyFormField,
    this.statusTextForm = false,
    this.isCodePost = false,
  }) : super(key: key);

  final String hintText;
  final int minimalChar, maximalChar, idFormField;
  final bool withSymbol, itCantEmpty, statusTextForm, isCodePost;
  final ObjectKey keyFormField;
  final TextInputType keyboardType;

  final TextEditingController? textController;

  @override
  State<TextFormCustom> createState() => _TextFormCustomState();
}

class _TextFormCustomState extends State<TextFormCustom> {
  String? validate(String? value) {
    // if (value!.isEmpty) {
    //   if (widget.itCantEmpty == true) {
    //     return "tidak boleh kosong";
    //   } else {
    //     return null;
    //   }
    // }
    if (widget.statusTextForm == true) {
      if (value!.isEmpty) {
        return "tidak boleh kosong";
      }
    }

    if (value!.length < widget.minimalChar && value != '') {
      return "minimal ${widget.minimalChar} karakter";
    }

    if (value.length > widget.maximalChar && value != '') {
      return "maksimal ${widget.maximalChar} karakter";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.keyFormField,
      controller: widget.textController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        UpperCaseTextField(),
        widget.keyboardType == TextInputType.phone
            ? FilteringTextInputFormatter.allow(RegExp('[0-9]'))
            : FilteringTextInputFormatter.allow(
                RegExp('[A-Za-z0-9\.\\-\\/\,\\s]'))
      ],
      keyboardType: widget.keyboardType,
      style: blackRoboto.copyWith(
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      validator: validate,
    );
  }
}

class UpperCaseTextField extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
