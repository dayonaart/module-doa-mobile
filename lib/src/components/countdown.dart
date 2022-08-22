// ignore_for_file: must_be_immutable

import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Countdown extends AnimatedWidget {
  Countdown({
    Key? key,
    required this.animation,
    required this.isHide,
  }) : super(key: key, listenable: animation);
  Animation<int> animation;
  bool isHide;

  void reset() {
    isHide = !isHide;
  }

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    // print('animation.value  ${animation.value} ');
    // print('inMinutes ${clockTimer.inMinutes.toString()}');
    // print('inSeconds ${clockTimer.inSeconds.toString()}');
    // print(
    //     'inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    if (clockTimer.inMinutes.remainder(60).toString() == '0') {
      reset();
    }

    return isHide
        ? Text(timerText,
            style: labelText.copyWith(
              color: Color.fromRGBO(142, 142, 142, 1),
            ))
        : Text('');
  }
}
