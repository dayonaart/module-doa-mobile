// ignore_for_file: prefer_const_constructors

import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

void mainAlertDialog(
    BuildContext context, List<InlineSpan> text, bool barrierDismissible, Function onTap) {
  WidgetsBinding.instance?.addPostFrameCallback((_) async {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          )),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: RichText(
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: text),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          onTap();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE55300),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: CustomThemeWidget.poppins,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  });
}
