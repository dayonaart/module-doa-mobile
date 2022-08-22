import 'dart:io';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/TabunganController.dart';
import 'package:eform_modul/src/components/card-custom.dart';
import 'package:eform_modul/src/components/content-tabungan.dart';
import 'package:eform_modul/src/components/header-form.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/registrasi/register_nomor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TabunganIndonesia extends StatefulWidget {
  const TabunganIndonesia({Key? key}) : super(key: key);

  @override
  State<TabunganIndonesia> createState() => _TabunganIndonesiaState();
}

class _TabunganIndonesiaState extends State<TabunganIndonesia> with TickerProviderStateMixin {
  late TabController _tabController;
  TabunganController savingsController = Get.put(TabunganController());

  Future getIndexTabungan() async {
    // final preferences = await SharedPreferences.getInstance();
    if (savingsController.prefs == null) {
      savingsController.prefs = Get.find<DataController>().prefs;
    }
    savingsController.activeTabIndex = savingsController.prefs!.getInt('indexTabungan') ?? 0;
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: savingsController.activeTabIndex);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getIndexTabungan();
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  headerForm("assets/images/icons/card_icon.svg", "",
                      Text("Pilih jenis tabungan yang sesuai dengan kebutuhan Anda.")),
                  CustomCard(
                      stringInterest: penjelasanBungaTaplus,
                      stringAdditionalCost: penjelasanBiayaLainnyaTaplus,
                      stringFacility: penjelasanFasilitasTaplus,
                      stringDeposit: penjelasanSetoranTaplus,
                      title: "Taplus",
                      text1:
                          "Memberikan kemudahan, kenyamanan layanan dan banyak keuntungan untuk berbagai aktifitas perbankan Anda.",
                      // text2: "Limit transaksi sampai Rp 10 juta/hari",
                      description: "Setoran Awal Rp 250.000,-",
                      assetImage: AssetImage('assets/images/taplus.png'),
                      onTap: () {
                        data.activeTabIndex = 0;
                        data.saveTabungan();
                        Get.toNamed(Routes().taplus);
                      }),
                  CustomCard(
                      stringInterest: taplusMudaInterestDescription,
                      stringAdditionalCost: additionalCostTaplusMudaDescription,
                      stringFacility: taplusMudaFacilityDescription,
                      stringDeposit: taplusMudaDepositDescription,
                      title: "Taplus Muda",
                      text1:
                          "Produk tabungan yang diperuntukan bagi anak muda Indonesia mulai dari usia 17 hingga 35 tahun dengan biaya yang lebih rendah.",
                      // text2: "Limit transaksi sampai Rp 10 juta/hari",
                      description: "Setoran Awal Rp 100.000,-",
                      assetImage: AssetImage('assets/images/taplus_muda.png'),
                      onTap: () {
                        data.activeTabIndex = 1;
                        data.saveTabungan();
                        Get.toNamed(Routes().taplusmuda);
                      }),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: CustomCard(
                        stringInterest: taplusBussinessInterestDescription,
                        stringAdditionalCost: taplusBussinessAdditionalCostDescription,
                        stringFacility: taplusBussinessFacilityDescription,
                        stringDeposit: taplusBussinessDepositDescription,
                        title: "Taplus Bisnis",
                        text1:
                            "Diperuntukan bagi pelaku usaha yang dilengkapi dengan fitur dan fasilitas yang memberikan kemudahan dan fleksibilitas dalam mendukung transaksi bisnis.",
                        // text2: "Limit transaksi sampai Rp 50 juta/hari",
                        description: "Setoran Awal Rp 1.000.000,-",
                        assetImage: AssetImage('assets/images/taplus_bisnis.png'),
                        onTap: () {
                          data.activeTabIndex = 2;
                          data.saveTabungan();
                          Get.toNamed(Routes().taplusbisnis);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget tab(String text) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          fontSize: 14,
        ),
      ),
    );
  }

  // _buildTab({required String text, required Color color}) {
  //   return Container(
  //     alignment: Alignment.center,
  //     width: double.infinity,
  //     decoration: ShapeDecoration(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(10),
  //           topRight: Radius.circular(10),
  //         ),
  //       ),
  //       color: color,
  //     ),
  //     child: Text(text),
  //   );
  // }

  Widget tabTaplus(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            //penjelasan taplus
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 3, top: 10, right: 3),
              child: Html(
                data: penjelasanTaplus,
                style: {
                  "span": Style(color: const Color(0XFFD45D26), fontWeight: FontWeight.bold),
                },
              ),
            ),
            //penjelasan setoran taplus
            Container(
              color: const Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Html(
                data: penjelasanSetoranTaplus,
                style: {
                  "td": Style(padding: const EdgeInsets.only(right: 5, bottom: 15)),
                },
              ),
            ),
            //penjelasan fasilitas taplus
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
              child: Html(
                data: penjelasanFasilitasTaplus,
                style: {
                  "ul": Style(padding: const EdgeInsets.only(top: 10)),
                  "li": Style(
                    padding: const EdgeInsets.only(bottom: 5),
                  ),
                },
              ),
            ),
            //penjelasan bunga taplus
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Html(
                data: penjelasanBungaTaplus,
                style: {
                  "tr": Style(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                      right: 40,
                      left: 20,
                    ),
                  ),
                },
              ),
            ),
            if (Platform.isIOS)
              SizedBox(
                height: 50,
              ),
          ],
        ),
      ),
    );
  }

  Widget tabTaplusMUda(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            //penjelasan taplus muda
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 3, top: 10, right: 3),
              child: Html(
                data: taplusMudaDescription,
                style: {
                  "span": Style(color: const Color(0XFFD45D26), fontWeight: FontWeight.bold),
                },
              ),
            ),
            //penjelasan setoran taplus muda
            Container(
              color: const Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Html(
                data: taplusMudaDepositDescription,
                style: {
                  "td": Style(padding: const EdgeInsets.only(right: 5, bottom: 15)),
                },
              ),
            ),
            //penjelasan fasilitas taplus muda
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
              child: Html(
                data: taplusMudaFacilityDescription,
                style: {
                  "ul": Style(padding: const EdgeInsets.only(top: 10)),
                  "li": Style(
                    padding: const EdgeInsets.only(bottom: 5),
                  ),
                },
              ),
            ),
            //penjelasan bunga taplus muda
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Html(
                data: taplusMudaInterestDescription,
                style: {
                  "tr": Style(
                    padding: const EdgeInsets.only(bottom: 5, right: 40, left: 20),
                  ),
                },
              ),
            ),
            if (Platform.isIOS)
              SizedBox(
                height: 50,
              ),
          ],
        ),
      ),
    );
  }

  Widget tabTaplusBisnis(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            //penjelasan taplus bisnis
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 3, top: 10, right: 3),
              child: Html(
                data: taplusBussinessDescription,
                style: {
                  "span": Style(color: const Color(0XFFD45D26), fontWeight: FontWeight.bold),
                },
              ),
            ),
            //penjelasan setoran taplus bisnis
            Container(
              color: const Color(0xFFF5F5F5),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Html(
                data: taplusBussinessDepositDescription,
                style: {
                  "td": Style(padding: const EdgeInsets.only(right: 5, bottom: 15)),
                },
              ),
            ),
            //penjelasan fasilitas taplus bisnis
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: 10, top: 10, left: 10),
              child: Html(
                data: taplusBussinessFacilityDescription,
                style: {
                  "ul": Style(padding: const EdgeInsets.only(top: 10)),
                  "li": Style(
                    padding: const EdgeInsets.only(bottom: 5),
                  ),
                },
              ),
            ),
            //penjelasan bunga taplus bisnis
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Html(
                data: taplusBussinessInterestDescription,
                style: {
                  "tr": Style(
                    padding: const EdgeInsets.only(bottom: 5, right: 40, left: 20),
                  ),
                },
              ),
            ),
            if (Platform.isIOS)
              SizedBox(
                height: 50,
              ),
          ],
        ),
      ),
    );
  }
}
