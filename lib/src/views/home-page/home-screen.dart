import 'dart:io';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:flutter/material.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../BusinessLogic/Registrasi/AcknowledgementController.dart';
import '../../../BusinessLogic/Registrasi/AlamatController.dart';
import '../../../BusinessLogic/Registrasi/CabangController.dart';
import '../../../BusinessLogic/Registrasi/CreateMbankController.dart';
import '../../../BusinessLogic/Registrasi/CreatePinController.dart';
import '../../../BusinessLogic/Registrasi/DataDiri2Controller.dart';
import '../../../BusinessLogic/Registrasi/DataFileController.dart';
import '../../../BusinessLogic/Registrasi/OtpController.dart';
import '../../../BusinessLogic/Registrasi/PekerjaanController.dart';
import '../../../BusinessLogic/Registrasi/PemilikDanaController.dart';
import '../../../BusinessLogic/Registrasi/PhoneVerifyController.dart';
import '../../../BusinessLogic/Registrasi/RegistrasiNomorController.dart';
import '../../../BusinessLogic/Registrasi/WorkDetailController.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreeen> {
  @override
  void initState() {
    print('Selesai');
  }

  getAllController() async {
    Get.put(DataController());
    Get.put(CabangController());
    Get.put(OtpController());
    Get.put(AcknowledgementController());
    Get.put(CreatePinController());
    Get.put(PhoneVerifyController());
    Get.put(CreateMbankController());
    Get.put(RegistrasiNomorController());
    Get.put(DataFileController());
    Get.put(PerkerjaanController());
    Get.put(PemilikDanaController());
    Get.put(WorkDetailController());
    Get.put(DataDiri2Controller());
    Get.put(AlamatController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/simpanan-bg-1.png'), fit: BoxFit.cover)),
              child: Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Image.asset('assets/images/simpanan-logo.png'),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Selamat datang di\n\n Layanan Pembukaan Rekening BNI\n\n #GakPakeRibet',
                      textAlign: TextAlign.center,
                      style: CustomThemeWidget.regularBlackText.copyWith(fontSize: 18),
                    ),
                    GetBuilder<DataController>(builder: (value) {
                      return GestureDetector(
                        onTap: () {
                          Get.find<DataController>().checkProgress(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.20,
                              top: MediaQuery.of(context).size.height * 0.4,
                              right: MediaQuery.of(context).size.width * 0.20),
                          height: 40,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            'Daftar',
                            style: whiteText.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(229, 83, 0, 1)),
                        ),
                      );
                    }),
                  ])))),
    );
  }
}

class TimeOut extends StatefulWidget {
  const TimeOut({Key? key}) : super(key: key);

  @override
  State<TimeOut> createState() => _TimeOutState();
}

class _TimeOutState extends State<TimeOut> {
  @override
  Widget build(BuildContext context) {
    return PopoutWrapContent(
        textTitle: '',
        button_radius: 4,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset('assets/images/icons/time_icon.svg'),
            ),
            SizedBox(
              height: 8,
            ),
            Text('Mohon Maaf', style: PopUpTitle),
            SizedBox(
              height: 12,
            ),
            Text(
              'Fitur pembukaan rekening hanya tersedia pada pukul 01.00 - 23.00 WIB. Silakan mencoba kembali pada waktu yang sudah ditentukan.',
              style: infoStyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
        buttonText: 'Ok, saya Mengerti',
        ontap: () {
          Get.back();
          // Navigator.of(context).pop();
        });
  }
}
