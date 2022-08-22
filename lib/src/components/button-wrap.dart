import 'package:flutter/material.dart';
import 'theme_const.dart';

///ButtonCostum ini memiliki atribute
/// text, width, height, radius, isTextWithIcon, icon, margin, backgroundColor, textColor
///
/// untuk button yang memiliki icon bisa set value isTextWithIcon menjadi true yang secara defaultnya false
class ButtonCustomWrap extends StatefulWidget {
  final Function()? ontap;
  final String text;
  final double radius;
  final bool isTextWithIcon;

  final IconData? icon;
  final EdgeInsets? margin;
  final Color backgroundColor;
  final Color textColor;
  final String styleButton;
  const ButtonCustomWrap({
    Key? key,
    required this.ontap,
    this.text = 'daftar',
    this.margin = const EdgeInsets.only(left: 20.0, right: 20.0),
    this.radius = 4,
    this.backgroundColor = CustomThemeWidget.orangeButton,
    this.textColor = Colors.white,
    this.isTextWithIcon = false,
    this.icon,
    this.styleButton = "1",
  }) : super(key: key);

  @override
  State<ButtonCustomWrap> createState() => _ButtonCustomWrapState();
}

class _ButtonCustomWrapState extends State<ButtonCustomWrap> {
  //STYLE 1: Button primary
  //STYLE 2: Button secondary
  //STYLE 3: Button disabled
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.ontap,
        child: Container(
          width: double.infinity,
          margin: widget.margin,
          decoration: BoxDecoration(
            color: widget.styleButton == "1"
                ? widget.backgroundColor
                : widget.styleButton == "2"
                    ? Colors.white
                    : CustomThemeWidget.orangeButtonHalfTransparent,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: CustomThemeWidget.orangeButton),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 14,
              ),
              Text(widget.text,
                  textAlign: TextAlign.center,
                  style: buttonStyle.copyWith(
                      color: widget.styleButton == "1"
                          ? Colors.white
                          : widget.styleButton == "2"
                              ? CustomThemeWidget.orangeButton
                              : Colors.white)),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ));
  }
}
