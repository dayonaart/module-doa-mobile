import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/dropdown.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/models/pekerjaan-model.dart';

class PerkerjaanController extends GetxController {
  TextEditingController job = TextEditingController();
  TextEditingController income = TextEditingController();
  TextEditingController transactionEstimation = TextEditingController();
  TextEditingController sourceOfFund = TextEditingController();
  TextEditingController otherSources = TextEditingController();
  TextEditingController openAccReason = TextEditingController();

  String selectedJob = '';
  String selectedIncome = '';
  String selectedTransactionEstimation = '';
  String selectedSourceOfFund = '';
  String selectedOpenAccReason = '';
  SharedPreferences? prefs;
  final formKey = GlobalKey<FormState>();
  bool validationButton = false;

  String? validation(String val) {
    if (val.isEmpty) {
      return "Sumber Dana Lainnya tidak boleh kosong";
    }
    return null;
  }

  String? dropDownOnChange(String? value, String name) {
    switch (name) {
      case "job":
        if (value!.isEmpty) {
          return 'Pekerjaan tidak boleh kosong';
        }
        return null;
      case "salary":
        if (value!.isEmpty) {
          return 'Penghasilan tidak boleh kosong';
        }
        return null;
      case "sourceFund":
        if (value!.isEmpty) {
          return 'Sumber Dana tidak boleh kosong';
        }
        return null;
      case "estimatedTransaction":
        if (value!.isEmpty) {
          return 'Perkiraan Nilai Transaksi tidak boleh kosong';
        }
        return null;
      case "destinationTransaction":
        if (value!.isEmpty) {
          return 'Tujuan Pembukaan Rekening tidak boleh kosong';
        }
        return null;
      default:
        return null;
    }
  }

  Future<void> onTap(String name, BuildContext context) async {
    switch (name) {
      case "job":
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) => DropDownFormField(
            items: jobList,
            labelText: 'Pekerjaan',
            selectedValue: job,
            param: '1',
          ),
        );
        if (result != null) {
          selectedJob = result.id;

          update();
        }
        break;
      case "salary":
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) => DropDownFormField(
            items: incomeList,
            labelText: 'Penghasilan',
            selectedValue: income,
            param: '1',
          ),
        );
        if (result != null) {
          selectedIncome = result.id;

          update();
        }
        break;
      case "sourceFund":
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) => DropDownFormField(
            items: sourceOfFundList,
            labelText: 'Sumber Dana',
            selectedValue: sourceOfFund,
            param: '1',
          ),
        );
        if (result != null) {
          selectedSourceOfFund = result.id;

          update();
        }
        break;
      case "estimatedTransaction":
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) => DropDownFormField(
            items: transactionEstimationList,
            labelText: 'Perkiraan Nilai Transaksi',
            selectedValue: transactionEstimation,
            param: '1',
          ),
        );
        if (result != null) {
          selectedTransactionEstimation = result.id;
        }
        break;
      case "destinationTransaction":
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) => DropDownFormField(
            items: openAccReasonList,
            labelText: 'Tujuan Pembukaan Rekening',
            selectedValue: openAccReason,
            param: '1',
          ),
        );
        if (result != null) {
          selectedOpenAccReason = result.id;
        }
        break;
      default:
        return null;
    }
  }

  Future<void> submit(bool isValidated) async {
    if (!isValidated) return;
    addStringToSF();
    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.
    if (selectedJob == '08' || selectedJob == '09' || selectedJob == '10') {
      prefs!.setString('detailPekerjaan', '');
      prefs!.setString('namaTempatKerjaDetailPekerjaan', '');
      prefs!.setString('noTelpDetailPekerjaan', '');
      prefs!.setString('alamatTempatKerjaDetailPekerjaan', '');
      prefs!.setString('kodePosDetailPekerjaan', '');
      Get.offNamed(Routes().pemilikDana);
    } else {
      prefs!.setString("hubunganPemberiDana", '');
      prefs!.setString("namaPemilikDana", '');
      prefs!.setString("alamatPemilikDana", '');
      prefs!.setString("telpPemilikDana", '');
      Get.offNamed(Routes().detailPekerjaan);
    }
  }

  addStringToSF() async {
    prefs!.setString("pekerjaan", selectedJob);
    prefs!.setString("penghasilanPerbulan", selectedIncome);
    prefs!.setString("sumberDana", selectedSourceOfFund);
    prefs!.setString("sumberDanaLainnya", otherSources.text);
    prefs!.setString("perkiraanNilaiTransaksi", selectedTransactionEstimation);
    prefs!.setString("tujuanPembukaanRekening", selectedOpenAccReason);
  }

  getStringValuesSF() async {
    prefs = Get.find<DataController>().prefs;
    // prefs = await SharedPreferences.getInstance();
    selectedJob = prefs!.getString("pekerjaan") ?? "";
    selectedIncome = prefs!.getString("penghasilanPerbulan") ?? "";
    selectedSourceOfFund = prefs!.getString("sumberDana") ?? "";
    otherSources.text = prefs!.getString("sumberDanaLainnya") ?? "";
    selectedTransactionEstimation = prefs!.getString("perkiraanNilaiTransaksi")!;
    selectedOpenAccReason = prefs!.getString("tujuanPembukaanRekening")!;

    int index = 0;
    if (selectedJob != '') {
      index = jobList.indexWhere((element) => element.id == selectedJob);
      job.text = jobList[index].desc;
      index = incomeList.indexWhere((element) => element.id == selectedIncome);
      income.text = incomeList[index].desc;
      index = sourceOfFundList.indexWhere((element) => element.id == selectedSourceOfFund);
      sourceOfFund.text = sourceOfFundList[index].desc;
      index = transactionEstimationList
          .indexWhere((element) => element.id == selectedTransactionEstimation);
      transactionEstimation.text = transactionEstimationList[index].desc;
      index = openAccReasonList.indexWhere((element) => element.id == selectedOpenAccReason);
      openAccReason.text = openAccReasonList[index].desc;
      validationButton = true;
    }
  }

  void Function()? onchanged() {
    return () {
      if (otherSources.text.isEmpty && sourceOfFund.text == 'LAINNYA') {
        validationButton = false;
        return;
      }

      validationButton = formKey.currentState!.validate();
      update();
    };
  }
}
