import 'dart:async';

import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utility/Routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Get.toNamed(Routes().pilihRekening);
    });
    return Scaffold(
      body: _splashScreen(),
    );
  }

  Container _splashScreen() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background-splash.png"),
            fit: BoxFit.fill,
            alignment: AlignmentDirectional.topCenter),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: Image.asset(
                "assets/images/bni-logo-splash.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "Melayani Negeri Kebanggaan Bangsa",
            style: TextStyle(
                color: Color(0xFF006685),
                fontSize: 12.93,
                fontWeight: FontWeight.w600,
                fontFamily: CustomThemeWidget.montserrat),
          ),
          Spacer(),
          Center(
            child: Image.asset(
              "assets/images/ojk-logo.png",
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "PT Bank Negara Indonesia (Persero) Tbk. terdaftar dan diawasi \n oleh Otoritas Jasa Keuangan (OJK) serta merupakan peserta \n penjaminan Lembaga Penjamin Simpanan (LPS).\n\n Hak Cipta © 2022 BNI Mobile Banking",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: CustomThemeWidget.montserrat),
          ),
          SizedBox(
            height: 37,
          ),
          // Stack(children: [
          //   Center(
          //     child: Image.asset(
          //       "assets/images/wave.png",
          //     ),
          //   ),
          //   Positioned(
          //     bottom: 15,
          //     right: 23,
          //     child: Text(
          //       "V 5.X",
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontFamily: CustomThemeWidget.montserrat,
          //           fontSize: 10,
          //           fontWeight: FontWeight.w500),
          //     ),
          //   )
          // ]),
        ],
      ),
    );
  }
}
