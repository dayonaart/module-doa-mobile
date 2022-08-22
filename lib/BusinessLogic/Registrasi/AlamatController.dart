import 'dart:convert';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/service/preferences-alamat-luar-indonesia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/preferences-alamat-indonesia.dart';
import '../../src/models/alamat-indonesia.dart';
import '../../src/models/alamat-luar-indonesia.dart';
import '../../src/utility/custom_loading.dart';

class AlamatController extends GetxController {
  TextEditingController alamatController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController rwController = TextEditingController();
  TextEditingController desaKelurahanController = TextEditingController();
  TextEditingController kodePosController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();
  TextEditingController negaraController = TextEditingController();
  TextEditingController alamatDomisilinController = TextEditingController();
  bool isLoadingCountry = true;

  String negara = "";
  String codeNegara = "";

  List listProvinsi = [];
  List listKota = [];
  List listKecamatan = [];
  List listKodePos = [];
  List listNegara = [];
  final preferencesAlamatIndonesia = PreferencesAlamatIndonesia();
  final preferencesAlamatLuarIndonesia = PreferencesAlamatLuarIndonesia();

  SharedPreferences? prefs;

  @override
  onInit() {
    initData();
    super.onInit();
  }

  initData() {
    readJsonProvinsi();
    readJsonKota();
    readJsonKecamatan();
    readJsonKodePos();
    readJsonNegara();
  }

  getStringValuesSF() async {
    prefs = Get.find<DataController>().prefs;
    alamatController.text = prefs!.getString('alamat') ?? "";
    rtController.text = prefs!.getString('rt') ?? "";
    rwController.text = prefs!.getString('rw') ?? "";
    provinsiController.text = prefs!.getString('provinsi') ?? "";
    kotaController.text = prefs!.getString('kota') ?? "";
    kecamatanController.text = prefs!.getString('kecamatan') ?? "";
    desaKelurahanController.text = prefs!.getString('desa') ?? "";
    kodePosController.text = prefs!.getString('kodePos') ?? "";
    alamatDomisilinController.text = prefs!.getString('alamatDomisili') ?? "";
    negaraController.text = prefs!.getString('negaraDomisili') ?? "";
  }

  // Fetch json provinsi from the json file
  Future<void> readJsonProvinsi() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/provinsi.json');
    final data = await json.decode(response);
    listProvinsi = data["regions"];
  }

  // Fetch json kota from the json file
  Future<void> readJsonKota() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kota.json');
    final data = await json.decode(response);
    listKota = data["regions"];
  }

  // Fetch json kecamatan from the json file
  Future<void> readJsonKecamatan() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kecamatan.json');
    final data = await json.decode(response);
    listKecamatan = data["regions"];
  }

  // Fetch json kodepos from the json file
  Future<void> readJsonKodePos() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kodepos.json');
    final data = await json.decode(response);
    listKodePos = data["regions"];
  }

  Future<void> readJsonNegara() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/codePhone.json');
    final data = await json.decode(response);
    listNegara = data["phoneCode"];
  }

  void saveAlamatIndonesia() {
    final AlamatIndonesiaModel newAlamatIndonesia;
    newAlamatIndonesia = AlamatIndonesiaModel(
        alamatController.text,
        rtController.text,
        rwController.text,
        provinsiController.text,
        kotaController.text,
        kecamatanController.text,
        desaKelurahanController.text,
        kodePosController.text);

    // print(newAlamatIndonesia.alamat);
    preferencesAlamatIndonesia.saveAlamatIndonesia(newAlamatIndonesia);
  }

  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void askPermissionLocation() {
    requestPermission(Permission.location).then(_onStatusRequestedLocation);
  }

  void _onStatusRequestedLocation(status) {
    if (status == PermissionStatus.granted) {
      getCountryCode();
    } else {
      openAppSettings();
    }
  }

  Future getCountryCode() async {
    CustomLoading().showLoading("Memuat Data");
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // debugPrint('location: ${position.latitude}');
    // final coordinates = Coordinates(position.latitude, position.longitude);
    // var addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    negara = placemarks[0].country.toString(); // this will return country name
    // debugPrint('negara: $negara');
    String? codeNegara = placemarks[0].isoCountryCode;
    // debugPrint('negara: $codeNegara');
    CustomLoading().dismissLoading();

    alamatDomisilinController.text = placemarks[0].street.toString();
    isLoadingCountry = false;
    update();
  }

  void saveAlamatLuarIndonesia() {
    final AlamatLuarIndonesiaModel newAlamatLuarIndonesia;
    newAlamatLuarIndonesia = AlamatLuarIndonesiaModel(
        alamatController.text,
        rtController.text,
        rwController.text,
        provinsiController.text,
        kotaController.text,
        kecamatanController.text,
        desaKelurahanController.text,
        kodePosController.text,
        alamatDomisilinController.text,
        negaraController.text);
    // print(newAlamatLuarIndonesia.alamat);
    preferencesAlamatLuarIndonesia.saveAlamatLuarIndonesia(newAlamatLuarIndonesia);
  }
}
