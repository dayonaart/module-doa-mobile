import 'dart:convert';

import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/src/components/Encrypt.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../BusinessLogic/Registrasi/DataController.dart';
import '../src/models/Status.dart';

class CreatePinService {
  Future<String> createPin({
    required String refnum,
    required String accountnum,
    required String cardnum,
    required String pin,
  }) async {
    Encrypt encrypt = Encrypt();
    var url = Uri.parse(urlCreatePin);
    Xml2Json xml2Json = Xml2Json();
    String resultPin = "encrypt.encrypt(pin);";
    if (kDebugMode) {
      print("Encripted : " + resultPin);
    }

    var headers = Get.find<DataController>().headerSoap(step: 'Api Create Pin');
    var body = '''
<?xml version="1.0"?>
    <soapenv:Envelope xmlns:q0="http://service.bni.co.id/atmpin" xmlns:bo="http://service.bni.co.id/atmpin/bo" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <soapenv:Body>
            <q0:transaction>
                <request>
                    <clientId>KANIA</clientId>
                    <reffNum>$refnum</reffNum>
                    <content xsi:type="bo:PinCreateReq">
                        <operation>PINCREATE</operation>
                        <accountNum>$accountnum</accountNum>
                        <cardNum>$cardnum</cardNum>
                        <expDate/>
                        <encPin1>$resultPin</encPin1>
                    </content>
                </request>
            </q0:transaction>
        </soapenv:Body>
    </soapenv:Envelope>
''';
    // '"<?xml version="1.0"?><soapenv:Envelope xmlns:q0="http://service.bni.co.id/atmpin" xmlns:bo="http://service.bni.co.id/atmpin/bo" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><q0:transaction><request><clientId>KANIA</clientId><reffNum>20220222140010300173</reffNum><content xsi:type="bo:PinCreateReq"><operation>PINCREATE</operation><accountNum>1000139728</accountNum><cardNum>5371769990007957</cardNum><expDate/><encPin1>hz3XMKlYcF9KtbkAr8OnRvOdc9DDAAqpDXqwf3st/kzlk//EQvuJCBEekoViWIkM497qwo8G86b4Sd1jzJy7A6C/PBsr37THUO5Nb5eFQGaBSn0+7TMcIC0JVAiqt4LCzZ3tPmBXPVvYu8CPftTJvC9UYAVz852EMb+jv4ShARdRj6vZp+009yGtcRQmzlWhPUvJYLIbRkig33Sb0gQBCZLEiKoFk3T29uamPu/C3Qs6WWqsODT+eW3jwpCHu8T/vyFtYlaq2JBpX3/ojtpJOZ5dTh+a8Yeaxc01yLfKE4acb1kVvMk7+mkeF9yFcvgi1821cp4a3PwsLnSz5VSouQ==</encPin1></content></request></q0:transaction></soapenv:Body></soapenv:Envelope>"';

    var response = await http.post(url, headers: headers, body: body);
    print("status code" + response.statusCode.toString());
    // xml2Json.parse(response.body);
    // var jsondatatoGData = xml2Json.toGData();
    // var jsondatatoParker = xml2Json.toParker();
    // print('ini hasil xml : ' + response.body);
    // print('Ini hasil json dr parker : ' + jsondatatoParker);
    // print('Ini hasil json dr gdata : ' + jsondatatoGData);
    print('Ini Adalah :' + response.body);

    if (response.statusCode == 200) {
      // var data = json.decode(jsondatatoParker)['soapenv:Envelope']
      //         ['soapenv:Body']['atm:transactionResponse']['response']['content']
      //     ['response'];
      // print('ini data : ' + data.toString());
      var data = '00';
      return data;
    } else {
      // var data = json.decode(jsondatatoParker)['soapenv:Envelope']
      //         ['soapenv:Body']['atm:transactionResponse']['response']['content']
      //     ['response'];
      //print('ini data : ' + data.toString());
      Get.find<OtpController>().state = Status.Failed;
      return response.body.toString();
    }
  }
}

//note dari fariz untuk rifqi
/*
[1]
Kemungkinan saat convert xml to json lebih baik pakai toParker() karena kita butuh datanya, tanpa styling xml di json kita.
refrensi output xmltojson https://codebeautify.org/xmltojson
refrensi converter https://www.bezkoder.com/dart-flutter-xml-to-json-xml2json/

[2]
converting dan printing bisa diatas aja sblm logic, isi dari logic if else hny utk return value/action.

[3]
Mohon maaf Saya belum bisa make sure perihal posting data dari flutter ke server apakah sudah benar atau belum.
mungkin masalah var bisa diakalan pakai declared string tiap xml tag<>

(String _clientid, ..)

<clientID>_clientid</clientID>
*/
