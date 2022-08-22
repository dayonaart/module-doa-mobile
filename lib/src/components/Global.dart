import 'dart:math';

// import 'package:detail/device_detail.dart';
// import 'package:device_info/device_info.dart';
import 'package:device_info/device_info.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class Global {
  String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  Future<String> generateIDSession(SharedPreferences prefs) async {
    final devicePropertiesPlugin = DeviceInfo();
    var uuid = await devicePropertiesPlugin.getUUID();

    String IDSession = "";
    if (prefs.get("sessionId") == null || prefs.get("sessionId") == "") {
      IDSession = uuid.toString();
      // print("generate IDSession");
      prefs.setString("sessionId", IDSession);
      // print(prefs.getString("sessionId"));
    } else {
      IDSession = prefs.getString("sessionId") ?? "";
      // print("ID Session Sudah ada");
    }

    return IDSession;
  }

  String generateIDUser(SharedPreferences prefs) {
    String IDUser = "";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddHHmmss').format(now);
    String idUser = formattedDate + getRandomString(6);
    print("Generate IDUser");
    prefs.setString("idUser", idUser);
    print(prefs.getString("idUser"));
    return idUser;
  }

  String generateSecretJwt({@required String? timepstamp}) {
    var prefs = Get.find<DataController>();
    var _secret = prefs.generateMd5("${prefs.prefs.getString("sessionId")}$timepstamp");
    // print(
    //     'SECRET KEY $_secret\n\n${prefs.prefs.getString("sessionId")}$timepstamp');
    return _secret;
  }

  Function listEquality = const ListEquality().equals;
  bool compareableJwtBody({
    @required List<dynamic>? responseBody,
    @required List<dynamic>? jwtBody,
  }) {
    try {
      // print('trying to comparing......');
      // print('RESPONSE BODY $responseBody');
      // print('JWT BODY $jwtBody');
      return listEquality(jwtBody, responseBody);
    } catch (e) {
      // print("error while compareableJwtBody()");
      return false;
    }
  }
}
