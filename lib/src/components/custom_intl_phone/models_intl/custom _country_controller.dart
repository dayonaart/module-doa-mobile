// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:eform_modul/BusinessLogic/Registrasi/DataDiri1Controller.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../BusinessLogic/Registrasi/DataController.dart';

class CustomCountryController extends GetxController {
  SharedPreferences? prefs;
  List idPosisi = [];
  List nameCountry = [];
  List nameSearch = [];
  List dialCode = [];
  List flagUrl = [];
  List code = [];
  List object = [];
  List indexResult = [];
  List tempData = [];
  List tempDataList = [];

  var data;
  TextEditingController search = TextEditingController();

  Future saveCountry(int selectedIndex) async {
    final preferences = Get.find<DataController>().prefs;
    preferences.setString('selectedFlagCountry', flagUrl[indexResult[selectedIndex]]);
    preferences.setString('selectedCountryName', nameCountry[indexResult[selectedIndex]]);
    preferences.setString('dialCodeNegara', dialCode[indexResult[selectedIndex]]);
    print(preferences.getString('selectedCountryName'));
  }

  Future defaultSaveCountry(int selectedIndex) async {
    final preferences = Get.find<DataController>().prefs;
    preferences.setString('selectedFlagCountry', flagUrl[selectedIndex]);
    preferences.setString('selectedCountryName', nameCountry[selectedIndex]);
    preferences.setString('dialCodeNegara', dialCode[selectedIndex]);
    print(preferences.getString('selectedFlagCountry'));
  }

  Future loadCountryJson() async {
    print("ini adlaah objeckk" + object.length.toString());
    if (object.length != 0) {
      search.text = '';
      CustomLoading().dismissLoading();
    } else {
      search.text = '';
      final String response = await rootBundle.loadString("assets/jsonfiles/codePhone.json");
      var body = jsonDecode(response);
      object = body['phoneCode'];
      for (var i = 0; i < object.length; i++) {
        idPosisi.add(object[i]['idposisi']);
        nameCountry.add(object[i]['name']);
        nameSearch.add(object[i]['name'].toString().toLowerCase());
        dialCode.add(object[i]['dial_code']);
        flagUrl.add("assets/images/bendera/${object[i]['code']}.png".toLowerCase());
        code.add(object[i]['code']);
      }
      print(flagUrl);

      CustomLoading().dismissLoading();
    }
  }
}
