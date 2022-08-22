import 'dart:convert';

import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/card-and-pin-model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../BusinessLogic/Registrasi/DataController.dart';

class GetcardService {
  Future<CardandPinModel> getCard({
    required String cifNum,
    required String accountNum,
    required String bin,
    required String cardType,
  }) async {
    // final preferences = await SharedPreferences.getInstance();

    var url = Uri.parse(urlGetCard);
    var body = {
      "channel": "EFORM",
      "accountNum": accountNum,
      "cifNum": cifNum,
      "bin": bin,
      "cardType": cardType
    };
    var headers = Get.find<DataController>().headerJson(step: 'Api Get Card');
    var response = await http.post(url, body: jsonEncode(body), headers: headers);
    print('Response code api get card : ${response.statusCode}');
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return CardandPinModel.fromJson(data);
    } else {
      throw (Exception);
    }
  }
}
