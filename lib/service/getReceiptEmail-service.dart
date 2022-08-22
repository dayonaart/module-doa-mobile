import 'dart:convert';
import 'dart:developer';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/receiptEmail-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';
import 'package:get/get.dart';
import '../BusinessLogic/Registrasi/DataController.dart';

class GetReceiptEmailService {
  Future<ReceiptEmailModel> getReceiptEmail(
      {required String custName,
      required refNum,
      required registerDate,
      required registerTime,
      required newAccountNum,
      required accountType,
      required cardNum,
      required accountBranch,
      required branchName,
      required accStatus,
      required cardType,
      required initialDeposit,
      required provider,
      required lastDepositDate}) async {
    var url = Uri.parse(urlReceiptEmail);
    Xml2Json xml2Json = Xml2Json();

    // String email = "alifa.farizi@indocyber.id";
    // custName = "FULLAN BIN TESTING";
    // refNum = "2022323103015356016";
    // registerDate = "23 Mar 2022";
    // registerTime = "10:30:15";
    // newAccountNum = "1000278275";
    // accountType = "taplus";
    // cardNum = "5264229990022021";
    // accountBranch = "KCP BINTUHAN";
    // branchName = "KCP BINTUHAN";
    // accStatus = "Terbuka (Open)";
    // cardType = "1";
    // initialDeposit = "250.000";
    // lastDepositDate = "25 Mar 2022";
    var headers = Get.find<DataController>().headerSoap(step: 'Api Get Receipt Email');
    var body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:rec="http://service.bni.co.id/receipt"
	xmlns:obj="http://service.bni.co.id/receipt/obj">
    <soapenv:Header />
    <soapenv:Body>
        <rec:compose>
            <rec:request>
                <obj:channelId>EFORM</obj:channelId>
                <obj:jsonStringParams>
					{
					"custName":"$custName",
					"refNum": "$refNum",
					"registerDate" : "$registerDate",
					"registerTime" : "$registerTime",
					"newAccountNum" : "$newAccountNum",
					"accountType" : "$accountType",
					"cardNum" : "$cardNum",
					"accountBranch":"$accountBranch",
					"branchName":"$branchName",
					"accStatus":"$accStatus",
					"cardType":"$cardType",
					"initialDeposit" : "$initialDeposit",
					"lastDepositDate" : "$lastDepositDate"
					}
				</obj:jsonStringParams>
                <obj:providerId>${provider}</obj:providerId>
            </rec:request>
        </rec:compose>
    </soapenv:Body>
</soapenv:Envelope>
''';

    var response = await http.post(url, headers: headers, body: body);
    print("status code" + response.statusCode.toString());

    if (response.statusCode == 200) {
      xml2Json.parse(response.body);
      final jsondatatoParker = xml2Json.toParker();
      final jsondatatoGData = xml2Json.toGData();
      log('ini hasil xml response body : ' + response.body);
      String _replace1 =
          ('<?xml version="1.0" encoding="utf-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><composeResponse xmlns="http://service.bni.co.id/receipt"><composeReturn><channelId>EFORM</channelId><receipt>&lt;html&gt;');
      String _replace1a = ('&lt;head&gt;');
      String _replace1b = ('&lt;/head&gt;');
      String _replace1c = ('&lt;body&gt;');
      String _replace1d = ('&lt;/body&gt;');

      String replaced = response.body.replaceAll(_replace1, "");
      String replaced2 = replaced.replaceAll(_replace1a, "");
      String replaced3 = replaced2.replaceAll(_replace1b, "");
      String replaced4 = replaced3.replaceAll(_replace1c, "");
      String replaced5 = replaced4.replaceAll(_replace1d, "");
      String replaced6 = replaced5.replaceAll("&lt;", "<");
      String replaced7 = replaced6.replaceAll("&gt;", ">");
      String replaced8 = replaced7.replaceAll("&amp;", "&");
      String replaced9 = replaced8.replaceAll("&quot;", '"');
      String replaced10 = replaced9.replaceAll("</html>", '');
      String replaced11 = replaced10.replaceAll(
          "</receipt></composeReturn></composeResponse></soapenv:Body></soapenv:Envelope>", '');

      log('ini STRING REPLACE 1 response body : ' + replaced11);
      //log('Ini hasil json dr parker : ' + jsondatatoParker);

      //var data = jsonDecode(response.body)['Envelope']['Body']['composeResponse']['composeReturn'];
      var data = jsonDecode(jsondatatoParker)['soapenv:Envelope']['soapenv:Body']['composeResponse']
          ['composeReturn'];
      //var data2 = jsonDecode(jsondatatoGData);
      //log('Ini hasil json dr parker : ' + data.toString().trim());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("sendEmail", replaced11);

      ReceiptEmailModel receiptEmailModel = ReceiptEmailModel.fromJson(data);
      receiptEmailModel.receipt = data["receipt"].toString();
      receiptEmailModel.responseCode = response.statusCode.toString();
      return receiptEmailModel;
    } else {
      print('gagal get receipt');
      return ReceiptEmailModel();
    }
  }
}
