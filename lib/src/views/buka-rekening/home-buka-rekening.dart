import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/views/buka-rekening/pemilihan-rekening.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BusinessLogic/Registrasi/AcknowledgementController.dart';
import '../../../BusinessLogic/Registrasi/AlamatController.dart';
import '../../../BusinessLogic/Registrasi/CabangController.dart';
import '../../../BusinessLogic/Registrasi/CreateMbankController.dart';
import '../../../BusinessLogic/Registrasi/CreatePinController.dart';
import '../../../BusinessLogic/Registrasi/DataController.dart';
import '../../../BusinessLogic/Registrasi/DataDiri2Controller.dart';
import '../../../BusinessLogic/Registrasi/DataFileController.dart';
import '../../../BusinessLogic/Registrasi/OtpController.dart';
import '../../../BusinessLogic/Registrasi/PekerjaanController.dart';
import '../../../BusinessLogic/Registrasi/PemilikDanaController.dart';
import '../../../BusinessLogic/Registrasi/PhoneVerifyController.dart';
import '../../../BusinessLogic/Registrasi/RegistrasiNomorController.dart';
import '../../../BusinessLogic/Registrasi/WorkDetailController.dart';
import '../../components/button.dart';
import '../../components/leading.dart';
import '../../components/theme_const.dart';
import '../../utility/Routes.dart';

class HomeBukaRekening extends StatefulWidget {
  const HomeBukaRekening({Key? key}) : super(key: key);

  @override
  State<HomeBukaRekening> createState() => _HomeBukaRekeningState();
}

class _HomeBukaRekeningState extends State<HomeBukaRekening> {
  @override
  void initState() {
    getAllController();
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
        Get.off(() => PilihRekeningPage(), transition: Transition.rightToLeft);
        return true;
      },
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Scaffold(
          appBar: AppBar(
            leading: LeadingIcon(
              context: context,
              onPressed: () {
                Get.off(() => PilihRekeningPage(), transition: Transition.rightToLeft);
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomeScreeen(),
                //   ),
                // );
              },
            ),
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
            headerTextDetail: Column(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Pembukaan Tabungan Digital BNI hanya berlaku untuk Nasabah Baru\n\n",
                      style: semibold16,
                    ),
                    TextSpan(
                        text:
                            "Jika Anda sudah menjadi nasabah BNI, silakan lakukan Aktivasi BNI Mobile Banking (Android atau iOS) dan lakukan penambahan tabungan melalui menu Rekeningku atau kunjungi Kantor Cabang BNI terdekat.\n\n\n",
                        style: infoStyle),
                    TextSpan(
                      text: "Untuk kelancaran pembukaan tabungan, siapkan dahulu:\n",
                      style: semibold16,
                    ),
                  ]),
                ),
                listedText("e-KTP (wajib) & NPWP (bila ada)"),
                listedText("Pulsa / paket data untuk pengiriman OTP"),
                listedText("Kertas & alat tulis untuk foto tanda tangan")
              ],
            ),
            content: Text(''),
          ),
          floatingActionButton: ButtonCostum(
            isDisable: false,
            width: double.infinity,
            ontap: () {
              Get.find<DataController>().checkTime(context);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  Widget listedText(String deskripsi) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
          ),
          child: Icon(Icons.circle, size: 4),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(deskripsi, style: infoStyle)],
          ),
        ),
      ],
    );
  }
}
