import 'package:dotted_border/dotted_border.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///text : penjelasan button ///ontap: ontap listener
Widget photoButton(String text, BuildContext context, void Function()? ontap) {
  return GestureDetector(
    child: Container(
      height: 168,
      width: MediaQuery.of(context).size.width * 0.9,
      color: CustomThemeWidget.rectangleBackground,
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: CustomThemeWidget.rectangleDottedBorder,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/camera-logo.png",
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                text,
                style: buttonStyle.copyWith(color: CustomThemeWidget.rectangleTextColor),
              ),
            ],
          ),
        ),
      ),
    ),
    onTap: ontap,
  );
}

TextStyle buttonStyle = GoogleFonts.montserrat()
    .copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);
