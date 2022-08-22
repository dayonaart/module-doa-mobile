import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkDetailController extends GetxController {
  TextEditingController jobDetail = TextEditingController(),
      jobPlace = TextEditingController(),
      officePhoneNumber = TextEditingController(),
      officeAddress = TextEditingController(),
      officePostalCode = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SharedPreferences? prefs;

  bool validationbutton = false;

  void Function()? onchanged() {
    return () {
      validationbutton = formKey.currentState!.validate();
      update();
    };
  }

  Future setSharedPrefWorkDetail(
      String jobDetail, jobPlace, officePhoneNumber, officeAddress, officePostalCode) async {
    prefs!.setString('detailPekerjaan', jobDetail);
    prefs!.setString('namaTempatKerjaDetailPekerjaan', jobPlace);
    // prefs!.setString('noTelpDetailPekerjaan', officePhoneNumber);
    if (officePhoneNumber == '' || officePhoneNumber == null) {
      prefs!.setString('noTelpDetailPekerjaan', '99999999');
    } else {
      prefs!.setString('noTelpDetailPekerjaan', officePhoneNumber);
    }
    prefs!.setString('alamatTempatKerjaDetailPekerjaan', officeAddress);
    prefs!.setString('kodePosDetailPekerjaan', officePostalCode);
  }

  Future getSharedPrefWorkDetail() async {
    prefs = Get.find<DataController>().prefs;
    jobDetail.text = prefs!.getString("detailPekerjaan")!;
    jobPlace.text = prefs!.getString("namaTempatKerjaDetailPekerjaan")!;
    officePhoneNumber.text = prefs!.getString("noTelpDetailPekerjaan")!;
    officeAddress.text = prefs!.getString("alamatTempatKerjaDetailPekerjaan")!;
    officePostalCode.text = prefs!.getString("kodePosDetailPekerjaan")!;
    if (jobDetail.text.isNotEmpty) {
      validationbutton = true;
    }
  }

  String? value = '';

  bool statusTextForm = false;
  bool statusCharLength = false;

  bool validationButton() {
    if (jobDetail.text == "" ||
        jobPlace.text == "" ||
        officeAddress.text == "" ||
        officePostalCode.text == "") {
      print("im here");
      return false;
    }
    if (jobDetail.text.length < 5 && jobDetail.text.length > 40 ||
        jobPlace.text.length < 5 && jobPlace.text.length > 60 ||
        officeAddress.text.length < 5 && officeAddress.text.length > 40 ||
        officePostalCode.text.length < 5 && officePostalCode.text.length > 5) {
      print("here iam");
      return false;
    }
    if (jobDetail.text.length >= 5 && jobDetail.text.length <= 40) {
      print("job here : ${jobDetail.text.length}");
      if (jobPlace.text.length >= 5 && jobPlace.text.length <= 60) {
        print("place here : ${jobPlace.text.length}");
        if (officeAddress.text.length >= 5 && officeAddress.text.length <= 40) {
          print("office here");
          if (officePostalCode.text.length >= 5 && officePostalCode.text.length <= 5) {
            setSharedPrefWorkDetail(jobDetail.text, jobPlace.text, officePhoneNumber.text,
                officeAddress.text, officePostalCode.text);
            return true;
          }
        }
      }
    }

    return false;
  }
}
