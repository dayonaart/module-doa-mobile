import 'dart:convert';

import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/card-and-pin-model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../BusinessLogic/Registrasi/DataController.dart';

class UpdateCardService {
  Future<CardandPinModel> updateCard(
      {required String cardNum,
      required String accountNum,
      required String cifNum,
      required String bin,
      required String cardType}) async {
    var url = Uri.parse(urlUpdateCard);
    print(url.toString());
    var body = {
      "cardNum": cardNum,
      "channel": "EFORM",
      "accountNum": accountNum,
      "cifNum": cifNum,
      "bin": bin,
      "cardType": cardType,
      "oldStatus": "USED",
      "newStatus": "ACTIVATED"
    };
    var headers = Get.find<DataController>().headerJson(step: 'Api Update Card');

    var response = await http.post(url, body: jsonEncode(body), headers: headers);
    print("ini update pin :" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return CardandPinModel.fromJson(data);
    } else {
      throw (Exception);
    }
  }
}
