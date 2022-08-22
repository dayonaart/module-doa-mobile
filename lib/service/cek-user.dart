import 'dart:convert';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/check-connectivity.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/send-otp-model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../src/models/Status.dart';

class CekUser {
  Future<bool> cekUser(String nik, String tanggal) async {
    if (!(await CHECK_DEVICES_CONNECTION())) {
      return false;
    }
    final prefs = Get.find<DataController>().prefs;
    var url = Uri.parse(urlCekNIK);

    if (kDebugMode) {
      print(url.toString());
    }

    var body = {
      "channel": "EFORM",
      "idNum": nik,
      "idType": "0001",
      "pob": "",
      "dateOfBirth": tanggal
    };
    // var header = {'Content-Type': 'application/json'};

    var response = await http.post(url,
        body: jsonEncode(body),
        headers: Get.find<DataController>().headerJson(step: 'Api Check Account'));

    print(response.statusCode);
    print('Ini Adalah response body Cek User' + response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['errorCode'];
      print(data);
      if (data == '') {
        Get.find<DataController>().state = Status.Success;
        prefs.setString('errorCode', '');
        return true;
      } else {
        Get.find<DataController>().state = Status.Initial;
        prefs.setString('errorCode', data);
        prefs.getString('errorCode').toString();
        return false;
      }
    } else {
      throw (Exception);
    }
  }
}
