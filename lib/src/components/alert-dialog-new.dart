// ignore_for_file: prefer_const_constructors

import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

class Popout extends StatefulWidget {
  // final double height;
  final String textTitle;
  final Widget content;
  final String buttonText;
  final double radius;
  final Function() ontap;
  const Popout(
      {Key? key,
      // this.height = 215,
      required this.textTitle,
      required this.content,
      required this.buttonText,
      this.radius = 20,
      required this.ontap})
      : super(key: key);

  @override
  State<Popout> createState() => _PopoutState();
}

class _PopoutState extends State<Popout> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Container(
          width: double.infinity,
          // height: widget.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                widget.textTitle,
                textAlign: TextAlign.center,
                style: blackRoboto.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              widget.content,
              SizedBox(
                height: 10,
              ),
              ButtonCostum(
                ontap: widget.ontap,
                text: widget.buttonText,
                radius: widget.radius,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        ));
  }
}
