import 'dart:developer';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/receiptEmail-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../BusinessLogic/Registrasi/DataController.dart';

class sendEmailService {
  Future<ReceiptEmailModel> sendEmail(
      {required String custName,
      required String refNum,
      required String registerDate,
      required String registerTime,
      required String newAccountNum,
      required String jenisRekening,
      required String cardNum,
      required String accountBranch,
      required String branchName,
      required String accStatus,
      required String cardType,
      required String initialDeposit,
      required String lastDepositDate,
      required String email}) async {
    var url = Uri.parse(urlSendEmail);
    // Xml2Json xml2Json = Xml2Json();

    var headers = Get.find<DataController>().headerSoap(step: 'Api Send Email');
    var body = '''
<?xml version='1.0'?>
<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:mail='http://service.bni.co.id/mail'>
    <soapenv:Header/>
    <soapenv:Body>
        <mail:send>
            <emailOut>
                <from>new-mobile-banking@bni.co.id</from>
                <to>$email</to>
                <subject>Pembukaan Rekening BNI</subject>
                <content>
                    <![CDATA[<html>

<head>

</head>

<body>
    <p>&nbsp;</p>
    <p>Yth. $custName,</p>
    <p>Selamat Anda telah memiliki Rekening BNI yang dibuka melalui Fitur Pembukaan Rekening Digital BNI dengan detail sbb:
    <p>&nbsp;</p>
    <table style="width: 561px; height: 140px;">
        <tbody>
            <tr>
                <td style="width: 140px;">Nomor Referensi</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$refNum</td>
            </tr>
            <tr>
                <td style="width: 140px;">Tanggal Registrasi</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$registerDate</td>
            </tr>
            <tr>
                <td style="width: 140px;">Waktu Transaksi</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$registerTime</td>
            </tr>
            <tr>
                <td style="width: 140px;">Nomor Rekening</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$newAccountNum</td>
            </tr>
            <tr>
                <td style="width: 140px;">Jenis Rekening</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$jenisRekening</td>
            </tr>
            <tr>
                <td style="width: 140px;">Nomor Kartu debit Virtuall</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$cardNum</td>
            </tr>
            <tr>
                <td style="width: 140px;">Cabang Pembuka Rekening</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$branchName</td>
            </tr>
            <tr>
                <td style="width: 140px;">Status Rekening</td>
                <td style="width: 10px;">:</td>
                <td style="width: 389px;">$accStatus</td>
            </tr>
        </tbody>
    </table>
    <p>Segera lakukan setoran awal minimal Rp $initialDeposit- sebelum $lastDepositDate. Bila tidak, maka rekening akan tertutup secara
        otomatis.</p>
    <p>Jangan lupa aktifkan <b>BNI Mobile Banking</b> untuk kebebasan bertransaksi dimana saja dan kapan saja. Info lebih lanjut kunjungi link <a href="http://bit.ly/RegisBNIMobileBanking">bit.ly/RegisBNIMobileBanking</a></p>
	<p>&ldquo;Anda dapat melakukan pengambilan kartu debit fisik melalui <b>BNI DigiCS</b> atau <b>Kantor Cabang BNI</b> terdekat. Khusus untuk buku tabungan dapat diambil di Kantor Cabang BNI pada jam operasional. Jangan lupa siapkan e-KTP dan bukti pembukaan rekening Anda.&rdquo;</p>
	<p>Catatan: Email ini dihasilkan secara otomatis oleh sistem dan mohon untuk tidak membalas email ini. Informasi lebih lanjut hubungi BNI Call di 1500046.</p>
    <p>&nbsp;</p>
    <p>Salam&nbsp;hangat,</p>
    <p>PT Bank Negara Indonesia (Persero) Tbk.</p>
</body>
</html>]]>
                </content>
            </emailOut>
        </mail:send>
    </soapenv:Body>
</soapenv:Envelope>
''';
    // log("body" + body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _bodyContent = prefs.getString("sendEmail").toString();
    var body_send = '''
<?xml version='1.0'?>
<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:mail='http://service.bni.co.id/mail'>
    <soapenv:Header/>
    <soapenv:Body>
        <mail:send>
            <emailOut>
                <from>new-mobile-banking@bni.co.id</from>
                <to>$email</to>
                <subject>Pembukaan Rekening BNI</subject>
                <content>
                    <![CDATA[<html>

<head>

</head>

<body>
$_bodyContent
</body>
</html>]]>
                </content>
            </emailOut>
        </mail:send>
    </soapenv:Body>
</soapenv:Envelope>
''';
    log("body_send" + body_send);

    ReceiptEmailModel receiptEmailModel = ReceiptEmailModel();

    var response = await http.post(url, headers: headers, body: body_send);
    receiptEmailModel.responseCode = response.statusCode.toString();
    if (response.statusCode == 200) {
      print('berhasil send email');
      return receiptEmailModel;
    } else {
      print('gagal send email');
      return receiptEmailModel;
    }
  }
}
