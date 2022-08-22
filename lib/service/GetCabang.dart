import 'dart:convert';

import 'package:eform_modul/main.dart';
import 'package:flutter/services.dart';

class GetCabang {
  Future<List> readJsonProvinsi() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/provinsi_cabang.json');
    final data = await json.decode(response);

    return data["regions"];

    // print("inisiasi:" + _listProvinsi.toString() + "\n");
  }

  // Fetch json kota from the json file
  Future<List> readJsonKota() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kota_cabang.json');
    final data = await json.decode(response);

    return data["regions"];

    // print("inisiasi:" + _listKota.toString() + "\n");
  }

  // Fetch json kota from the json file
  Future<List> readJsonKantor() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kantor_cabang.json');

    final data = await jsonDecode(response);

    return data["regions"];

    // print("inisiasi:" + _listkantor.toString() + "\n");
  }

  Future<List> readJsonBi() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/bi.json');
    final data = await json.decode(response);

    return data["bi"];

    // print("inisiasi:" + _listkodebi.toString() + "\n");
  }
}
