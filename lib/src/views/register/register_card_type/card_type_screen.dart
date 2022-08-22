import 'package:carousel_slider/carousel_slider.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/deskripsi-kartu.dart';
import 'package:eform_modul/src/components/header-form.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/register/register_card_type/card_type_prefs.dart';
import 'package:eform_modul/src/views/tipe-tabungan/tabungan-indonesia.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/label-text.dart';

// ## Get Kota bin
// preferences.getString('bin');
// ## Get Kota cardType
// preferences.getString('cardType');
// ## Get Kota namaKartu
// preferences.getString('namaKartu');

class CardTypeScreen extends StatelessWidget {
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
            child: const CaraouselWithListWidgets(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ButtonCostum(
            text: "Pilih",
            ontap: (() {
              try {
                SharedPreferences prefs = Get.find<DataController>().prefs;

                CardTypePrefs cardTypePrefs = CardTypePrefs.instance;
                cardTypePrefs.setDefaultCardTypePrefs(prefs);
                // cardTypePrefs.removePrefsCardType();
                cardTypePrefs.getCardTypePrefs(prefs);

                Get.toNamed(Routes().datadiri);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "terjadi kesalahan silahkan coba lagi",
                  style: blackRoboto.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                )));
              }
            }),
          ),
        ),
      ),
    );
  }
}

class CaraouselWithListWidgets extends StatefulWidget {
  const CaraouselWithListWidgets({Key? key}) : super(key: key);

  @override
  State<CaraouselWithListWidgets> createState() => _CaraouselWithListWidgetsState();
}

class _CaraouselWithListWidgetsState extends State<CaraouselWithListWidgets> {
  SharedPreferences? prefs;
  final CarouselController _controller = CarouselController();
  final cardTypePrefs = CardTypePrefs.instance;
  List<Widget> listKartu = [
    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8.0),
    //     image: const DecorationImage(
    //       image: AssetImage(
    //         "assets/images/simpanan-kartu-debit-silver.png",
    //       ),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // ),
    // Container(
    //   margin: const EdgeInsets.all(6.0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8.0),
    //     image: const DecorationImage(
    //       image: AssetImage("assets/images/simpanan-kartu-debit-batik-air.png"),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // ),
    Image.asset(
      "assets/images/simpanan-kartu-debit-silver.png",
      height: 168,
      width: 264,
    ),
    Image.asset(
      "assets/images/simpanan-kartu-debit-batik-air.png",
      height: 168,
      width: 264,
    ),
  ];

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    initAll();
  }

  @override
  void initState() {
    initPrefs();

    super.initState();
  }

  initAll() {
    cardTypePrefs.getCardTypePrefs(prefs!);
    if (CardTypePrefs.indexValue == null) {
    } else if (CardTypePrefs.indexValue != null || CardTypePrefs.indexValue!.isNotEmpty) {
      _controller.animateToPage(int.parse(CardTypePrefs.indexValue.toString()));
      // currentIndex = int.parse(CardTypePrefs.indexValue.toString());
      setState(() {});
    }
  }

  int currentIndex = 0;
  int indexAwal = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headerForm(
          "assets/images/icons/card_icon.svg",
          "",
          Text("Pilih jenis kartu debit yang sesuai dengan kebutuhan Anda.", style: infoStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: CarouselSlider(
            carouselController: _controller,
            items: listKartu,
            options: CarouselOptions(
              onPageChanged: ((index, reason) {
                setState(() {
                  currentIndex = index;
                  indexAwal = index;
                  if (index == 0) {
                    cardTypePrefs.setCardTypePrefs(
                        "13", "1", "BNI Card Silver Virtual", prefs!, index.toString());
                  }
                  if (index == 1) {
                    cardTypePrefs.setCardTypePrefs(
                        "54", "3", "Kartu Debit BNI Batik Air Virtual", prefs!, index.toString());
                  }
                });
              }),
              initialPage: currentIndex,
              height: MediaQuery.of(context).size.width * 0.5,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        currentIndex == 0
            ? Text("Kartu Silver Debit BNI", style: semibold16)
            : Text("Kartu Platinum Debit BNI", style: semibold16),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: currentIndex == 0 ? Color(0xFFF15A23) : Color(0xFFFCDBCF),
                        // border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: currentIndex == 1 ? Color(0xFFF15A23) : Color(0xFFFCDBCF),
                        // border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        cardBiayaKartu(),
        SizedBox(
          height: 8,
        ),
        currentIndex == 0 ? deskripsiKartuSilver() : deskripsiKartuBatik()
      ],
    );
  }

  Widget cardBiayaKartu() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      height: 64,
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
                Text("per-bulan", style: greyMonserrat)
              ],
            ),
            currentIndex == 0
                ? Text("Rp4.000", style: greyMonserrat.copyWith(fontSize: 16))
                : Text("Rp10.000", style: greyMonserrat.copyWith(fontSize: 15))
          ],
        ),
      ),
    );
  }
}
