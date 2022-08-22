import 'dart:io';

import 'package:eform_modul/src/components/custom_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/theme_const.dart';
import '../../utility/Routes.dart';

class PilihRekeningPage extends StatefulWidget {
  const PilihRekeningPage({Key? key}) : super(key: key);

  @override
  State<PilihRekeningPage> createState() => _PilihRekeningPageState();
}

class _PilihRekeningPageState extends State<PilihRekeningPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: CustomThemeWidget.backgroundColorTop,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text("Buka Rekening", style: appBarText),
        ),
        body: CustomBodyWidgets(
            headerMarginBottom: 32,
            pathHeaderIcons: "assets/images/icons/book_icon.svg",
            isWithIconHeader: true,
            headerTextDetail: RichText(
              text: TextSpan(style: infoStyle, children: [
                TextSpan(text: "Mulai Sekarang!\n\n", style: semibold16),
                TextSpan(
                    text:
                        "Nikmati segala kemudahan bertransaksi dengan produk tabungan maupun kartu kredit BNI\n",
                    style: infoStyle),
                TextSpan(text: "#GakPakeNanti", style: semibold14),
              ]),
            ),
            content: Column(
              children: [
                GestureDetector(
                  child: Center(
                    child: Container(
                      height: 240,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFE7E7E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Buka Rekening BNI",
                              style: semibold14.copyWith(
                                color: Color(0xFF005E6A),
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Image.asset(
                              "assets/images/simpanan-kartu-debit-silver.png",
                              height: 160,
                              width: 251,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes().homeBukaRekening);
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  child: Center(
                    child: Container(
                      height: 240,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFE7E7E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            "Ajukan Kartu Kredit BNI",
                            style: semibold14.copyWith(
                              color: Color(0xFF005E6A),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Image.asset(
                              "assets/images/simpanan-kartu-debit-platinum.png",
                              height: 160,
                              width: 251,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  onTap: () async {
                    _launchURL();
                  },
                )
              ],
            )),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://applycreditcard.bni.co.id/ccmbanking';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
