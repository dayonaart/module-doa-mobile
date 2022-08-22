import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/GetCabang.dart';
import '../../src/models/kantorCabang_model.dart';

class CabangController extends GetxController {
  List listProvinsi = [];
  List listKota = [];
  List listkantor = [];
  List listkodebi = [];
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kotaControllers = TextEditingController();
  TextEditingController kantorController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  String selectedKota = "";
  String selectedProvinsi = "";
  String selectedKantor = "";
  String selectedKodeBI = "";
  KantorCabangModel? varkantorcabang;
  int index = 0;
  SharedPreferences? prefs;

  @override
  onInit() {
    initCabang();

    super.onInit();
  }

  initCabang() async {
    listProvinsi = await GetCabang().readJsonProvinsi();
    listKota = await GetCabang().readJsonKota();
    listkantor = await GetCabang().readJsonKantor();
    listkodebi = await GetCabang().readJsonBi();
    // if (kDebugMode) {
    //   print("Done init Cabang");
    // }
  }

  Future getStringValuesSF() async {
    prefs = Get.find<DataController>().prefs;
    selectedProvinsi = prefs!.getString("provinsiCabang")!;
    selectedKota = prefs!.getString("kotaCabang")!;
    selectedKantor = prefs!.getString("kantorCabang")!;
    alamatController.text = prefs!.getString("alamatCabang")!;

    // print("cek");
    // print(selectedProvinsi);
    // print(selectedKota);
    // print(selectedKantor);

    if (selectedProvinsi != "") {
      index = listProvinsi.indexWhere((element) => element["id"] == selectedProvinsi);
      provinsiController.text = listProvinsi[index]['provinsi'];
      index = listKota.indexWhere((element) => element["idkota"] == selectedKota);
      kotaControllers.text = listKota[index]['kota'];
      index = listkantor.indexWhere((element) => element["kodeoutlet"] == selectedKantor);
      kantorController.text = listkantor[index]['namaoutlet'];
      update();
    }
  }

  saveSharedPref(List listKode, var response, List listkodebiFilter) async {
    final preferences = prefs;
    preferences!.setString('sandiBI', listKode[0]["SANDI_BI"].toString());
    preferences.setString('kotaBI', listKode[0]["KOTA"].toString());
    preferences.setString('namaOutlet', response["namaoutlet"].toString());
    preferences.setString('kodeOutlet', response["kodeoutlet"].toString());
    preferences.setString('alamatOutlet', response["alamat"].toString());
    // print(listkodebiFilter);
    // print(listkodebiFilter[0]["SANDI_BI"].toString());
    // print(listkodebiFilter[0]["KOTA"].toString());
    // print(response);
    // print(response["namaoutlet"].toString());
    // print(response["kodeoutlet"].toString());
    // print(response["alamat"].toString());

    // print(selectedProvinsi);
    preferences.setString("provinsiCabang", selectedProvinsi);
    preferences.setString("kotaCabang", selectedKota);
    preferences.setString("kantorCabang", response['kodeoutlet']);
    preferences.setString("alamatCabang", alamatController.text);
  }
}
