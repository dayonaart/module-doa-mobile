import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///pathAsset untuk gambar icon
///textLangkah untuk menjelaskan langkah berapa
///textdetail text penjelasan form
Widget headerForm(
  String pathAsset,
  String textLangkah,
  Widget textDetail,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
    child: Column(children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            // child: Image.asset(
            //   pathAsset,
            //   height: 48,
            //   width: 48,
            // ),
            child: SvgPicture.asset(
              pathAsset,
              height: 48,
              width: 48,
            ),
          ),
          Text(textLangkah, style: semibold14)
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Expanded(child: textDetail),
          ],
        ),
      ),
    ]),
  );
}
