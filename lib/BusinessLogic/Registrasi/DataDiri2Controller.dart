import 'dart:convert';

import 'package:eform_modul/main.dart';
import 'package:eform_modul/response_model/data_diri1_model_pref.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/dropdown.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

import '../../src/components/list-error.dart';
import '../../src/components/theme_const.dart';
import '../../src/models/kumpulan_list.dart';
import '../../src/utility/Routes.dart';
import 'DataController.dart';

class DataDiri2Controller extends GetxController {
  TextEditingController religionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String errorCode = '';
  TextEditingController genderController = TextEditingController();
  TextEditingController publisherCityController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController landlineNumberController = TextEditingController();
  TextEditingController npwpController = TextEditingController();
  TextEditingController prefixLandlineNumber = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighbourhoodController = TextEditingController();
  TextEditingController hamletController = TextEditingController();
  TextEditingController urbanVillageController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController subDistrictController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController overseasAddressController = TextEditingController();
  bool validationButton = false;

  String selectedReligion = '';
  String selectedGender = '';
  String selectedStatus = '';
  String selectedProvince = '';

  String selectedCity = '';
  String selectedSubDistrict = '';
  String selectedPostalCode = '';

  List provinceList = [];
  List cityList = [];
  List subDistrictList = [];
  List postalCodeList = [];
  List countryList = [];
  SharedPreferences? prefs;

  String countryCode = '';

  String errormessage = '';

  final formKey = GlobalKey<FormState>();

  // AutovalidateMode? checkErrorCode(String name, String errorCode) {
  //   switch (name) {
  //     case "name":
  //       if (errorCode == '9015' ||
  //           errorCode == '9017' ||
  //           errorCode == '9019' ||
  //           errorCode == '9021') {
  //         return AutovalidateMode.always;
  //       }
  //       return AutovalidateMode.onUserInteraction;
  //     case "dob":
  //       if (errorCode == '9016' ||
  //           errorCode == '9017' ||
  //           errorCode == '9020' ||
  //           errorCode == '9021') {
  //         return AutovalidateMode.always;
  //       }
  //       return AutovalidateMode.onUserInteraction;

  //     case "bop":
  //       if (errorCode == '9018' ||
  //           errorCode == '9019' ||
  //           errorCode == '9020' ||
  //           errorCode == '9021') {
  //         return AutovalidateMode.always;
  //       }
  //       return AutovalidateMode.onUserInteraction;
  //     default:
  //       return AutovalidateMode.onUserInteraction;
  //   }
  // }

