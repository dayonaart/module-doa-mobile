import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/GetCabang.dart';

class CabangController extends GetxController {
  List provinceList = [];
  List cityList = [];
  List officeList = [];
  List biCodeList = [];
  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController office = TextEditingController();
  TextEditingController address = TextEditingController();
  String selectedCity = "";
  String selectedProvince = "";
  String selectedOffice = "";
  String selectedBICode = "";
  int index = 0;
  SharedPreferences? prefs;
  final formGlobalKey = GlobalKey<FormState>();
  bool validationButton = false;

  @override
  onInit() {
    initCabang();
    super.onInit();
  }

  initCabang() async {
    provinceList = await GetCabang().readJsonProvinsi();
    cityList = await GetCabang().readJsonKota();
    officeList = await GetCabang().readJsonKantor();
    biCodeList = await GetCabang().readJsonBi();
    if (kDebugMode) {
      // print("Done init Cabang");
    }
  }

  Future<void> dropDownOntap(String name, BuildContext context) async {
    switch (name) {
      case "province":
        final temp = province.text;
        final response = await showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return DropDownFormField(
              items: provinceList,
              labelText: 'Provinsi',
              selectedValue: province,
              data: ('provinsi'),
              param: "2",
            );
          },
        );

        if (response != null) {
          if (response['provinsi'] != temp) {
            city.clear();
            office.clear();
            address.clear();
            selectedProvince = response['id'];
            update();
          }
        }
        break;

      case "city":
        if (province.text.isNotEmpty) {
          List cityListFilter = cityList
              .where((x) => x['idprovinsi'].toLowerCase().contains(province.text.toLowerCase()))
              .toList();
          final temp = city.text;
          final response = await showDialog(
            context: context,
            builder: (BuildContext buildContext) {
              return DropDownFormField(
                  items: cityListFilter,
                  labelText: 'Kota',
                  selectedValue: city,
                  data: ('idkota'),
                  param: "2");
            },
          );

          if (response != null) {
            if (response['kota'] != temp) {
              office.clear();
              address.clear();
              selectedCity = response['kota'];
              update();
            }
          }
        }
        break;

      case "office":
        if (city.text.isNotEmpty) {
          //Filter list kota sesuai dengan provinsi yang dipilih
          List officeListFilter = officeList
              .where((x) => x['kota'].toLowerCase().contains(city.text.toLowerCase()))
              .toList();
          final temp = office.text;
          var response = await showDialog(
            context: context,
            builder: (BuildContext buildContext) {
              return DropDownFormField(
                  items: officeListFilter,
                  labelText: 'Nama Outlet',
                  selectedValue: office,
                  data: ('namaoutlet'),
                  param: "2");
            },
          );

          if (response != null) {
            address.text = response["alamat"];
            List biCodeListFilter =
                biCodeList.where((x) => x['SANDI_BNI'].contains(response["kodeoutlet"])).toList();
            update();

            saveSharedPref(biCodeList, response, biCodeListFilter);
          }
        }
        break;
      default:
        break;
    }
  }

  String? validator(String name) {
    switch (name) {
      case "province":
        if (province.text.isEmpty) {
          return 'Pilih Provinsi';
        }
        return null;
      case "city":
        if (city.text.isEmpty) {
          return 'Pilih Kota';
        }
        return null;
      case "office":
        if (office.text.isEmpty) {
          return 'Pilih Kantor Cabang';
        }
        return null;
      default:
        return null;
    }
  }

  Future getStringValuesSF() async {
    prefs = Get.find<DataController>().prefs;
    selectedProvince = prefs!.getString("provinsiCabang")!;
    selectedCity = prefs!.getString("kotaCabang")!;
    selectedOffice = prefs!.getString("kantorCabang")!;
    address.text = prefs!.getString("alamatCabang")!;

    // print("cek");
    // print(selectedProvince);
    // print(selectedCity);
    // print(selectedOffice);

    if (selectedProvince.isNotEmpty) {
      index = provinceList.indexWhere((element) => element["id"] == selectedProvince);
      province.text = provinceList[index]['provinsi'];
      index = cityList.indexWhere((element) => element["idkota"] == selectedCity);
      city.text = cityList[index]['kota'];
      index = officeList.indexWhere((element) => element["kodeoutlet"] == selectedOffice);
      office.text = officeList[index]['namaoutlet'];
    }
    // print('status' + validationButton.toString());
    // if (address.text.isNotEmpty) {
    //   validationButton = true;
    //   print(address.text);
    //   print('button status ' + validationButton.toString());
    // }
  }

  saveSharedPref(List listKode, var response, List biCodeListFilter) async {
    final preferences = prefs;
    preferences!.setString('sandiBI', listKode[0]["SANDI_BI"].toString());
    preferences.setString('kotaBI', listKode[0]["KOTA"].toString());
    preferences.setString('namaOutlet', response["namaoutlet"].toString());
    preferences.setString('kodeOutlet', response["kodeoutlet"].toString());
    preferences.setString('alamatOutlet', response["alamat"].toString());
    // print(biCodeListFilter);
    // print(biCodeListFilter[0]["SANDI_BI"].toString());
    // print(biCodeListFilter[0]["KOTA"].toString());
    // print(response);
    // print(response["namaoutlet"].toString());
    // print(response["kodeoutlet"].toString());
    // print(response["alamat"].toString());

    // print(selectedProvince);
    preferences.setString("provinsiCabang", selectedProvince);
    preferences.setString("kotaCabang", selectedCity);
    preferences.setString("kantorCabang", response['kodeoutlet']);
    preferences.setString("alamatCabang", address.text);
  }

  void Function()? onchanged() {
    return () {
      validationButton = formGlobalKey.currentState!.validate();
      // print(validationButton);
      update();
    };
  }
}
