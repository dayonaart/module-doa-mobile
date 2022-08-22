import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;

  MainButton(this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColorLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),
      // ignore: deprecated_member_use
      child: Text(label, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
