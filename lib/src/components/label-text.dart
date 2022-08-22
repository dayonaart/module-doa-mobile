import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//label style - sam
TextStyle labelText = blacktext.copyWith(fontWeight: FontWeight.w500, fontSize: 14, height: 2);
TextStyle labelTextBlue = blacktext.copyWith(
    height: 1.5, fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff005E6A));
TextStyle labelTextBlueBold = blacktext.copyWith(
    height: 1.5, fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff005E6A));
TextStyle errorTextRed =
    blacktext.copyWith(fontSize: 12, height: 1.5, fontWeight: FontWeight.w600, color: Colors.red);

TextStyle greyMonserrat = GoogleFonts.montserrat().copyWith(
    fontSize: 14, height: 2, fontWeight: FontWeight.w600, color: Color.fromRGBO(85, 85, 85, 1));

//appBar style - sam
TextStyle appBar_Text = blacktext.copyWith(
    fontWeight: FontWeight.w600, fontSize: 17, color: Color.fromRGBO(51, 51, 51, 1));
TextStyle headerContentText = blacktext.copyWith(fontWeight: FontWeight.w400, fontSize: 14);

TextStyle MediumBoldGreyText = blacktext.copyWith(
    height: 1.2, fontWeight: FontWeight.w600, fontSize: 16, color: Color.fromRGBO(51, 51, 51, 1));

TextStyle PopUpTitle = blacktext.copyWith(
    height: 1.2, fontWeight: FontWeight.w600, fontSize: 16, color: Color.fromRGBO(51, 51, 51, 1));

class StackDialog {
  final Function()? ontap;
  final String firstText;
  final String boldText;
  final String endText;
  final String buttonText;
  final double radius;
  final double? btnbottompadding;
  final BuildContext context;

  const StackDialog(
      {Key? key,
      required this.ontap,
      required this.firstText,
      required this.boldText,
      required this.endText,
      required this.buttonText,
      this.btnbottompadding,
      this.radius = 4.0,
      required this.context});

  @override
  Stack show() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
              padding: EdgeInsets.only(bottom: 0),
              alignment: Alignment.bottomCenter,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: firstText,
                          style: blacktext.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color.fromRGBO(51, 51, 51, 1)),
                          children: [
                            TextSpan(
                                text: boldText,
                                style: blacktext.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color.fromRGBO(51, 51, 51, 1))),
                            TextSpan(
                                text: endText,
                                style: blacktext.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromRGBO(51, 51, 51, 1))),
                          ]),
                    )),
                ButtonCostum(
                  ontap: ontap,
                  bottompadding: btnbottompadding,
                  text: buttonText,
                  radius: radius,
                  margin: EdgeInsets.only(left: 0, right: 0),
                )
              ]),
            ),
          ],
        )
      ],
    );
  }
}
