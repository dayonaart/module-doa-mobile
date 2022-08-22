import 'dart:io';

import 'package:eform_modul/src/components/content-tabungan.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.title,
      required this.text1,
      required this.description,
      required this.assetImage,
      required this.stringDeposit,
      required this.stringAdditionalCost,
      required this.stringFacility,
      required this.stringInterest,
      this.buttonText = "Detail",
      required this.onTap})
      : super(key: key);
  final String title;
  final String text1;
  final String description;
  final String buttonText;
  final AssetImage assetImage;
  final String stringDeposit;
  final String stringAdditionalCost;
  final String stringFacility;
  final String stringInterest;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: assetImage, fit: BoxFit.fill)),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        title,
                        style: whiteText.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(text1,
                              textAlign: TextAlign.start,
                              style: whiteText.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            description,
                            style: whiteText.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          Container(
                            // color: Colors.red,
                            child: TextButton(
                              onPressed: () async => await detailTapPlusDialog(title),
                              child: Text(
                                buttonText,
                                style:
                                    whiteText.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // List<String> detailTapPlusHtml(String title) {
  //   switch (title) {
  //     case "Taplus":
  //       return [
  //         penjelasanSetoranTaplus,
  //         penjelasanFasilitasTaplus,
  //         penjelasanBungaTaplus,
  //       ];
  //     case "Taplus Muda":
  //       return [
  //         penjelasanSetoranTaplusMuda,
  //         penjelasanFasilitasTaplusMuda,
  //         penjelasanBungaTaplusMuda
  //       ];
  //     case "Taplus Bisnis":
  //       return [
  //         penjelasanSetoranTaplusBisnis,
  //         penjelasanFasilitasTaplusBisnis,
  //         penjelasanBungaTaplusBisnis
  //       ];
  //     case "Taplus Diaspora":
  //       return [
  //         penjelasanSetoranTaplusDiaspora,
  //         penjelasanFasilitasTaplusDiaspora,
  //         penjelasanBungaTaplusDiaspora
  //       ];
  //     default:
  //       return [];
  //   }
  // }
  Widget rowtext(String deskripsi, String value, int jenis) {
    return Column(
      children: [
        SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 4,
              child: Text(
                deskripsi,
                style: jenis == 1 ? semibold12 : medium12,
                textAlign: TextAlign.start,
                maxLines: 2,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: jenis == 1
                    ? semibold12
                    : semibold12.copyWith(
                        fontSize: 12,
                        color: CustomThemeWidget.formOrange,
                        fontWeight: FontWeight.w600),
                textAlign: jenis == 1 ? TextAlign.center : TextAlign.end,
                maxLines: 2,
              ),
            )
          ],
        ),
        if (jenis == 1) ...[
          SizedBox(
            height: 4,
          ),
          Divider(thickness: 2),
        ] else ...[
          SizedBox(
            height: 10,
          ),
        ],
      ],
    );
  }

  Widget listedText(String deskripsi) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
            children: [
              Text(deskripsi, style: medium12),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> detailTapPlusDialog(String title) async {
    print(title.toLowerCase());
    await Get.dialog(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: semibold16),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 24,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ),
              ),
              Divider(thickness: 2),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        if (title.toLowerCase() == "taplus") ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowtext("Setoran Awal", "Rp250.000,-", 2),
                              rowtext("Minimum Setoran Selanjutnya", "Rp5.000,-", 2),
                              rowtext("Minimum Saldo rata-rata per bulan", "Rp150.000,-", 2),
                              rowtext("Denda dibawah Saldo Minimum", "Rp5.000,-", 2),
                              rowtext("Biaya Pengelolaan Rekening Per bulan", "Rp11.000,-", 2),
                              rowtext("Biaya Penggantian Buku", "Rp1.500,-", 2),
                              rowtext("Biaya Penutupan Rekening", "Rp10.000,-", 2),
                              rowtext("Biaya Administrasi Kartu Debit", "Rp4.000,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text("Biaya Lainnya", style: semibold12),
                              ),
                              rowtext("Tunggakan Biaya Administrasi", "Maksimal 3x tunggakan", 2),
                              rowtext("Tunggakan Denda di bawah Saldo Minimum",
                                  "Maksimal 3x tunggakan", 2),
                              rowtext("Tunggakan Biaya Administrasi Kartu", "Rp10.000,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text("Fasilitas Transaksi", style: semibold12),
                              ),
                              listedText(
                                  "Transaksi dimana saja dan kapan saja dengan aplikasi BNI Mobile Banking"),
                              listedText("Tarik Tunai sampai Rp 5 juta/hari"),
                              listedText("Limit transaksi belanja sampai Rp 10 juta/hari"),
                              listedText(
                                  "Kenyamanan transaksi pembayaran belanja online diberbagai merchant online/e-commerce kapanpun dengan mudah dan aman dengan Kartu Debit BNI Chip Mastercard© dengan teknologi 3D Secure"),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Saldo', style: semibold14.copyWith(color: Colors.white)),
                                Text('Suku Bunga (%) p.a',
                                    style: semibold14.copyWith(color: Colors.white)),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: CustomThemeWidget.bungaBorder,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                            ),
                          ),
                          Column(
                            children: [
                              rowtext("< Rp 1 Juta", "0.00%", 1),
                              rowtext("≥ Rp 1 Juta s/d Rp 50 Juta", "0.10%", 1),
                              rowtext("> Rp 50 Juta s/d Rp 500 Juta", "0.20%", 1),
                              rowtext("> Rp 500 Juta s/d Rp 1 Milyar", "0.60%", 1),
                              rowtext("> Rp 1 Milyar", "0.80%", 1),
                            ],
                          )
                        ] else if (title.toLowerCase() == "taplus muda") ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowtext("Setoran Awal", "Rp100.000,-", 2),
                              rowtext("Minimum Setoran Selanjutnya", "Rp10.000,-", 2),
                              rowtext("Minimum Saldo rata-rata per bulan", "Rp0,-", 2),
                              rowtext("Denda dibawah Saldo Minimum", "Rp0,-", 2),
                              rowtext("Biaya Pengelolaan Rekening Per bulan", "Rp5.000,-", 2),
                              rowtext("Biaya Penggantian Buku", "Rp1.500,-", 2),
                              rowtext("Biaya Penutupan Rekening", "Rp50.000,-", 2),
                              rowtext("Biaya Administrasi Kartu Debit", "Rp4.000,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text(
                                  "Biaya Lainnya",
                                  style: semibold12.copyWith(
                                      fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ),
                              rowtext("Tunggakan Denda di bawah Saldo Minimum",
                                  "Maksimal 3x tunggakan", 2),
                              rowtext("Tunggakan Biaya Administrasi Kartu", "Rp10.000,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text(
                                  "Fasilitas Transaksi",
                                  style: semibold12.copyWith(
                                      fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ),
                              listedText(
                                  "Transaksi dimana saja dan kapan saja dengan aplikasi BNI Mobile Banking"),
                              listedText("Tarik Tunai sampai Rp 5 juta/hari"),
                              listedText("Limit transaksi belanja sampai Rp 10 juta/hari"),
                              listedText(
                                  "Kenyamanan transaksi pembayaran belanja online diberbagai merchant online/e-commerce kapanpun dengan mudah dan aman dengan Kartu Debit BNI Chip Mastercard© dengan teknologi 3D Secure"),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Saldo', style: semibold14.copyWith(color: Colors.white)),
                                Text('Suku Bunga (%) p.a',
                                    style: semibold14.copyWith(color: Colors.white)),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: CustomThemeWidget.bungaBorder,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                            ),
                          ),
                          Column(
                            children: [
                              rowtext("< Rp 1 Juta", "0.00%", 1),
                              rowtext("≥ Rp 1 Juta s/d Rp 10 Juta", "0.25%", 1),
                              rowtext("> Rp 10 Juta s/d Rp 50 Juta", "0.50%", 1),
                              rowtext("> Rp 50 Juta s/d Rp 100 Juta", "0.75%", 1),
                              rowtext("> Rp 100 Juta", "1.00%", 1),
                            ],
                          )
                        ] else if (title.toLowerCase() == "taplus diaspora") ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowtext("Setoran Awal", "Ekuivalen Rp500.000,-", 2),
                              rowtext("Minimum Setoran Selanjutnya", "Rp5.000,-", 2),
                              rowtext("Minimum Saldo rata-rata per bulan", "Rp150.000,-", 2),
                              rowtext("Denda dibawah Saldo Minimum", "Rp5.000,-", 2),
                              rowtext("Biaya Pengelolaan Rekening Per bulan", "Rp11.000,-", 2),
                              rowtext("Biaya Penggantian Buku", "Rp1500,-", 2),
                              rowtext("Biaya Penutupan Rekening", "Rp10.000,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text(
                                  "Biaya Lainnya",
                                  style: semibold12.copyWith(
                                      fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ),
                              rowtext("Tunggakan Biaya Administrasi", "Maksimal 3x tunggakan", 2),
                              rowtext("Tunggakan Denda di bawah Saldo Minimum",
                                  "Maksimal 3x tunggakan", 2),
                              rowtext("Tunggakan Biaya Administrasi Kartu", "Rp10.000,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text(
                                  "Fasilitas Transaksi",
                                  style: semibold12.copyWith(
                                      fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ),
                              listedText(
                                  "Transaksi dimana saja dan kapan saja dengan aplikasi BNI Mobile Banking\n"),
                              Text("Apabila sudah memiliki fisik Kartu Debit BNI:",
                                  style: medium12),
                              listedText("Tarik Tunai sampai Rp 5 juta/hari"),
                              listedText("Limit transaksi belanja sampai Rp 50 juta/hari"),
                              listedText(
                                  "Kenyamanan transaksi pembayaran belanja online diberbagai merchant online/e-commerce kapanpun dengan mudah dan aman dengan Kartu Debit BNI Chip Mastercard© dengan teknologi 3D Secure"),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Saldo', style: semibold14.copyWith(color: Colors.white)),
                                Text('Suku Bunga (%) p.a',
                                    style: semibold14.copyWith(color: Colors.white)),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: CustomThemeWidget.bungaBorder,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                            ),
                          ),
                          Column(
                            children: [
                              rowtext("< Rp 1 Juta", "0.00%", 1),
                              rowtext("≥ Rp 1 Juta s/d Rp 50 Juta", "0.10%", 1),
                              rowtext("> Rp 50 Juta s/d Rp 500 Juta", "0.20%", 1),
                              rowtext("> Rp 500 Juta s/d Rp 1 Milyar", "0.60%", 1),
                              rowtext("> Rp 1 Milyar", "0.80%", 1),
                            ],
                          )
                        ] else if (title.toLowerCase() == "taplus bisnis") ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowtext("Setoran Awal", "Rp1.000.000,-", 2),
                              rowtext("Minimum Setoran Selanjutnya", "Rp5.000,-", 2),
                              rowtext("Minimum Saldo rata-rata per bulan", "Rp1.000.000,-", 2),
                              rowtext("Denda dibawah Saldo Minimum", "Rp20.000,-", 2),
                              rowtext("Biaya Pengelolaan Rekening Per bulan", "Rp10.000,-", 2),
                              rowtext("Biaya Penggantian Buku", "Rp0,-", 2),
                              rowtext("Biaya Penutupan Rekening", "Rp25.000,-", 2),
                              rowtext("Biaya Administrasi Kartu Debit", "Rp7.500,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text("Biaya Lainnya", style: semibold12),
                              ),
                              rowtext("Tunggakan Biaya Administrasi", "Maksimal 3x tunggakan", 2),
                              rowtext("Tunggakan Denda di bawah Saldo Minimum",
                                  "Maksimal 3x tunggakan", 2),
                              rowtext("Tunggakan Biaya Administrasi Kartu", "Rp10.000,-", 2),
                              Divider(thickness: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16),
                                child: Text("Fasilitas Transaksi", style: semibold12),
                              ),
                              listedText(
                                  "Transaksi dimana saja dan kapan saja dengan aplikasi BNI Mobile Banking"),
                              listedText("Tarik Tunai sampai Rp 15 juta/hari"),
                              listedText("Limit transaksi belanja sampai Rp 50 juta/hari"),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Saldo', style: semibold14.copyWith(color: Colors.white)),
                                Text('Suku Bunga (%) p.a',
                                    style: semibold14.copyWith(color: Colors.white)),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: CustomThemeWidget.bungaBorder,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                            ),
                          ),
                          Column(
                            children: [
                              rowtext("< Rp 5 Juta", "0.00%", 1),
                              rowtext("≥ Rp 5 Juta s/d Rp 100 Juta", "0.75%", 1),
                              rowtext("> Rp 100 Juta s/d Rp 1 Milyar", "1.00%", 1),
                              rowtext("> Rp 1 Milyar", "1.50%", 1),
                            ],
                          )
                        ] else
                          ...[],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ));
  }
}
