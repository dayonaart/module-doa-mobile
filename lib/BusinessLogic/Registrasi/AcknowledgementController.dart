import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show Platform;

import 'package:eform_modul/BusinessLogic/Registrasi/CreatePinController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/response_model/active_card_model_response.dart';
import 'package:eform_modul/response_model/get_card_model_response.dart';
import 'package:eform_modul/response_model/update_card_model_response.dart';
import 'package:eform_modul/service/services.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:eform_modul/src/views/success-page/create-mbank.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

import '../../service/checkCIF-service.dart';

import '../../src/components/mobile.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AcknowledgementController extends GetxController {
  Status state = Status.Initial;
  String errorCode = "";

  List attributeAck = [
    // "No Rekening",
    "No. Kartu Debit Virtual",
    "Nama Nasabah",
    "Jenis Produk yang dipilih",
    "Tanggal Pembukaan Rekening",
    "Waktu Pembukaan Rekening",
    "Kantor Cabang",
    "Keterangan"
  ];

  String product = '';
  String email = '';
  String phone = '';
  String accountNum = '';
  String countryCode = '';
  String depositDeadline = '';
  List valueAck = [];
  Xml2Json xml2Json = Xml2Json();

  String minimumDeposit = '';
  static const platform = MethodChannel('doa.bni.id/channel');
  Future<void> openMBank() async {
    // print('Masuk Sini');
    try {
      final int result = await platform.invokeMethod('openMBank');

      // print('opening mbank $result % .');
    } on PlatformException catch (e) {
      // print("Failed to open mbank: '${e.message}'.");
    }
  }

  //NOTES CIFNUM DIDAPAT DARI RESPON SERVICE UPDATE CARD, JADI YANG DISINI TUNGGU DULU SERVICE UPDATE CARD SELESAI
//   get _body => '''
// <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:new="http://service.bni.co.id/echannel/newmobile">
//    <soapenv:Header/>
//    <soapenv:Body>
//       <new:inquiryAllParam>
//            <cifNum>'${Get.find<CreatePinController>().getCardModelResponse?.cifNum}'</cifNum>
//          <username>0</username>
//          <phone>${Get.find<OtpController>().phoneNumber}</phone>
//          <email>$email</email>

//       </new:inquiryAllParam>
//    </soapenv:Body>
// </soapenv:Envelope>

// ''';

  get _body => '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:new="http://service.bni.co.id/echannel/newmobile"><soapenv:Header/><soapenv:Body><new:inquiryAllParam><cifNum>'${Get.find<CreatePinController>().getCardModelResponse?.cifNum}'</cifNum><username>0</username><phone>${Get.find<OtpController>().phoneNumber}</phone><email>$email</email></new:inquiryAllParam></soapenv:Body></soapenv:Envelope>
