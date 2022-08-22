// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  PopUp({
    Key? key,
    required this.content,
    this.radius = 6.0,
  }) : super(key: key);

  double radius;
  Widget content;

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius)),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width * 1,
        child: widget.content,
      ),
      insetPadding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
    );
  }
}
