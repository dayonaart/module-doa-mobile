import 'package:flutter/material.dart';
import 'theme_const.dart';

PreferredSizeWidget globalAppBar(String judul) {
  return AppBar(
    elevation: 0,
    backgroundColor: CustomThemeWidget.backgroundColorAppBar,
    centerTitle: true,
    title: Text(
      judul,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: appBarText,
    ),
  );
}