  String? validatorFormField(String? val, String? name) {
    switch (name) {
      case "publiserCity":
        if (val!.isEmpty) {
          return 'Kota Penerbit Identitas tidak boleh kosong';
        }
        if (val.length < 3 || val.length > 25) {
          return 'Kota Penerbit Identitas minimal 3 maksimal 25 karakter';
        }
        if (isAlpha(val) == false && contains(val, ' ') == false) {
          return 'Kota Penerbit Identitas hanya boleh menggunakan huruf dan spasi';
        }
        return null;
      // case "name":
      //   if (errorCode == '9015' ||
      //       errorCode == '9017' ||
      //       errorCode == '9019' ||
      //       errorCode == '9021') {
      //     return 'Data yang diisi belum valid dengan nomor identitas yang digunakan';
      //   }
      //   return null;

      // case "dateOfBirth":
      //   if (errorCode == '9016' ||
      //       errorCode == '9017' ||
      //       errorCode == '9020' ||
      //       errorCode == '9021') {
      //     return 'Data yang diisi belum valid dengan nomor identitas yang digunakan';
      //   }
      //   return null;

      // case "birthPlace":
      //   final regex = RegExp(r'^[a-zA-Z.,-_]+$');
      //   if (errorCode == '9016' ||
      //       errorCode == '9017' ||
      //       errorCode == '9020' ||
      //       errorCode == '9021') {
      //     return 'Data yang diisi belum valid dengan nomor identitas yang digunakan';
      //   }
      //   if (val!.isEmpty) {
      //     return 'Tempat lahir tidak boleh kosong';
      //   }
      //   if (val.length < 3) {
      //     return 'Tempat lahir minimal 3 karakter';
      //   }

      //   if (regex.hasMatch(val.replaceAll(' ', '')) == false) {
      //     return 'Tempat lahir hanya boleh menggunakan huruf, spasi, symbol -_,.'
      //         '';
      //   }
      //   return null;
      case "email":
        if (val!.isEmpty) {
          return 'Alamat email tidak boleh kosong';
        }
        if (isEmail(val) == false) {
          return 'Alamat email tidak sesuai format';
        }
        return null;
      case "landlineCode":
        if (val!.isEmpty && landlineNumberController.text != '') {
          return "Kode area tidak boleh kosong";
        }
        if (val.isNotEmpty) {
          if (val.length < 2 || val.length > 4) {
            return 'Kode area minimal 2 maksimal 4 karakter';
          }
        }
        return null;
      case "landlineNumber":
        if (val!.isEmpty && prefixLandlineNumber.text != '') {
          return 'Nomor telepon tidak boleh kosong';
        }
        if (val.isNotEmpty) {
          if (val.length < 5 || val.length > 13) {
            return 'Nomor telepon minimal 5 karakter maksimal 13 karakter';
          }
        }
        return null;
      case "npwp":
        if (val!.length != 15 && val.isNotEmpty) {
          return 'NPWP harus 15 karakter';
        }
        return null;
      case "motherName":
        if (val!.isEmpty) {
          return 'Nama Ibu Kandung tidak boleh kosong';
        }
        if (val.length < 3) {
          return 'Nama Ibu Kandung minimal 3 karakter';
        }
        if (isAlpha(val) == false && contains(val, ' ') == false) {
          return 'Nama Ibu Kandung hanya boleh menggunakan huruf dan spasi';
        }
        return null;
      case "address":
        if (val!.isEmpty) {
          return 'Alamat tidak boleh kosong';
        }
        if (val.length < 3 || val.length > 100) {
          return 'Alamat minimal 3 dan maksimal 100 karakter';
        }
        return null;
      case "rt":
        if (val!.isEmpty) {
          return 'RT tidak boleh kosong';
        }
        if (val.length > 3) {
          return 'RT maksimal 3 angka';
        }
        return null;
      case "rw":
        if (val!.isEmpty) {
          return 'RW tidak boleh kosong';
        }
        if (val.length > 3) {
          return 'RW maksimal 3 angka';
        }
        return null;
      case "village":
        if (val!.isEmpty) {
          return 'Desa/Kelurahan tidak boleh kosong';
        }
        if (val.length < 2 || val.length > 30) {
          return 'Alamat minimal 2 dan maksimal 30 karakter';
        }
        return null;
      case "domicile":
        if (val!.isEmpty) {
          return 'Alamat Domisili tidak boleh kosong';
        }
        if (val.length < 3 || val.length > 100) {
          return 'Alamat minimal 3 dan maksimal 100 karakter';
        }
        return null;
      case "landlineNumber":
        if (prefixLandlineNumber.text != '' && val!.isEmpty) {
          return "Nomor Telepon tidak boleh kosong";
        }
        if (val!.isNotEmpty) {
          if (val.length < 5 || val.length > 8) {
            return 'Nomor Telepon minimal 5 maksimal 8 karakter';
          }
        }
        return null;
      case "postalCode":
        if (val!.isEmpty) {
          return "Kode Pos tidak boleh kosong";
        }
        return null;
      case "district":
        if (val!.isEmpty) {
          return "Kecamatan tidak boleh kosong";
        }
        return null;
      case "city":
        if (val!.isEmpty) {
          return "Kota/Kabupaten tidak boleh kosong";
        }
        return null;
      case "province":
        if (val!.isEmpty) {
          return "Provinsi tidak boleh kosong";
        }
        return null;
      case "marital":
        if (val!.isEmpty) {
          return "Status Perkawinan tidak boleh kosong";
        }
        return null;
      case "religion":
        if (val!.isEmpty) {
          return "Agama tidak boleh kosong";
        }
        return null;
      case "gender":
        if (val!.isEmpty) {
          return "Jenis Kelamin tidak boleh kosong";
        }
        return null;
      case "country":
        if (val!.isEmpty) {
          return "Negara Domisili tidak boleh kosong";
        }
        return null;
      default:
        return null;
    }
  }

