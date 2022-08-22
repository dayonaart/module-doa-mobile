import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'theme_const.dart';

///ButtonCostum ini memiliki atribute
/// text, width, height, radius, isTextWithIcon, icon, margin, backgroundColor, textColor
///
/// untuk button yang memiliki icon bisa set value isTextWithIcon menjadi true yang secara defaultnya false
class ButtonCostum extends StatelessWidget {
  final Function()? ontap;
  final String text;
  final double width;
  final double height;
  final double radius;
  final bool isTextWithIcon;
  final Color borderColor;
  final IconData? icon;
  final EdgeInsets? margin;
  final Color backgroundColor;
  final double? bottompadding;
  final Color textColor;
  final double padding;
  final bool isDisable;
  final TextAlign? textAlign;
  const ButtonCostum({
    Key? key,
    required this.ontap,
    this.width = 340,
    this.height = 40,
    this.text = 'Lanjut',
    this.margin = const EdgeInsets.only(left: 0.0, right: 0.0),
    this.radius = 5.0,
    this.backgroundColor = CustomThemeWidget.orangeButton,
    this.textColor = Colors.white,
    this.isTextWithIcon = false,
    this.icon,
    this.bottompadding,
    this.borderColor = CustomThemeWidget.orangeButton,
    this.padding = 0,
    this.isDisable = false,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GestureDetector(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Container(
              margin: EdgeInsets.only(bottom: bottompadding ?? 40),
              child: Center(
                child: isTextWithIcon
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Center(
                              child: Text(
                            text,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                        ],
                      )
                    // Penambahan parameter font size 12 px
                    : Text(
                        text,
                        textAlign: textAlign,
                        style: whiteRoboto.copyWith(
                            color: textColor, fontSize: 16),
                      ),
              ),
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ontap == null
                          ? Color.fromARGB(255, 253, 183, 142)
                          : borderColor),
                  color: ontap == null
                      ? Color.fromARGB(255, 253, 183, 142)
                      : backgroundColor,
                  borderRadius: BorderRadius.circular(radius)),
            ),
          ),
        ),
      ),
    );
  }
}

// class ButtonCostum extends StatelessWidget {
//   const ButtonCostum(
//       {Key? key,
//       required this.onPressed,
//       this.text = 'Lanjut',
//       this.radius = 5})
//       : super(key: key);

//   final VoidCallback? onPressed;
//   final double radius;
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           minimumSize: Size(double.infinity, 50),
//           primary: themeWidget.orangeButton,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(radius))),
//       child: Text(text),
//       onPressed: onPressed,
//     );
//   }
// }
