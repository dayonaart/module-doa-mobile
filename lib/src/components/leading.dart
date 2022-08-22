// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeadingIcon extends StatefulWidget {
  LeadingIcon({Key? key, required this.context, required this.onPressed})
      : super(key: key);
  BuildContext context;
  VoidCallback onPressed;
  @override
  State<LeadingIcon> createState() => _LeadingIconState();
}

class _LeadingIconState extends State<LeadingIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Container(
          margin: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            "assets/images/icons/back_icon.svg",
            width: 6,
            height: 14,
          )),
    );
  }
}
