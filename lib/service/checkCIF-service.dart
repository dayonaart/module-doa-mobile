import 'dart:convert';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class CheckMIFService {
  Future<String> cekCIF({required cifNum, required phone, required email}) async {
    var url = Uri.parse(urlcheckCIFMbank);
    Xml2Json xml2Json = Xml2Json();

    var headers = Get.find<DataController>().headerSoap(step: 'Api Check Cif Mbank');
    var body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:new="http://service.bni.co.id/echannel/newmobile">
   <soapenv:Header/>
   <soapenv:Body>
      <new:inquiryAllParam>
           <cifNum>$cifNum</cifNum>
         <username>0</username>
         <phone>$phone</phone>
         <email>$email</email>

      </new:inquiryAllParam>
   </soapenv:Body>
</soapenv:Envelope>
''';

//Data Dummy
    //  <cifNum>9100781945</cifNum>
    //        <username></username>
    //        <phone>082232702164</phone>
    //        <email>fikirere1908@gmail.com</email>
//Data dinamis
    //  <cifNum>$cifNum</cifNum>
    //        <username></username>
    //        <phone>$phone</phone>
    //        <email>$email</email>

    var response = await http.post(url, headers: headers, body: body);

    print('Ini adalah respon cekcif : ' + response.statusCode.toString());
    // print(response.body);
    xml2Json.parse(response.body);
    var jsondatatoGData = xml2Json.toGData();

    // print('ini adalah hasil decode : ' +
    //     jsonDecode(jsondatatoGData)['soapenv\$Envelope']['soapenv\$Body']
    //                 ['soapenv\$Fault']['detail']
    //             ['ne\$inquiryAllParamFault1_appFault']['errorNum']['\$t']
    //         .toString());
    var data = jsonDecode(jsondatatoGData)['soapenv\$Envelope']['soapenv\$Body']['soapenv\$Fault']
            ['detail']['ne\$inquiryAllParamFault1_appFault']['errorNum']['\$t']
        .toString();

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }
}
