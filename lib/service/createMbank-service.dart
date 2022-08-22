import 'dart:convert';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class createMbankService {
  Future<String> createMbank(
      {required String username,
      required String name,
      required String cifnum,
      required String phonenum,
      required String email}) async {
    Xml2Json xml2Json = Xml2Json();
    var url = Uri.parse(urlcheckCIFMbank);
    var body = '''
<soapenv:Envelope
xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:new="http://service.bni.co.id/echannel/newmobile">
   <soapenv:Header/>
   <soapenv:Body>
      <new:registerUserNewMb>
         <request>
            <username>$username</username>
            <cifnum>$cifnum</cifnum>
            <fullname>$name</fullname>
            <segmentation>MASS</segmentation>
            <phonenum>$phonenum</phonenum>
            <email>$email</email>
            <employeeId></employeeId>
            <branchcode></branchcode>
            <supervisorId></supervisorId>
            <channel></channel>
         </request>
      </new:registerUserNewMb>
   </soapenv:Body>
</soapenv:Envelope>

''';
    var headers = Get.find<DataController>().headerSoap(step: 'Api Create Mbank');

    var response = await http.post(url, body: body, headers: headers);
    xml2Json.parse(response.body);

    var jsondatatoGData = xml2Json.toGData();
    print('Ini Body : ' + body.toString());
    print(response.body);
    print('Ini Respon Code Create Mbank' + response.statusCode.toString());

    if (response.statusCode == 200) {
      return response.statusCode.toString();
    } else {
      return response.statusCode.toString();
      // String data = jsonDecode(jsondatatoGData)['soapenv\$Envelope']
      //             ['soapenv\$Body']['soapenv\$Fault']['detail']
      //         ['ne\$inquiryAllParamFault1_appFault']['errorNum']['\$t']
      //     .toString();
      // print('Ini data' + data);
      // return data;
    }
  }
}
