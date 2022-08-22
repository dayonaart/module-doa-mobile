import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/theme_const.dart';

class CustomLoading {
  showLoading(String text) {
    EasyLoading.instance
      // ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = CustomThemeWidget.orangeButton
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      // ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false;
    EasyLoading.show(status: text);
  }

  dismissLoading() {
    EasyLoading.dismiss();
  }
}
