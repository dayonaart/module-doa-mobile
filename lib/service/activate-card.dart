import 'dart:convert';

import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/card-and-pin-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../BusinessLogic/Registrasi/DataController.dart';

import '../src/models/receiptEmail-model.dart';

class ActivateCardService {
  Future<CardandPinModel> activateCard(
      {required String cardNum,
      required String accountNum,
      required String cifNumm,
      required String bin,
      required String card_type,
      e}) async {
    var url = Uri.parse(urlActivateCard);

    print(url.toString());
    var body = {
      "cardNum": cardNum,
      "channel": "EFORM",
      "accountNum": accountNum,
      "cifNum": cifNumm,
      "bin": bin,
      "cardType": card_type
    };
    var headers = Get.find<DataController>().headerJson(step: 'Api Activate Card');
    var response = await http.post(url, body: jsonEncode(body), headers: headers);
    print('ini adalah response dari api ActivateService : ${response.statusCode}');
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ReceiptEmailModel.fromJson(data);
      return CardandPinModel.fromJson(data);
    } else {
      throw (Exception);
    }
  }
}
