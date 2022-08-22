import 'dart:convert';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/main.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/header-form.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/data-file/data-file-list.dart';
import 'package:eform_modul/src/views/pemilik-dana-page/pemilikdana_screen.dart';
import 'package:eform_modul/src/views/register/work/work_detail/work_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/button.dart';
import '../../components/form-decoration.dart';

class PemilihanCabangLuarPage extends StatefulWidget {
  const PemilihanCabangLuarPage({Key? key}) : super(key: key);

  @override
  State<PemilihanCabangLuarPage> createState() => _PemilihanCabangLuarPageState();
}

class _PemilihanCabangLuarPageState extends State<PemilihanCabangLuarPage> {
  DataController dataController = Get.put(DataController());
  List _biCodeList = [];
  List _officeList = [];

  Future<void> readBIJson() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/bi.json');
    final data = await json.decode(response);
    setState(() {
      _biCodeList = data["bi"];
    });
  }

  Future<void> readOfficeJson() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kantor_cabang.json');
    final data = await json.decode(response);
    setState(() {
      _officeList = data["regions"];
    });
  }

  void jsonReader() {
    readBIJson();
    readOfficeJson();
  }

  @override
  void initState() {
    super.initState();
    jsonReader();
  }

  @override
  Widget build(BuildContext context) {
    // jsonReader();
    Widget indicator() {
      return Container(
          color: const Color(0xFFEDF1F3),
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            nav_icon(context, 5),
            Container(margin: const EdgeInsets.only(bottom: 10)),
            Center(
              child: SizedBox(
                width: 80,
                child: Image.asset('assets/images/simpanan-form-icon.png'),
              ),
            )
          ]));
    }

    return WillPopScope(
      onWillPop: () async {
        final prefs = Get.find<DataController>().prefs;
        if (prefs.getString('detailPekerjaan') == '') {
          Get.off(() => PemilikDanaScreeen(), transition: Transition.rightToLeft);
        } else {
          Get.off(() => WorkDetailScreen(), transition: Transition.rightToLeft);
        }
        return true;
      },
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: CustomThemeWidget.backgroundColorTop,
            centerTitle: true,
            leading: LeadingIcon(
              context: context,
              onPressed: () async {
                final prefs = Get.find<DataController>().prefs;
                if (prefs.getString('detailPekerjaan') == '') {
                  Get.off(() => PemilikDanaScreeen(), transition: Transition.rightToLeft);
                } else {
                  Get.off(() => WorkDetailScreen(), transition: Transition.rightToLeft);
                }
              },
            ),
            title: Text("Pemilihan Cabang BNI",
                overflow: TextOverflow.ellipsis, maxLines: 1, style: appBar_Text),
          ),
          body: CustomBodyWidgets(
            content: Container(),
            pathHeaderIcons: "assets/images/icons/book_icon.svg",
            headerTextStep: 'Langkah 5 dari 6',
            headerTextDetail: RichText(
              text: TextSpan(
                style: infoStyle,
                children: [
                  TextSpan(
                    text: "Rekening Anda ",
                    style: infoStyle,
                  ),
                  TextSpan(
                      text: "terdaftar di BNI Kantor Cabang Jakarta Pusat.", style: semibold14),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ButtonCostum(
            margin: EdgeInsets.only(bottom: 20),
            text: 'Lanjut',
            ontap: () {
              setState(() {
                List biCodeListFilter =
                    _biCodeList.where((x) => x['SANDI_BNI'].contains("259")).toList();
                List officeListFilter =
                    _officeList.where((x) => x['kodeoutlet'].contains("259")).toList();
                Future saveSharedPref() async {
                  final preferences = dataController.prefs;
                  preferences.setString('sandiBI', biCodeListFilter[0]["SANDI_BI"].toString());
                  preferences.setString('kotaBI', biCodeListFilter[0]["KOTA"].toString());
                  preferences.setString('namaOutlet', officeListFilter[0]["namaoutlet"].toString());
                  preferences.setString('kodeOutlet', officeListFilter[0]["kodeoutlet"].toString());
                  preferences.setString('alamatOutlet', officeListFilter[0]["alamat"].toString());

                  print(biCodeListFilter);
                  print(biCodeListFilter[0]["SANDI_BI"].toString());
                  print(biCodeListFilter[0]["KOTA"].toString());
                  print(officeListFilter);
                  print(officeListFilter[0]["namaoutlet"].toString());
                  print(officeListFilter[0]["kodeoutlet"].toString());
                  print(officeListFilter[0]["alamat"].toString());

                  Get.toNamed(Routes().datafile);
                }

                saveSharedPref();
              });
            },
          ),
        ),
      ),
    );
  }
}
