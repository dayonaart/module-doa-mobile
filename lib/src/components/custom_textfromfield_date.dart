import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomTextFromFieldDate extends StatefulWidget {
  const CustomTextFromFieldDate({
    Key? key,
    required this.controller,
    this.borderColor = CustomThemeWidget.formBorder,
    this.keyboardType = TextInputType.text,
    this.inputFormater,
    this.validator,
    this.onChanged,
    this.initialDate,
    this.autovalidateMode,
    this.hintText,
  }) : super(key: key);
  final TextEditingController controller;
  final Color borderColor;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormater;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final initialDate;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;

  @override
  State<CustomTextFromFieldDate> createState() => _CustomTextFromFieldDateState();
}

class _CustomTextFromFieldDateState extends State<CustomTextFromFieldDate> {
  var initialDate;

  @override
  void initState() {
    super.initState();
    initialDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40,
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormater,
        validator: widget.validator,
        onChanged: widget.onChanged,
        autovalidateMode: widget.autovalidateMode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: CustomThemeWidget.formBorder),
          ),
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor, // or any other color
          ),
          hintText: widget.hintText,
        ),
        onTap: () async {
          DateTime now = DateTime.now();
          await showDatePicker(
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            context: context,
            initialDate: //textTanggal.text.isEmpty
                initialDate,
            //  : tanggal,
            firstDate: DateTime(now.year - 80, now.month, now.day),
            lastDate: DateTime(now.year - 17, now.month, now.day),
          ).then((pickedDate) {
            setState(() {
              if (pickedDate != null) {
                // tanggal = pickedDate;
                widget.controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                initialDate = pickedDate;
              } else {}
            });
          });
        },
        style: CustomStyleForm,
      ),
    );
  }
}
