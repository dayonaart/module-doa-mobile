import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class cekMbankService {
  Future<String> cekMbank(
      {required String username,
      required String phone,
      required String email,
      required String cifnum}) async {
    var url = Uri.parse(urlcheckCIFMbank);
    Xml2Json xml2Json = Xml2Json();
    var body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:new="http://service.bni.co.id/echannel/newmobile">
   <soapenv:Header/>
   <soapenv:Body>
      <new:inquiryAllParam>
           <cifNum>$cifnum</cifNum>
         <username>$username</username>
         <phone>$phone</phone>
         <email>$email</email>

      </new:inquiryAllParam>
   </soapenv:Body>
</soapenv:Envelope>

''';
    var headers = Get.find<DataController>().headerSoap(step: 'Api Check Mbank');

    var response = await http.post(url, body: body, headers: headers);

    print('Ini REsponse dari cek Mbank : ' + response.statusCode.toString());
    print(body.toString());

    xml2Json.parse(response.body);
    var jsondatatoGData = xml2Json.toGData();

    // print('ini adalah hasil decode : ' +
    //     jsonDecode(jsondatatoGData)['soapenv\$Envelope']['soapenv\$Body']
    //                 ['soapenv\$Fault']['detail']
    //             ['ne\$inquiryAllParamFault1_appFault']['errorNum']['\$t']
    //         .toString());
    if (response.statusCode == 200) {
      return response.statusCode.toString();
      // return jsonDecode(jsondatatoGData)['soapenv\$Envelope']['soapenv\$Body']
      //             ['soapenv\$Fault']['detail']
      //         ['ne\$inquiryAllParamFault1_appFault']['errorNum']['\$t']
      //     .toString();
    } else if (response.statusCode == 500) {
      return response.statusCode.toString();
      // var data = jsonDecode(jsondatatoGData)['soapenv\$Envelope']
      //             ['soapenv\$Body']['soapenv\$Fault']['detail']
      //         ['ne\$inquiryAllParamFault1_appFault']['errorNum']['\$t']
      //     .toString();
      // Get.find<CreateMbankController>().state = Status.Success;
      // return data;
    } else {
      return response.body.toString();
    }
  }
}
