import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/deskripsi-kartu.dart';
import 'package:eform_modul/src/components/header-form.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/tipe-tabungan/tabungan-indonesia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/label-text.dart';

class CardTypeBisnis extends StatefulWidget {
  const CardTypeBisnis({Key? key}) : super(key: key);

  @override
  State<CardTypeBisnis> createState() => _CardTypeBisnisState();
}

class _CardTypeBisnisState extends State<CardTypeBisnis> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => TabunganIndonesia(), transition: Transition.rightToLeft);
        return true;
      },
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: LeadingIcon(
              context: context,
              onPressed: () async {
                Get.off(() => TabunganIndonesia(), transition: Transition.rightToLeft);
              },
            ),
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Pilih Kartu Debit",
              style: appBarText,
            ),
            backgroundColor: CustomThemeWidget.backgroundColorTop,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                headerForm(
                  "assets/images/icons/card_icon.svg",
                  "",
                  Text("Pilih jenis kartu debit yang sesuai dengan kebutuhan Anda.",
                      style: infoStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Image.asset(
                    "assets/images/simpanan-kartu-debit-gold.jpg",
                    height: 168,
                    width: 264,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Kartu Gold Debit BNI", style: semibold16),
                SizedBox(
                  height: 48,
                ),
                cardBiayaKartu(),
                SizedBox(
                  height: 8,
                ),
                deskripsiKartuGold(),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ButtonCostum(
            text: "Pilih",
            ontap: (() {
              Get.toNamed(Routes().datadiri);
            }),
          ),
        ),
      ),
    );
  }

  Widget cardBiayaKartu() {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Biaya pengelolaan kartu",
                    style: greyMonserrat.copyWith(fontWeight: FontWeight.w500)),
                Text(
                  "per-bulan",
                  style: greyMonserrat,
                )
              ],
            ),
            Text(
              "Rp7.500",
              style: greyMonserrat.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
