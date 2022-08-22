import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/TabunganController.dart';
import 'package:eform_modul/src/components/card-custom.dart';
import 'package:eform_modul/src/components/content-tabungan.dart';
import 'package:eform_modul/src/components/header-form.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/registrasi/register_nomor_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/leading.dart';
import '../../models/jenis-tabungan.dart';
import '../../utility/Routes.dart';

class TabunganLuarIndonesia extends StatefulWidget {
  const TabunganLuarIndonesia({Key? key}) : super(key: key);

  @override
  State<TabunganLuarIndonesia> createState() => _TabunganLuarIndonesiaState();
}

SharedPreferences? prefs;

class _TabunganLuarIndonesiaState extends State<TabunganLuarIndonesia> {
  TabunganController savingsController = Get.put(TabunganController());

  @override
  void initState() {
    super.initState();
    if (savingsController.prefs == null) {
      savingsController.prefs = Get.find<DataController>().prefs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabunganController>(builder: (data) {
      return WillPopScope(
        onWillPop: () async {
          Get.off(() => RegisterNomorPageAlt(), transition: Transition.rightToLeft);
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
                    Get.off(() => RegisterNomorPageAlt(), transition: Transition.rightToLeft);
                  },
                ),
                elevation: 1,
                backgroundColor: CustomThemeWidget.backgroundColorTop,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                title: Text("Pilih Jenis Tabungan", style: appBar_Text)),
            body: Column(
              children: [
                headerForm("assets/images/icons/card_icon.svg", "",
                    Text("Pilih jenis tabungan yang sesuai dengan kebutuhan Anda.")),
                CustomCard(
                    stringInterest: taplusDiasporaInterestDescription,
                    stringAdditionalCost: taplusDiasporaAdditionalCostDescription,
                    stringFacility: taplusDiasporaFacilityDescription,
                    stringDeposit: taplusDiasporaDepositDescription,
                    title: "Taplus Diaspora",
                    text1:
                        "BNI Taplus Diaspora memberikan kemudahan, kenyamanan layanan dan banyak keuntungan untuk berbagai aktivitas transaksi perbankan Anda.",
                    // text2: "Limit transaksi sampai Rp 10 juta/hari",
                    description: "Setoran Awal Rp 500.000,-",
                    assetImage: AssetImage('assets/images/taplus.png'),
                    onTap: () {
                      data.saveTabunganDiaspora();
                      Get.toNamed(Routes().diaspora);
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