''';

  Future<void> submit() async {
    CustomLoading().showLoading('Memuat Data');

    var _res = await Services().POST(urlcheckCIFMbank, 'Api Check Cif Mbank', body: _body);
    // print(_res!.statusCode);
    // print(_res.data?.body);
    // print(_res?.data?.header);
    // print('Ini adalah : ' + _res.statusCode.toString());
    // print('Masuk Sini');
    var data = _res?.data?.header
        .toString()
        .split("<")
        .where((e) => e.contains("faultstring>"))
        .where((e) => !e.contains('/'))
        .join()
        .replaceAll("faultstring>", "");
    // print("ERROR CODE $data");
    if (_res?.statusCode == 500) {
      if (data == '9001') {
        CustomLoading().dismissLoading();
        Get.to(() => CreateMbank(), transition: Transition.rightToLeft);
      } else {
        CustomLoading().dismissLoading();
        ERROR_DIALOG(errorCode: 'RCS');
      }
    } else if (_res?.statusCode == 200) {
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: 'RCS');
    } else {
      CustomLoading().dismissLoading();
      ERROR_DIALOG();
    }

    // if (_res!.statusCode == 500) {
    //   CustomLoading().dismissLoading();
    //   Get.toNamed(Routes().createMbank);
    // } else if (_res.statusCode == 200) {
    //   CustomLoading().dismissLoading();
    //   ERROR_DIALOG(errorCode: 'RCS');
    // } else {
    //   CustomLoading().dismissLoading;
    //   ERROR_DIALOG(errorCode: '');
    // }
  }

  cekMif({required String cifnum, required String email, required String phone}) async {
    try {
      // emit(CekmifLoading());
      // print(state);
      errorCode = await CheckMIFService().cekCIF(cifNum: cifnum, email: email, phone: phone);
      state = Status.Success;
      // emit(CekmifSuccess(errorCode));
    } catch (e) {
      errorCode = e.toString();
      state = Status.Failed;
      // emit(CekmifFailed());
    }
  }

  checkProductType(String productType) {
    // print(productType);
    if (productType == 'Taplus Muda') {
      minimumDeposit = '100.000,-';
      update();
      // setState(() {
      // });
    } else if (productType == 'Taplus') {
      minimumDeposit = '250.000,-';
      update();

      // setState(() {
      // });
    } else if (productType == 'Taplus Bisnis') {
      minimumDeposit = '1.000.000,-';
      update();

      // setState(() {
      // });
    } else if (productType == 'Taplus Diaspora') {
      minimumDeposit = '500.000,-';
      update();

      // setState(() {
      // });
    }
    DateTime now = DateTime.now();
    // var depositTesting = DateFormat('dd MMMM yyyy');
    depositDeadline =
        DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime(now.year, now.month + 1, now.day));
    update();
  }

  Future<void> generatePDF() async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final icon = pw.MemoryImage(
      (await rootBundle.load('assets/images/simpanan-logo.png')).buffer.asUint8List(),
    );

    doc.addPage(pw.Page(
        orientation: pw.PageOrientation.portrait,
        build: (context) {
          return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Align(
                alignment: pw.Alignment.topRight,
                child: pw.Container(child: pw.Image(icon), width: 90, height: 30)),
            pw.SizedBox(height: 60),
            pw.Text('Pembukaan Rekening Anda sudah berhasil', style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 20),
            for (int i = 0; i < valueAck.length; i++)
              pw.Column(children: [
                pw.Row(children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(attributeAck[i], style: pw.TextStyle(fontSize: 14)),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(':'),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(valueAck[i], style: pw.TextStyle(fontSize: 14)),
                  ),
                ]),
                pw.SizedBox(height: 30),
              ]),
            pw.RichText(
              text: pw.TextSpan(style: pw.TextStyle(fontSize: 14), children: [
                pw.TextSpan(
                    text:
                        'Segera lakukan setoran awal minimal Rp. $minimumDeposit sebelum $depositDeadline. Bila tidak, maka rekening akan tertutup secara otomatis. Jangan lupa aktifkan '),
                pw.TextSpan(
                  text: 'BNI Mobile Banking ',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.TextSpan(
                    text:
                        'untuk kebebasan bertransaksi dengan melanjutkan ke menu "Pendaftaran Mobile Banking."'),
              ]),
            ),
            pw.SizedBox(height: 30),
            pw.RichText(
              text: pw.TextSpan(style: pw.TextStyle(fontSize: 14), children: [
                pw.TextSpan(text: 'Anda dapat melakukan pengambilan kartu debit fisik melalui '),
                if (product != 'Taplus Diaspora')
                  pw.TextSpan(
                    text: 'BNI DigiCS atau ',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                pw.TextSpan(
                  text: 'Kantor Cabang BNI ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.TextSpan(text: 'terdekat. '),
                if (product != 'Taplus Diaspora')
                  pw.TextSpan(
                      text:
                          'Khusus untuk buku tabungan dapat diambil di Kantor Cabang BNI pada jam operasional. '),
                pw.TextSpan(text: 'Jangan lupa siapkan e-KTP dan bukti pembukaan rekening Anda.'),
              ]),
            ),
            pw.SizedBox(height: 80),
            pw.Row(children: [
              pw.Text(
                  DateFormat('MMMM dd', 'id_ID').format(
                    DateTime.now(),
                  ),
                  style: pw.TextStyle(fontSize: 14)),
              pw.SizedBox(width: 5),
              pw.Text(
                  DateFormat(
                    'HH:mm',
                  ).format(
                    DateTime.now(),
                  ),
                  style: pw.TextStyle(fontSize: 14)),
            ]),
          ]);
        }));

    List<int> bytes = await doc.save();
    Platform.isIOS
        ? saveAndLaunchFile(bytes, '${valueAck[1]}')
        : downloadDirectory(bytes, '${valueAck[1]}');
  }

  getStringValuesSF(String? accountNum, String errorCode, String? Cardnum) async {
    SharedPreferences prefs = Get.find<DataController>().prefs;
    product = prefs.getString('produk')!;
    checkProductType(prefs.getString('produk')!);
    //valueAck.add(accountNum);
    var buffer = new StringBuffer();
    for (int i = 0; i < Cardnum.toString().length; i++) {
      buffer.write(Cardnum.toString()[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != Cardnum.toString().length) {
        buffer.write(' '); // Replace this with anything you want to put after each 4 numbers
      }
    }
    String formattedCardnum = buffer.toString();
    valueAck.add("${formattedCardnum}\n(${prefs.getString("namaKartu")})");
    valueAck.add(prefs.getString('namaSesuaiKTP'));
    valueAck.add(prefs.getString('produk')!);
    valueAck.add(DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now()));
    valueAck.add(DateFormat('HH:mm:ss').format(DateTime.now()) + ' WIB');
    valueAck.add(prefs.getString("namaOutlet")!);
    email = prefs.getString('email') as String;
    phone = prefs.getString('nomorHandphone') as String;
    accountNum = accountNum;

    countryCode = prefs.getString('indexPosisi')!;
    if (errorCode == '2') {
      valueAck.add('Gagal Aktivasi Kartu');
    } else if (errorCode == '1') {
      valueAck.add('Gagal Mendapatkan Kartu');
    } else if (errorCode == '3') {
      valueAck.add('Gagal Membuat Pin');
    } else {
      valueAck.add('Rekening Berhasil Terbuka');
    }
  }
}
