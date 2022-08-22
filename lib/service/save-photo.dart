import 'dart:convert';
import 'dart:developer';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/url-api.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SavePhotoService {
  Future<bool> savePhoto(
      {required String nik,
      required String photo,
      required String originalSize,
      required String convertSize,
      required String type}) async {
    try {
      var url = Uri.parse(urlSavePhoto);
      var body = {
        'type': '$type',
        'nik': nik,
        'photo': photo,
        'originalSize': originalSize,
        'convertSize': convertSize
      };

      var header = Get.find<DataController>().headerJson(step: 'Api Save Photo');
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      if (kDebugMode) {
        print("Ini adalah status code dari sevice SavePhoto : " + response.statusCode.toString());
        print("ini adalah body dari service SavePhoto : $body");
        print("ini adalah response dari service SavePhoto : " + response.body);
      }
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR SERVICE SAVE PHOTO ${e.toString()}");
      log(e.toString());
      return false;
    }
  }
}
