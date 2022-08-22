import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataFileController.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/pemilihan-cabang-page/pemilihanCabangIndonesia_page.dart';
import 'package:eform_modul/src/views/pemilihan-cabang-page/pemilihanCabangLuar_page.dart';
import 'package:eform_modul/src/views/register/verification/phone_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:isolate_image_compress/isolate_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../components/button-ambil-foto.dart';
import '../../components/button.dart';
import '../../components/custom_body.dart';
import '../../components/custom_button_white.dart';
import '../../components/label-text.dart';
import '../../components/theme_const.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';

class DataFileListPage extends StatefulWidget {
  const DataFileListPage({Key? key}) : super(key: key);

  @override
  _DataFileListPageState createState() => _DataFileListPageState();
}

class _DataFileListPageState extends State<DataFileListPage> {
  late SharedPreferences prefs;

  DataFileController dataFileController = Get.put(DataFileController());
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    dataFileController.firstLoad();
  }

  Widget getRowPhoto(
      {required VoidCallback function, required List<String> base64List, bool isMultiple = false}) {
    return Column(
      children: [
        FutureBuilder(
            future: dataFileController.getCompressImageFromBase64(base64List),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                print("A");
                var bytes = snapshot.data as List;
                return Row(
                    children: bytes
                        .asMap()
                        .entries
                        .map((item) => new Flexible(
                                child: Column(
                              children: [
                                item.value,
                                CustomButtonWhiteWidgets(
                                  onPressed: !isMultiple
                                      ? function
                                      : () {
                                          item.key == 0
                                              ? dataFileController.startLiveness(context,
                                                  isOnlyLiveness: true)
                                              : dataFileController.goSelfieKTPCamera();
                                        },
                                  text: "Foto Ulang",
                                ),
                              ],
                            )))
                        .toList());
              } else {
                print("B");
                return Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<DataFileController>(
          builder: (Value) {
            return WillPopScope(
              onWillPop: () async {
                prefs = Get.find<DataController>().prefs;
                if (prefs.getString('indexPosisi') == '1') {
                  Get.off(() => PemilihanCabangIndonesiaPage(), transition: Transition.rightToLeft);
                } else {
                  Get.off(() => PemilihanCabangLuarPage(), transition: Transition.rightToLeft);
                }
                return true;
              },
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                child: Scaffold(
                  key: dataFileController.scaffoldKey,
                  appBar: AppBar(
                    leading: LeadingIcon(
                      context: context,
                      onPressed: () async {
                        prefs = Get.find<DataController>().prefs;
                        if (prefs.getString('indexPosisi') == '1') {
                          Get.off(() => PemilihanCabangIndonesiaPage(),
                              transition: Transition.rightToLeft);
                        } else {
                          Get.off(() => PemilihanCabangLuarPage(),
                              transition: Transition.rightToLeft);
                        }
                      },
                    ),
                    elevation: 1,
                    backgroundColor: const Color(0xFFEDF1F3),
                    iconTheme: const IconThemeData(color: Colors.black),
                    centerTitle: true,
                    title: Text(
                      "Upload Dokumen",
                      style: appBarText,
                    ),
                  ),
                  body: CustomBodyWidgets(
                    content: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                            bottom: 15.0,
                          ),
                          child: Text(
                            "Foto Wajah & KTP",
                            style: labelText,
                          ),
                        ),
                        dataFileController.isLivenessDone && dataFileController.isKtpDone
                            ? getRowPhoto(
                                function: () {
                                  dataFileController.startLiveness(context);
                                },
                                isMultiple: true,
                                base64List: [
                                  dataFileController.selfiePhoto!,
                                  dataFileController.idSelfiePhoto!
                                ],
                              )
                            : photoButton("Ambil Foto Wajah & KTP", context, () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        color: Color(0xFF5E5E5E).withOpacity(0.75),
                                        child: PopoutWrapContent(
                                            textTitle: '',
                                            button_radius: 4,
                                            content: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Image.asset(
                                                      "assets/images/simpanan-icon-info-selfie.png"),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Pastikan wajahmu terlihat jelas",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 10.0, horizontal: 20),
                                                    child: Text(
                                                      "Untuk proses verifikasi yang lebih baik, mohon dilakukan hal sebagai berikut:",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Color.fromRGBO(224, 224, 224, 0.3),
                                                    ),
                                                    child: Html(data: """
                      <ul style="font-weight: 400; font-size: 14px;">
                      <li>Berada pada ruangan dengan <b>pencahayaan cukup</b></li>
                      <li>Lepaskan aksesoris yang menutupi wajah <b>(kacamata, masker, topi, dll)</b></li>
                      <li>Pastikan foto yang Anda ambil sudah <b>fokus (tidak blur)</b></li>
                      </ul>
                      """),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            buttonText: 'Ok, saya mengerti',
                                            ontap: () {
                                              Get.back();
                                              dataFileController.startLiveness(context);
                                            }),
                                      );
                                    });
                              }),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Text(
                            "Tanda Tangan",
                            style: labelText,
                          ),
                        ),
                        dataFileController.isSignatureDone
                            ? getRowPhoto(
                                function: () {
                                  Get.toNamed(Routes().tandatangan)!.then(
                                      (val) => val ? dataFileController.checkFileDone() : null);
                                },
                                base64List: [dataFileController.signaturePhoto!],
                              )
                            : photoButton("Foto tanda tangan diatas kertas putih", context, () {
                                Get.toNamed(Routes().tandatangan)!
                                    .then((val) => val ? dataFileController.checkFileDone() : null);
                              }),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Text(
                            "e-KTP",
                            style: labelText,
                          ),
                        ),
                        dataFileController.isNpwpDone
                            ? getRowPhoto(
                                function: () {
                                  Get.toNamed(Routes().ktpnpwp)!.then(
                                      (val) => val ? dataFileController.checkFileDone() : null);
                                },
                                base64List: [dataFileController.idPhoto!],
                              )
                            : photoButton("Ambil Foto e-KTP", context, () {
                                Get.toNamed(Routes().ktpnpwp)!
                                    .then((val) => val ? dataFileController.checkFileDone() : null);
                              }),
                        SizedBox(height: 100),
                      ],
                    ),
                    pathHeaderIcons: "assets/images/icons/card_icon.svg",
                    headerTextStep: 'Langkah 6 dari 6',
                    headerTextDetail: RichText(
                      text: TextSpan(
                        style: infoStyle,
                        children: [
                          TextSpan(
                            text: "Lengkapi dokumen berikut dengan cara ",
                            style: labelText,
                          ),
                          TextSpan(
                              text: " mengambil foto",
                              style: labelText.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(text: "  dari masing-masing dokumen."),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: ButtonCostum(
                    width: double.infinity,
                    // backgroundColor: !(isLivenessDone && isKtpDone && isSignatureDone)? CustomThemeWidget.orangeButton.withOpacity(0.3) : CustomThemeWidget.orangeButton,
                    // borderColor: !(isLivenessDone && isKtpDone && isSignatureDone)? CustomThemeWidget.orangeButton.withOpacity(0) : CustomThemeWidget.orangeButton,
                    ontap: !(dataFileController.isLivenessDone &&
                            dataFileController.isKtpDone &&
                            dataFileController.isSignatureDone)
                        ? null
                        : () {
                            Get.find<DataController>().prefs.setString('errorCode', '');
                            Get.offAll(() => PhoneVerificationScreen(),
                                transition: Transition.rightToLeft);
                          },
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  getRowMenu({
    required String icon,
    required String text,
    required bool isDone,
    required VoidCallback function,
  }) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 15.0,
          ),
          child: isDone
              ? Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF235E6B),
                  size: 30,
                )
              : Image.asset(
                  icon,
                  width: 30,
                ),
        ),
        Expanded(
          child: InkWell(
            onTap: function,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Color(0XFFCFD4D9),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/simpanan-camera-icon.png",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFE55300),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  buttonNavigasi() {
    return GetBuilder<DataFileController>(
      builder: (Value) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: Wrap(
            children: [
              Container(
                color: Color(0xFFEDF1F3),
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFE55300), // background
                              onPrimary: Colors.white, // foreground
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              if (!Value.isKtpDone) {
                                getAlert(
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          child: Column(
                                            children: [
                                              Transform.rotate(
                                                angle: 180 * pi / 180,
                                                child: Icon(
                                                  Icons.info,
                                                  color: CustomThemeWidget.orangeButton,
                                                  size: 50,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Mohon Maaf",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(
                                                  "Foto Selfie dengan KTP tidak boleh kosong",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ButtonCostum(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20,
                                          ),
                                          ontap: () {
                                            Get.back();
                                          },
                                          text: "OK, saya mengerti",
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (!Value.isNpwpDone) {
                                getAlert(
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          child: Column(
                                            children: [
                                              Transform.rotate(
                                                angle: 180 * pi / 180,
                                                child: Icon(
                                                  Icons.info,
                                                  color: CustomThemeWidget.orangeButton,
                                                  size: 50,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Mohon Maaf",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(
                                                  "Foto KTP dan NPWP tidak boleh kosong",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ButtonCostum(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20,
                                          ),
                                          ontap: () {
                                            Get.back();
                                          },
                                          text: "OK, saya mengerti",
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (!Value.isSignatureDone) {
                                getAlert(
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          child: Column(
                                            children: [
                                              Transform.rotate(
                                                angle: 180 * pi / 180,
                                                child: Icon(
                                                  Icons.info,
                                                  color: CustomThemeWidget.orangeButton,
                                                  size: 50,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Mohon Maaf",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(
                                                  "Foto Tanda Tangan tidak boleh kosong",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ButtonCostum(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20,
                                          ),
                                          ontap: () {
                                            Get.back();
                                          },
                                          text: "OK, saya mengerti",
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (Value.captchaController.text != Value.randomString) {
                                getAlert(
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          child: Column(
                                            children: [
                                              Transform.rotate(
                                                angle: 180 * pi / 180,
                                                child: Icon(
                                                  Icons.info,
                                                  color: CustomThemeWidget.orangeButton,
                                                  size: 50,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Mohon Maaf",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(
                                                  "Captcha belum Benar",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ButtonCostum(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20,
                                          ),
                                          ontap: () {
                                            Get.back();

                                            Value.randomString = Value.getRandomString(5);
                                            Value.update();
                                          },
                                          text: "OK, saya mengerti",
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                Get.offAll(() => PhoneVerificationScreen(),
                                    transition: Transition.rightToLeft);
                              }
                            },
                            child: Text(
                              'Selanjutnya',
                              style: blacktext.copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getAlert(Widget content) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.1),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          )),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: content,
        );
      },
    );
  }
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  final String randomString;

  MyPainter(this.randomString);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 36, 106, 161)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.35),
        Offset(size.width, size.height * 0.35),
        [Color(0xff201e1e), Color(0xffffffff)],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.7037200);
    path0.lineTo(size.width * 0.0004778, size.height * 0.7022600);

    canvas.drawPath(path0, paint0);

    final textPainter = TextPainter(
      text: TextSpan(
        text: randomString,
        style: GoogleFonts.specialElite().copyWith(
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 158, 158, 158),
              ),
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 8.0,
                color: Color.fromARGB(255, 158, 158, 158),
              ),
            ],
            color: Color.fromARGB(255, 39, 12, 189),
            fontSize: 40),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final yCenter = (size.height - textPainter.height) / 3;
    final offset = Offset(20, yCenter);
    textPainter.paint(canvas, offset);

    Paint paint1 = Paint()
      ..color = Color.fromARGB(255, 37, 37, 37)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.94;

    Path path1 = Path();
    path1.moveTo(2, 2);
    path1.lineTo(size.width * 0.99, size.height * 0.6);

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
