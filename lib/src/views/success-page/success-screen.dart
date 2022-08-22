// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:eform_modul/BusinessLogic/Registrasi/AcknowledgementController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/CreateMbankController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/form-decoration.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../components/label-text.dart';
import '../../components/leading.dart';
import '../syarat-dan-ketentuan/syarat-dan-ketentuan.dart';

class SuccessScreen extends StatefulWidget {
  // final String username;
  // final String email;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

CreateMbankController createMbankController = Get.put(CreateMbankController());

class _SuccessScreenState extends State<SuccessScreen> {
  Widget rowtext(String deskripsi, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            deskripsi,
            style: blackRoboto.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
          ),

          // Spacer(),
          Text(
            value,
            style: blackRoboto.copyWith(
                fontSize: 12, fontWeight: FontWeight.normal, color: CustomThemeWidget.mainOrange),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            child: ButtonCostum(
              ontap: () {
                // Get.find<DataController>().prefs.clear;
                Get.find<AcknowledgementController>().openMBank();
                // exit(0);
              },
              text: 'Aktivasi BNI Mobile Banking',
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromRGBO(51, 51, 51, 1)),
            elevation: 0,
            backgroundColor: CustomThemeWidget.backgroundColorTop,
            centerTitle: true,
            title:
                Text("Selesai", overflow: TextOverflow.ellipsis, maxLines: 1, style: appBar_Text),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomBodyWidgets(
                  headerMarginBottom: 8,
                  content: Column(
                    children: [
                      Text(
                        'Terima kasih atas kepercayaan Anda telah melakukan registrasi BNI Mobile Banking dengan detail sebagai berikut. ',
                        style: labelText.copyWith(),
                      ),
                      SizedBox(height: 24),
                      Divider(
                        thickness: 1.5,
                        color: Color(0xffE7E7E7),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      rowtext(
                          'Tanggal Registrasi', DateFormat('dd MMMM yyyy').format(DateTime.now())),
                      rowtext('Waktu Registrasi', DateFormat('HH:mm:ss').format(DateTime.now())),
                      rowtext('User ID ', createMbankController.inputUserIdController.text),
                      rowtext('Email', createMbankController.email),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pastikan registrasi terjadi atas inisiatif Anda. Mohon simpan dan jaga kerahasiaan data BNI Mobile Banking Anda. Untuk informasi lebih lanjut hubungi BNI Call 1500046.',
                              style: labelText.copyWith(fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: infoStyle,
                                children: [
                                  TextSpan(
                                    text: "Salam Hangat\n",
                                    style: labelText,
                                  ),
                                  TextSpan(
                                      text: "PT Bank Negara Indonesia (Persero), Tbk ",
                                      style: labelText.copyWith(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Divider(
                              thickness: 1.5,
                              color: Color(0xffE7E7E7),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pathHeaderIcons: "assets/images/icons/success-icon.svg",
                  headerTextDetail: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: infoStyle,
                      children: [
                        TextSpan(
                            text: "Pendaftaran BNI Mobile Banking Anda berhasil!",
                            style: labelText.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
