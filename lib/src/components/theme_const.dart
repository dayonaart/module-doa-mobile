import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
TextStyle blacktext = GoogleFonts.montserrat()
    .copyWith(fontWeight: FontWeight.bold, color: Colors.black);

TextStyle whiteText = GoogleFonts.montserrat()
    .copyWith(fontWeight: FontWeight.bold, color: Colors.white);

TextStyle blackRoboto = GoogleFonts.montserrat().copyWith(
    fontWeight: FontWeight.bold, color: Color(0xFF000000), height: 1.2);

TextStyle whiteRoboto = GoogleFonts.montserrat()
    .copyWith(fontWeight: FontWeight.bold, color: Colors.white);

TextStyle semibold14 = GoogleFonts.montserrat().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF333333),
    height: 2);

TextStyle semibold16 = GoogleFonts.montserrat().copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF333333),
    height: 1.25);

TextStyle semibold12 = GoogleFonts.montserrat().copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color(0xFF333333),
    height: 1.5);

TextStyle medium12 = GoogleFonts.montserrat().copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
    height: 1.5);

TextStyle bodyStyle = GoogleFonts.montserrat().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
    height: 2);

TextStyle infoStyle = GoogleFonts.montserrat().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF000000),
    height: 2);

TextStyle orangeText = GoogleFonts.montserrat().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFE55300),
    height: 2);

double defaultMargin = 24.0;

TextStyle CustomStyleForm = GoogleFonts.montserrat().copyWith(
    fontSize: 12, fontWeight: FontWeight.w300, color: Color(0xFF333333));
TextStyle CustomStyleFormGrey = GoogleFonts.montserrat().copyWith(
    fontSize: 12, fontWeight: FontWeight.w300, color: Color(0xFF8E8E8E));

class CustomThemeWidget {
  CustomThemeWidget._();

  static const Color mainWhite = Color(0xFFFAFAFA);
  static const Color mainOrange = Color(0xFFE55300);
  static const Color orangeButton = Color.fromRGBO(229, 83, 0, 1);
  static const Color loadingButton = Color(0xFF35363a);
  static const Color formOrange = Color(0xFFFFf7c13);
  static const Color formBorder = Color(0xFFE7E7E7);
  static const Color bungaBorder = Color(0xFF009092);

  static const Color mainGreen = Color(0xFF2C7381);
  static const Color mainDark = Color(0xFF121212);
  static const Color secondaryDark = Color(0xFF84858A);

  static const Color backgroundColorTop = const Color(0xFFECF1F3);
  static const Color backgroundColorMiddle = Color(0xFFEFF3DB);
  static const Color backgroundColorBottom = Color(0xFFF8F1B2);

  static const Color rectangleDottedBorder = Color(0xFF1BC1CE);
  static const Color rectangleBackground = Color(0xFFF1FEFF);
  static const Color rectangleTextColor = Color(0xFF1BC1CE);
  static const Color dividerColor = Color(0xFFE7E7E7);

  static const BoxDecoration mainBackgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        CustomThemeWidget.backgroundColorTop,
        CustomThemeWidget.backgroundColorMiddle,
        CustomThemeWidget.backgroundColorBottom
      ],
    ),
  );

  static const String poppins = 'Poppins';
  static const String montserrat = 'Montserrat';

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  static const TextStyle regularRedText = TextStyle(
    fontFamily: poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: mainOrange, // was lightText
  );

  static const TextStyle regularWhiteText = TextStyle(
    fontFamily: poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: mainWhite, // was lightText
  );

  static const TextStyle regularBlackText = TextStyle(
    fontFamily: poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: mainDark, // was darkText
  );

  static const TextStyle regularGrayText = TextStyle(
    fontFamily: poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: secondaryDark, // was darkText
  );

  static const TextStyle lightGreenText = TextStyle(
    fontFamily: poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: mainGreen, // was darkText
  );

  static const TextStyle lightGrayText = TextStyle(
    fontFamily: poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: secondaryDark, // was darkText
  );

  static const TextStyle regularTextField =
      TextStyle(fontFamily: poppins, fontWeight: FontWeight.w400, fontSize: 14);

  static const Color backgroundColorAppBar = Color(0xF1F1F1FF);
  static const Color contentDark = Color(0xFF005E6A);

  //Saran pembagian class
  //rename themewidget, karena ini bukanlah widget.
  //themeColor
  //themeText
  //themeClass (boxdecoration dkk)
  static Color orangeButtonHalfTransparent = Color(0xFFF15A23).withOpacity(0.3);
}

TextStyle appBarText = GoogleFonts.montserrat().copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: Color.fromRGBO(51, 51, 51, 1));

TextStyle buttonStyle = GoogleFonts.montserrat()
    .copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);

TextStyle buttonStyleOrange = GoogleFonts.montserrat().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: CustomThemeWidget.mainOrange);
