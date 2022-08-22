import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

import 'button-wrap.dart';

class PopoutWrapContent extends StatefulWidget {
  final String textTitle;
  final Widget content;
  final String buttonText;
  final double button_radius;
  final double popup_radius;
  final Function() ontap;
  const PopoutWrapContent(
      {Key? key,
      required this.textTitle,
      required this.content,
      required this.buttonText,
      this.button_radius = 20,
      this.popup_radius = 5,
      required this.ontap})
      : super(key: key);

  @override
  State<PopoutWrapContent> createState() => _PopoutWrapContentState();
}

class _PopoutWrapContentState extends State<PopoutWrapContent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.popup_radius))),
        insetPadding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.textTitle != "") ...[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.textTitle,
                    textAlign: TextAlign.center,
                    style: blacktext.copyWith(fontSize: 18),
                  ),
                ],
                widget.content,
                SizedBox(
                  height: 24,
                ),
                ButtonCustomWrap(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  ontap: widget.ontap,
                  text: widget.buttonText,
                  radius: widget.button_radius,
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ));
  }
}
