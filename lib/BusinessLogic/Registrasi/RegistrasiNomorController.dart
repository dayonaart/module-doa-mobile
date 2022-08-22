import 'dart:convert';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/models/posisi_list.dart';
import '../../src/utility/custom_loading.dart';

class RegistrasiNomorController extends GetxController {
  SharedPreferences? prefs;
  TextEditingController dialCodePhoneNumber = TextEditingController(text: "+62");
  final TextEditingController bodyNumberPhone = TextEditingController();
  TextEditingController positionController = TextEditingController();
  final TextEditingController ktpName = TextEditingController();
  var lockCountry = null;
  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  String? valNumber, valPosition, output;
  String? pathFlagUrl;
  String? countryName;
  // bool isLoadingCountry = false;
  bool? warningHasAppeared;
  PosisiList? result;
  List<Placemark> placemarks = [];

  List idPosition = [];
  List nameCountry = [];
  List nameSearch = [];
  List dialCode = [];
  List flagUrl = [];
  List code = [];
  List object = [];
  List indexResult = [];
  List tempData = [];
  List tempDataList = [];
  int? currentSelectedIndex;
  TextEditingController search = TextEditingController();
  bool disable = false;
  final formKey = GlobalKey<FormState>();

  String country = "";
  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  validasi(String? val) {
    try {
      if (val!.length < 5) {
        disable = false;
        update();
      }
      disable = true;
      update();
    } catch (e) {
      return;
    }
  }

  Future saveCountry(int selectedIndex) async {
    final preferences = Get.find<DataController>().prefs;

    pathFlagUrl = flagUrl[indexResult[selectedIndex]];
    countryName = nameCountry[indexResult[selectedIndex]];
    dialCodePhoneNumber.text = dialCode[indexResult[selectedIndex]];
    preferences.setString('selectedFlagCountry', flagUrl[indexResult[selectedIndex]]);
    preferences.setString('selectedCountryName', nameCountry[indexResult[selectedIndex]]);
    preferences.setString('dialCodeNegara', dialCode[indexResult[selectedIndex]]);
    print(preferences.getString('selectedCountryName'));

    update();
  }

  Future defaultSaveCountry(int selectedIndex) async {
    final preferences = Get.find<DataController>().prefs;
    pathFlagUrl = flagUrl[selectedIndex];
    currentSelectedIndex = selectedIndex;
    countryName = nameCountry[selectedIndex];
    dialCodePhoneNumber.text = dialCode[selectedIndex];
    preferences.setString('selectedFlagCountry', flagUrl[selectedIndex]);
    preferences.setString('selectedCountryName', nameCountry[selectedIndex]);
    preferences.setString('dialCodeNegara', dialCode[selectedIndex]);
    print(preferences.getString('selectedFlagCountry'));
    update();
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
        idPosition.add(object[i]['idposisi']);
        nameCountry.add(object[i]['name']);
        nameSearch.add(object[i]['name'].toString().toLowerCase());
        dialCode.add(object[i]['dial_code']);
        flagUrl.add("assets/images/bendera/${object[i]['code']}.png".toLowerCase());
        code.add(object[i]['code']);
      }
      //print(flagUrl);

      CustomLoading().dismissLoading();
    }
  }

  Future saveSharedPref() async {
    final preferences = Get.find<DataController>().prefs;
    if (bodyNumberPhone.text.isNotEmpty) {
      //dengan counrtycode
      preferences.setString('nomorHandphone', bodyNumberPhone.text);
      print(bodyNumberPhone.text);
      //tanpa countrycode
      preferences.setString('tempNomorHandphone', bodyNumberPhone.text);
      preferences.setString('dialCodeNegara', dialCodePhoneNumber.text.substring(1));
      preferences.setString('indexPosisi', valPosition!);
      print('Ini Val Posisi' + valPosition.toString());
    }
  }

  void askPermissionLocation() {
    requestPermission(Permission.location).then((value) async {
      await _onStatusRequestedLocation(value);
    });
  }

  Future<void> _onStatusRequestedLocation(status) async {
    // setState(() {
    //   isLoadingCountry = true;
    // });
    CustomLoading().showLoading("Memuat Data");
    if (status == PermissionStatus.granted) {
      print('1');
      await getCountryName();
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.location.status.isGranted == false) {
              // openAppSettings();
              print('2');
              askPermissionLocation(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      print('3');
      print(status);
      askPermissionLocation();
    }
    CustomLoading().dismissLoading();
  }

  Future getCountryName() async {
    try {
      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      debugPrint('location latitude: ${position.latitude}');
      debugPrint('location longitude: ${position.longitude}');
      // final coordinates = Coordinates(position.latitude, position.longitude);
      // var addresses =
      //     await Geocoder.local.findAddressesFromCoordinates(coordinates);

      placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      // await placemarkFromCoordinates(60.2090667, 97.4608483);
      country = placemarks[0].country.toString(); // this will return country name
      debugPrint('negara: $country');
      String? codeNegara = placemarks[0].isoCountryCode;
      debugPrint('negara: $codeNegara');
    } catch (e) {
      getCountryName();
      print(e);
    }
  }

  Future getSharedPref() async {
    prefs = Get.find<DataController>().prefs;
    pathFlagUrl = prefs!.getString('selectedFlagCountry');
    countryName = prefs!.getString('selectedCountryName');
    print('this is pathFlag $pathFlagUrl');
    output = prefs!.getString('indexPosisi') ?? "";
    print(output);
    if (output == '2') {
      positionController.text = 'Luar Indonesia';
    } else {
      positionController.text = 'Indonesia';
    }
    bodyNumberPhone.text = prefs!.getString('tempNomorHandphone') ?? "";
    if (bodyNumberPhone.text == "") {
      disable = true;
    }
    lockCountry = ['ID'];
    valPosition = '1';
    print(valPosition);
    update();
  }

  bool validationButton = false;

  onchanged(bool validation) {
    validationButton = validation;
    print(validationButton);
    update();
  }
}
