// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CustomCountryModels extends GetxController {
  List idPosisi = [];
  List name = [];
  List dialCode = [];
  List flagUrl = [];
  List code = [];
  List object = [];
  var data;
  TextEditingController search = TextEditingController(text: '');

  Future loadJson() async {
    final String response = await rootBundle.loadString("assets/jsonfiles/codePhone.json");
    var body = jsonDecode(response);
    object = body['phoneCode'];
    for (var i = 0; i < object.length; i++) {
      idPosisi.add(object[i]['idposisi']);
      name.add(object[i]['name']);
      dialCode.add(object[i]['dial_code']);
      flagUrl.add("assets/images/bendera/${object[i]['code']}.png".toLowerCase());
      code.add(object[i]['code']);
    }
    print(flagUrl);

    CustomLoading().dismissLoading();
  }
}