  Future<void> dropDownOntap(String name, BuildContext context) async {
    switch (name) {
      case "gender":
        final temp = genderController;
        final result = await showDialog(
            context: context,
            builder: (_) => DropDownFormField(
                items: jeniskelaminList,
                labelText: "Pilih Jenis Kelamin",
                selectedValue: genderController,
                param: "1"));

        if (result != null) {
          if (temp != result.desc) {
            selectedGender = result.id;
          }
        }
        break;
      case "religion":
        final temp = religionController;
        final result = await showDialog(
            context: context,
            builder: (_) => DropDownFormField(
                items: agamaList,
                labelText: "Pilih Agama",
                selectedValue: religionController,
                param: "1"));

        if (result != null) {
          if (temp != result.desc) {
            selectedReligion = result.id;
          }
        }
        break;
      case "marital":
        final temp = maritalStatusController;
        final result = await showDialog(
            context: context,
            builder: (_) => DropDownFormField(
                items: statusPerkawinanList,
                labelText: "Pilih Status Perkawinan",
                selectedValue: maritalStatusController,
                param: "1"));
        if (result != null) {
          if (temp != result.desc) {
            selectedStatus = result.id;
          }
        }
        break;
      case "province":
        final temp = provinceController;
        final result = await showDialog(
            context: context,
            builder: (_) => DropDownFormField(
                items: provinceList,
                labelText: "Pilih Provinsi",
                selectedValue: provinceController,
                data: 'provinsi',
                param: "2"));
        if (result != null) {
          if (temp != result['provinsi']) {
            selectedProvince = result['id'];
            subDistrictController.clear();
            cityController.clear();
            postalCodeController.clear();
            update();
          }
        }
        break;
      case "city":
        final temp = cityController;
        if (provinceController.text.isEmpty) {
          break;
        }
        List listkotaFilter = cityList
            .where((x) => x['idprovinsi'].toLowerCase() == provinceController.text.toLowerCase())
            .toList();
        final result = await showDialog(
            context: context,
            builder: (_) => DropDownFormField(
                items: listkotaFilter,
                labelText: "Pilih Kota",
                selectedValue: cityController,
                data: 'kota',
                param: "2"));
        if (result != null) {
          if (temp != result['kota']) {
            selectedCity = result['idkota'];
            postalCodeController.clear();
            subDistrictController.clear();
            update();
          }
        }
        break;
      case "district":
        final temp = subDistrictController;
        if (cityController.text.isEmpty) {
          break;
        }
        List listkecamatanFilter = subDistrictList
            .where((x) => x['idkota'].toLowerCase() == cityController.text.toLowerCase())
            .toList();
        final result = await showDialog(
            context: context,
            builder: (_) => DropDownFormField(
                items: listkecamatanFilter,
                labelText: "Pilih Kecamatan",
                selectedValue: subDistrictController,
                data: 'kecamatan',
                param: "2"));
        if (result != null) {
          if (temp != result['kecamatan']) {
            selectedSubDistrict = result['idkecamatan'];
            postalCodeController.clear();
            update();
          }
        }
        break;
      case "postalCode":
        final temp = postalCodeController;
        if (subDistrictController.text.isEmpty) {
          break;
        }
        List listkodePosFilter = postalCodeList
            .where(
                (x) => x['idkecamatan'].toLowerCase() == subDistrictController.text.toLowerCase())
            .toList();
        final result = await showDialog(
          context: context,
          builder: (_) => DropDownFormField(
              items: listkodePosFilter,
              labelText: "Pilih Kode Pos",
              selectedValue: postalCodeController,
              data: 'kodepos',
              param: "2"),
        );
        if (result != null) {
          if (temp != result['kodepos']) {
            selectedPostalCode = result['idkodepos'];
            update();
          }
        }
        break;
      case "country":
        final temp = countryController;
        final result = await showDialog(
          context: context,
          builder: (_) => DropDownFormField(
              items: countryList,
              labelText: "Pilih Negara",
              selectedValue: countryController,
              data: 'name',
              param: "2"),
        );
        if (result != null) {
          if (temp != result['name']) {
            countryController.text = result['name'];
          }
        }
        break;
      default:
    }
  }

  @override
  onInit() {
    initData();
    super.onInit();
  }

  initData() {
    readProvinceJson();
    readCityJson();
    readSubDistrictJson();
    readPostalCodeJson();
    readCountryJson();
  }

