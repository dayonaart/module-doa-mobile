import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> CHECK_DEVICES_CONNECTION() async {
  var _isNoConnection =
      (await (Connectivity().checkConnectivity()) == ConnectivityResult.none);
  if (_isNoConnection) {
    Get.snackbar("Perhatian", "Pastikan Koneksi Anda Terhubung ke Internet",
        backgroundColor: Colors.red);
    return false;
  }
  return true;
}
