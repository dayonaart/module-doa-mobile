import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

void htmlAllertDialog(BuildContext context, String text,
    bool barrierDismissible, Function onTap) {
  WidgetsBinding.instance?.addPostFrameCallback((_) async {
    showDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.1),
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 5,
                      right: 5,
                    ),
                    child: Column(
                      children: [
                        Html(
                          data: text,
                          style: {
                            "ul": Style(
                              color: Color(0xFF77767A),
                              fontSize: FontSize(14),
                              fontWeight: FontWeight.w500,
                            ),
                            "div": Style(
                              color: Color(0xFF77767A),
                              fontSize: FontSize(14),
                              fontWeight: FontWeight.w500,
                            ),
                            "li": Style(
                              color: Color(0xFF77767A),
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                "Ok, saya mengerti",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  });
}