  // Fetch json provinsi from the json file
  Future<void> readProvinceJson() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/provinsi.json');
    final data = await json.decode(response);
    provinceList = data["regions"];
  }

  // Fetch json kota from the json file
  Future<void> readCityJson() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kota.json');
    final data = await json.decode(response);
    cityList = data["regions"];
    // print(cityList);
  }

  // Fetch json kecamatan from the json file
  Future<void> readSubDistrictJson() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kecamatan.json');
    final data = await json.decode(response);
    subDistrictList = data["regions"];
  }

  // Fetch json kodepos from the json file
  Future<void> readPostalCodeJson() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/kodepos.json');
    final data = await json.decode(response);
    postalCodeList = data["regions"];
  }

  Future<void> readCountryJson() async {
    final String response = await rootBundle.loadString('assets/jsonfiles/codePhone.json');
    final data = await json.decode(response);
    countryList = data["phoneCode"];
  }

  // DataDiri1ModelPref? get dataDiri1Pref {
  //   prefs = Get.find<DataController>().prefs;
  //   return DataDiri1ModelPref.fromJson(
  //       jsonDecode(prefs!.getString('datadiri1prefs')!));
  // }
  getStringValuesSF() async {
    if (prefs == null) prefs = Get.find<DataController>().prefs;
    Future.delayed(Duration(seconds: 1), () async {
      String temp = '';
      int index = 0;
      var inputFormat = DateFormat('yyyy-MM-dd');
      var inputDate = inputFormat.parse(prefs!.getString('tanggalLahir') ?? "");
      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(inputDate);

      dobController.text = '$outputDate';
      // print('Ini adalah Tanggal lahir' + dobController.text);
      if (prefs!.getString('nomorHandphone') != '') {
        phoneNumberController.text =
            '+' + prefs!.getString('dialCodeNegara')! + prefs!.getString('nomorHandphone')!;
      }

      nameController.text = prefs!.getString("namaSesuaiKTP") ?? "";

      publisherCityController.text = prefs!.getString("kotaPenerbitIdentitas") ?? "";

      birthPlaceController.text = prefs!.getString("tempatLahir") ?? "";

      temp = prefs!.getString("jenisKelamin") ?? "";
      if (temp != "") {
        index = jeniskelaminList.indexWhere((e) => e.id == temp);
        genderController.text = jeniskelaminList[index].desc;
        temp = prefs!.getString("agama") ?? "";
        index = agamaList.indexWhere((e) => e.id == temp);
        religionController.text = agamaList[index].desc;
        temp = prefs!.getString("statusPerkawinan") ?? "";
        index = statusPerkawinanList.indexWhere((e) => e.id == temp);
        maritalStatusController.text = statusPerkawinanList[index].desc;
        temp = prefs!.getString('provinsi') ?? "";
        index = provinceList.indexWhere((e) => e['id'] == temp);
        provinceController.text = provinceList[index]['provinsi'];
        temp = prefs!.getString('kota') ?? "";
        index = cityList.indexWhere((e) => e['idkota'] == temp);
        cityController.text = cityList[index]['kota'];
        temp = prefs!.getString('kecamatan') ?? "";
        index = subDistrictList.indexWhere((e) => e['idkecamatan'] == temp);
        subDistrictController.text = subDistrictList[index]['kecamatan'];
        temp = prefs!.getString('kodePos') ?? "";
        index = postalCodeList.indexWhere((e) => e['idkodepos'] == temp);
        postalCodeController.text = postalCodeList[index]['kodepos'];
      }
      urbanVillageController.text = prefs!.getString('desa') ?? "";
      addressController.text = prefs!.getString('alamat') ?? "";
      neighbourhoodController.text = prefs!.getString('rt') ?? "";
      hamletController.text = prefs!.getString('rw') ?? "";

      emailController.text = prefs!.getString("email") ?? "";
      npwpController.text = prefs!.getString("npwp") ?? "";
      if (prefs!.getString('noTelpRumah') != '99999999') {
        landlineNumberController.text = prefs!.getString("noTelpRumah") ?? "";
        prefixLandlineNumber.text = prefs!.getString("prefixnoTelpRumah") ?? "";
      }
      countryCode = prefs!.getString('indexPosisi') ?? "1";

      motherNameController.text = prefs!.getString("namaIbuKandung") ?? "";

      if (prefs!.getString('indexPosisi') == '2') {
        countryController.text = prefs!.getString('negaraDomisili') ?? "";
        overseasAddressController.text = prefs!.getString('alamatDomisili') ?? "";
      }
    });

    if (cityController.text.isNotEmpty) {
      validationButton = true;
    }

    // errorCode = prefs!.getString('errorCode') ?? "";
    // if (errorCode != '') {
    //   var result = ListError().validateErrorMessage(errorCode);

    //   errormessage = result;
    //   // errorMessage(errormessage);
    // }
  }

  addStringToSF() async {
    prefs!.setString("namaSesuaiKTP", nameController.text);
    prefs!.setString("kotaPenerbitIdentitas", publisherCityController.text);
    // print('ini publisher city : ' + publisherCityController.text);
    prefs!.setString("tempatLahir", birthPlaceController.text);
    prefs!.setString('alamat', addressController.text);
    prefs!.setString('rt', neighbourhoodController.text);
    prefs!.setString('rw', hamletController.text);
    prefs!.setString('desa', urbanVillageController.text);

    if (selectedGender != '') {
      prefs!.setString("jenisKelamin", selectedGender);
      prefs!.setString("agama", selectedReligion);
      prefs!.setString("statusPerkawinan", selectedStatus);
      prefs!.setString('provinsi', selectedProvince);
      prefs!.setString('kota', selectedCity);
      prefs!.setString('kecamatan', selectedSubDistrict);
      prefs!.setString('kodePos', selectedPostalCode);
    }

    prefs!.setString("email", emailController.text);
    // prefs!.setString("npwp", npwpController.text);
    if (npwpController.text == '' || npwpController.text.isEmpty) {
      prefs!.setString("npwp", '999999999999999');
    } else {
      prefs!.setString("npwp", npwpController.text);
    }
    // prefs!.setString("noTelpRumah", landlineNumberController.text);
    if (landlineNumberController.text == '' || landlineNumberController.text.isEmpty) {
      prefs!.setString("noTelpRumah", '99999999');
    } else {
      prefs!.setString("noTelpRumah", landlineNumberController.text);
    }
    prefs!.setString("prefixnoTelpRumah", prefixLandlineNumber.text);
    prefs!.setString("namaIbuKandung", motherNameController.text);

    if (prefs!.getString('indexPosisi') == '2') {
      prefs!.setString('alamatDomisili', overseasAddressController.text);
      prefs!.setString('negaraDomisili', countryController.text);
    }
  }

  Widget seperator(double height) {
    return SizedBox(
      height: Get.height * height,
    );
  }

  List<TextEditingController> get controllerList => [
        publisherCityController,
        religionController,
        genderController,
        emailController,
        maritalStatusController,
        motherNameController,
        addressController,
        subDistrictController,
        urbanVillageController,
        provinceController,
        cityController,
        postalCodeController,
        hamletController,
        neighbourhoodController,
      ];

  void Function()? onchanged() {
    // if (cityController.text.isEmpty) {
    //   return null;
    // }
    return () {
      if (controllerList.map((e) => e.text.isNotEmpty).contains(true)) {
        validationButton = formKey.currentState!.validate();
        update();
      }
    };
  }

  // Future errorMessage(BuildContext context, String errormessage) async {
  //   return showDialog(
  //       context: context,
  //       builder: (_) => PopoutWrapContent(
  //             textTitle: '',
  //             button_radius: 4,
  //             buttonText: 'Ok,saya Mengerti',
  //             ontap: () {
  //               Get.back();
  //             },
  //             content: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Center(
  //                   child:
  //                       SvgPicture.asset('assets/images/icons/bell_icon.svg'),
  //                 ),
  //                 SizedBox(
  //                   height: 8,
  //                 ),
  //                 Text(
  //                   'Mohon Maaf',
  //                   style: PopUpTitle,
  //                 ),
  //                 SizedBox(
  //                   height: 12,
  //                 ),
  //                 Text(
  //                   errormessage,
  //                   style: infoStyle,
  //                   textAlign: TextAlign.center,
  //                 )
  //               ],
  //             ),
  //           ));
  // }

  checkProgress() {
    addStringToSF();
    // print('errorCode : ' + errorCode);
    // print('indexPosisi : ' + countryCode);
    Get.offNamed(Routes().pekerjaan);
  }
}
