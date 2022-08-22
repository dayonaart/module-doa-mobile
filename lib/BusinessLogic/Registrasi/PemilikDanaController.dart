import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/dropdown.dart';
import 'package:eform_modul/src/models/pemilik-dana-model.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/pemilik-dana-page/pemilikdana_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemilikDanaController extends GetxController {
  TextEditingController patronRelationship = TextEditingController();
  TextEditingController patronName = TextEditingController();
  TextEditingController patronAddress = TextEditingController();
  TextEditingController patronPhoneNumber = TextEditingController();

  String selectedPatronRelationship = '';
  bool validationButton = false;

  SharedPreferences? prefs;
  final formKey = GlobalKey<FormState>();

  getStringValuesToSF() async {
    prefs = Get.find<DataController>().prefs;
    int index = 0;
    selectedPatronRelationship = prefs!.getString("hubunganPemberiDana") ?? '';
    patronName.text = prefs!.getString("namaPemilikDana") ?? '';
    patronAddress.text = prefs!.getString("alamatPemilikDana") ?? '';
    patronPhoneNumber.text = prefs!.getString("telpPemilikDana") ?? '';

    if (selectedPatronRelationship != '') {
      index =
          hubunganPemberiDanaList.indexWhere((element) => element.id == selectedPatronRelationship);
      patronRelationship.text = hubunganPemberiDanaList[index].desc;
      validationButton = true;
    }
  }

  addStringToSF() async {
    prefs!.setString("hubunganPemberiDana", selectedPatronRelationship);
    prefs!.setString("namaPemilikDana", patronName.text);
    prefs!.setString("alamatPemilikDana", patronAddress.text);
    prefs!.setString("telpPemilikDana", patronPhoneNumber.text);
  }

  Future<void> dropDownOnTap(String name, BuildContext context) async {
    switch (name) {
      case "relationship":
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) => DropDownFormField(
            items: hubunganPemberiDanaList,
            labelText: 'Hubungan Pemberi Dana',
            selectedValue: patronRelationship,
            param: '1',
          ),
        );
        if (result != null) {
          selectedPatronRelationship = result.id;
        }
        break;
      default:
        break;
    }
  }

  String? validator(String name, String value) {
    switch (name) {
      case 'relationship':
        if (value.isEmpty) {
          return 'Hubungan Pemberi Dana tidak boleh kosong';
        }
        return null;
      case 'name':
        if (value.isEmpty) {
          return 'Nama Pemilik Dana tidak boleh kosong';
        } else if (value.length < 5 || value.length > 60) {
          return 'Nama Pemilik Dana minimal 5 dan maksimal 60 karakter';
        } else if (regexWord.hasMatch(value.replaceAll(' ', '')) == false) {
          return 'Nama hanya boleh menggunakan huruf dan spasi';
        }
        return null;
      case "address":
        if (value.isEmpty) {
          return 'Alamat Pemilik Dana tidak boleh kosong';
        } else if (value.length < 5 || value.length > 40) {
          return 'Alamat Pemilik Dana minimal 5 dan maksimal 40 karakter';
        } else if (regexWordSymbol.hasMatch(value.replaceAll(' ', '')) == false) {
          return 'Alamat hanya boleh menggunakan huruf, spasi, symbol -_,.';
        }
        return null;
      case "phoneNumber":
        if (value.isEmpty) {
          return 'No. Telepon Pemilik Dana tidak boleh kosong';
        } else if (value.length < 8 || value.length > 13) {
          return 'No. Telepon Pemilik Dana minimal 8 dan maksimal 13 karakter';
        } else if (regexNumber.hasMatch(value.replaceAll(' ', '')) == false) {
          return 'No. Telepon Pemilik Dana hanya boleh menggunakan angka';
        }
        return null;

      default:
        return null;
    }
  }

  navigatorPage() {
    SharedPreferences prefs = Get.find<DataController>().prefs;
    if (prefs.getString('indexPosisi') == '1') {
      Get.offNamed(Routes().pemilihanCabangIndonesia);
    } else {
      Get.offNamed(Routes().pemilihanCabangLuar);
    }
  }

  void Function()? onchanged() {
    return () {
      validationButton = formKey.currentState!.validate();
      update();
    };
  }
}
