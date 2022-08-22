import 'dart:convert';
import 'dart:developer';

// import 'package:detail/device_detail.dart';

import 'package:device_info/device_info.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/response_model/device_properties.dart';
import 'package:eform_modul/response_model/user_check_model.dart';
import 'package:eform_modul/service/services.dart';
import 'package:eform_modul/src/components/Global.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/views/register/register_card_type/card_type_screen.dart';
import 'package:eform_modul/src/views/register/register_card_type/card_type_screen_taplus_bisnis.dart';
import 'package:eform_modul/src/views/register/register_card_type/card_type_screen_taplus_diaspora.dart';
import 'package:eform_modul/src/views/register/register_card_type/card_type_screen_taplus_muda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../src/components/list-error.dart';
import '../../src/components/theme_const.dart';
import '../../src/utility/Routes.dart';
import '../../src/utility/custom_loading.dart';
import 'DataController.dart';

class DataDiri1Controller extends GetxController {
  SharedPreferences? prefs;
  TextEditingController idNumber = TextEditingController(text: '');
  TextEditingController date = TextEditingController(text: '');
  TextEditingController name = TextEditingController(text: '');
  TextEditingController birthOfPlace = TextEditingController(text: '');

  final formKey = GlobalKey<FormState>();
  bool validationButton = false;

  var initialDate = DateTime(DateTime.now().year - 17, DateTime.now().month, DateTime.now().day);
  TextEditingController referralCode = TextEditingController(text: '');
  String errorCode = '';
  String errormessage = '';
  String compareDate = '';

  get _body async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    var newDate = DateFormat("dd/MM/yyyy").parse(date.text);
    return {
      "channel": "EFORM",
      "idNum": idNumber.text,
      "idType": "0001",
      "pob": birthOfPlace.text,
      "dateOfBirth": DateFormat('yyyy-MM-dd').format(newDate),
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  UserCheckModel? userCheckModel;
  Future<void> submit() async {
    CustomLoading().showLoading('Memuat Data');
    try {
      // print(jsonEncode(await _body));
      var _res = await Services().POST(urlCekNIK, 'Api Check Account', body: await _body);
      // log("Ini Adalah Header : ${_res?.data?.header}");
      // print("XSX -> ${_res?.statusCode}");
      assert(_res?.statusCode == 200);
      userCheckModel = UserCheckModel.fromJson(_res?.data?.body);
      var _jwtBody = (_res?.data?.body as Map<String, dynamic>).values.toList();

      /// Assert to equal
      assert(Global().compareableJwtBody(
          responseBody: userCheckModel?.toJson().values.toList(), jwtBody: _jwtBody));
      update();
      if ((userCheckModel?.errorCode == null) || userCheckModel!.errorCode!.isEmpty) {
        prefs = Get.find<DataController>().prefs;
        var newDate = DateFormat("dd/MM/yyyy").parse(date.text);
        prefs!.setString('tempatLahir', birthOfPlace.text);
        prefs!.setString('nik', idNumber.text);
        prefs!.setString("namaSesuaiKTP", name.text);
        prefs!.setString('tanggalLahir', DateFormat('yyyy-MM-dd').format(newDate));
        prefs!.setString('kode_referal', referralCode.text);
        prefs!.setString('errorCode', '');

        ///Save refnum for save photo
        prefs!.setString('refNumber', _res?.data?.header['refNumber']);
        // print('errorCode =' + prefs!.getString('errorCode')!);
        CustomLoading().dismissLoading();
        Get.toNamed(Routes().datadiri2);
      } else {
        CustomLoading().dismissLoading();
        ERROR_DIALOG(errorCode: userCheckModel?.errorCode);
      }
    } on AssertionError {
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: '000');
    } catch (e) {
      // print("error $e");
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: userCheckModel?.errorCode);
    }
  }

  getStringValuesSF() async {
    // prefs = await SharedPreferences.getInstance();
    if (prefs == null) prefs = Get.find<DataController>().prefs;
    if (prefs!.getString('nik') != '' && prefs!.get("nik") != null) {
      errorCode = prefs!.getString('errorCode')!;
      idNumber.text = prefs!.getString('nik') ?? "";
      name.text = prefs!.getString('namaSesuaiKTP') ?? "";
      referralCode.text = prefs!.getString('kode_referal') ?? "";
      birthOfPlace.text = prefs!.getString('tempatLahir') ?? "";

      var inputFormat = DateFormat('yyyy-MM-dd');
      var inputDate = inputFormat.parse(prefs!.getString('tanggalLahir') ?? "");
      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(inputDate);
      date.text = '$outputDate';
      // print(' ini adalah ${Get.find<OtpController>().headerErrorCode}');
      if (date.text.isNotEmpty) {
        // print(inputDate.toString());
        initialDate = inputDate;
      }
      compareDate = outputFormat.format(initialDate);
      errorCode = prefs!.getString('errorCode') ?? "";
      // if (errorCode != '') {
      //   var result = ListError().validateErrorMessage(errorCode);

      //   errormessage = result;
      //   errorMessage(errormessage);
      // }
      if (Get.find<OtpController>().createAccountModelResponse?.errorCode != null) {
        var errorCode = Get.find<OtpController>().createAccountModelResponse?.errorCode;
        // print('Ini Adalah Error Code :' + errorCode.toString());

        var result = ListError().validateErrorMessage(errorCode.toString());

        var errormessage = result;
        await Future.delayed(Duration(milliseconds: 200));
        errorMessage(errormessage);
        Get.find<OtpController>().sendOtpModelResponse?.errorCode = '';
      } else if (Get.find<OtpController>().sendOtpModelResponse?.errorCode != null) {
        var errorCode = Get.find<OtpController>().createAccountModelResponse?.errorCode;
        // print('Ini Adalah Error Code :' + errorCode.toString());

        var result = ListError()
            .errorMessage('${Get.find<OtpController>().sendOtpModelResponse?.errorCode}');

        var errormessage = result;
        await Future.delayed(Duration(milliseconds: 200));
        errorMessage(errormessage);
        Get.find<OtpController>().sendOtpModelResponse?.errorCode = null;
      } else if (Get.find<OtpController>().headerErrorCode == '1003') {
        var errorCode = Get.find<OtpController>().headerErrorCode;
        // print('Ini Adalah Error Code :' + errorCode.toString());

        var result = ListError().errorMessage('9001');

        var errormessage = result;
        await Future.delayed(Duration(milliseconds: 200));
        errorMessage(errormessage);
        Get.find<OtpController>().headerErrorCode = '';
        // Get.dialog(Text('Test'));
      } else if (Get.find<OtpController>().headerErrorCode == '1005') {
        var errorCode = Get.find<OtpController>().headerErrorCode;
        // print('Ini Adalah Error Code :' + errorCode.toString());

        var result = ListError().errorMessage('');

        var errormessage = result;
        await Future.delayed(Duration(milliseconds: 200));
        errorMessage(errormessage);
        Get.find<OtpController>().headerErrorCode = '';
        // Get.dialog(Text('Test'));
      }
    }
    if (name.text.isNotEmpty &&
        idNumber.text.isNotEmpty &&
        birthOfPlace.text.isNotEmpty &&
        date.text.isNotEmpty) {
      validationButton = true;
    }
  }

  Future errorMessage(String errormessage) async {
    return Get.dialog(
      PopoutWrapContent(
        textTitle: '',
        button_radius: 4,
        buttonText: 'Ok,saya Mengerti',
        ontap: () {
          Get.back();
        },
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Mohon Maaf',
              style: PopUpTitle,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              errormessage,
              style: infoStyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  AutovalidateMode? checkErrorCode(String validatorName, String errorCode) {
    switch (validatorName) {
      case "name":
        if (errorCode == '9015' ||
            errorCode == '9017' ||
            errorCode == '9019' ||
            errorCode == '9021') {
          return AutovalidateMode.always;
        }
        return AutovalidateMode.onUserInteraction;
      case "dob":
        if (errorCode == '9016' ||
            errorCode == '9017' ||
            errorCode == '9020' ||
            errorCode == '9021') {
          return AutovalidateMode.always;
        }
        return AutovalidateMode.onUserInteraction;
      case "bop":
        if (errorCode == '9018' ||
            errorCode == '9019' ||
            errorCode == '9020' ||
            errorCode == '9021') {
          return AutovalidateMode.always;
        }
        return AutovalidateMode.onUserInteraction;
      default:
        return AutovalidateMode.onUserInteraction;
    }
  }

  Future<bool> willPop(SharedPreferences _prefs) async {
    if (_prefs.getString('produk') == 'Taplus') {
      Get.off(() => CardTypeScreen(), transition: Transition.rightToLeft);
    } else if (_prefs.getString('produk') == 'Taplus Muda') {
      Get.off(() => CardTypeMuda(), transition: Transition.rightToLeft);
    } else if (_prefs.getString('produk') == 'Taplus Bisnis') {
      Get.off(() => CardTypeBisnis(), transition: Transition.rightToLeft);
    } else {
      Get.off(() => CardTypeDiaspora(), transition: Transition.rightToLeft);
    }
    return true;
  }

  String? validatorField(String validatorName) {
    switch (validatorName) {
      case "nik":
        if (idNumber.text.length < 16) {
          return 'NIK tidak boleh kurang dari 16 karakter';
        }
        return null;
      case "name":
        final regex = RegExp(r'^[a-zA-Z.,-_]+$');
        if (errorCode == '9015' ||
            errorCode == '9017' ||
            errorCode == '9019' ||
            errorCode == '9021') {
          return 'Data yang diisi belum valid dengan nomor identitas yang digunakan';
        }

        if (name.text.isEmpty) {
          return 'Nama tidak boleh kosong';
        }
        if (name.text.length < 3) {
          return 'Nama minimal 3 karakter';
        }

        if (regex.hasMatch(name.text.replaceAll(' ', '')) == false) {
          return 'Nama hanya boleh menggunakan huruf, spasi, symbol -_,.'
              '';
        }
        return null;
      case "dob":
        if (date.text == '') {
          return 'Tanggal Lahir tidak boleh kosong ';
        }
        return null;
      case "birthPlace":
        final regex = RegExp(r'^[a-zA-Z.,-_]+$');
        if (errorCode == '9016' ||
            errorCode == '9017' ||
            errorCode == '9020' ||
            errorCode == '9021') {
          return 'Data yang diisi belum valid dengan nomor identitas yang digunakan';
        }
        if (birthOfPlace.text.isEmpty) {
          return 'Tempat lahir tidak boleh kosong';
        }
        if (birthOfPlace.text.length < 3) {
          return 'Tempat lahir minimal 3 karakter';
        }

        if (regex.hasMatch(birthOfPlace.text.replaceAll(' ', '')) == false) {
          return 'Tempat lahir hanya boleh menggunakan huruf, spasi, symbol -_,.'
              '';
        }
        return null;
      default:
        return null;
    }
  }

  void Function()? onchanged() {
    return () {
      validationButton = formKey.currentState!.validate();
      update();
    };
  }

  void onBackButton(SharedPreferences _prefs) {
    if (_prefs.getString('produk') == 'Taplus') {
      Get.off(() => CardTypeScreen(), transition: Transition.rightToLeft);
    } else if (_prefs.getString('produk') == 'Taplus Muda') {
      Get.off(() => CardTypeMuda(), transition: Transition.rightToLeft);
    } else if (_prefs.getString('produk') == 'Taplus Bisnis') {
      Get.off(() => CardTypeBisnis(), transition: Transition.rightToLeft);
    } else {
      Get.off(() => CardTypeDiaspora(), transition: Transition.rightToLeft);
    }
  }

  Widget seperator(double height) {
    return SizedBox(
      height: Get.height * height,
    );
  }

  // Future<void> checkProgress(BuildContext context) async {
  //   //CHECK CONNECTION
  //   if (!await CHECK_DEVICES_CONNECTION()) {
  //     // return dynamic
  //     return;
  //   }

  //   CustomLoading().showLoading("Memuat Data.....");
  //   await Get.find<DataController>()
  //       .cekUser(nik: idNumber.text, tanggal: date.text);

  //   CustomLoading().dismissLoading();
  //   if (Get.find<DataController>().state == Status.Success) {
  //     // Get.find<DataDiri2Controller>().getStringValuesSF(context);
  //     var newDate = DateFormat("dd/MM/yyyy").parse(date.text);
  //     prefs!.setString('nik', idNumber.text);
  //     prefs!.setString("namaSesuaiKTP", validatorName.text);
  //     prefs!
  //         .setString('tanggalLahir', DateFormat('yyyy-MM-dd').format(newDate));
  //     prefs!.setString('kode_referal', referralCode.text);
  //     prefs!.setString('errorCode', '');
  //     print('errorCode =' + prefs!.getString('errorCode')!);
  //     Get.back();
  //     Get.toNamed(Routes().datadiri2);
  //   } else if (Get.find<DataController>().state == Status.Failed) {
  //     // Get.back();
  //     return Get.dialog(PopoutWrapContent(
  //         textTitle: '',
  //         button_radius: 4,
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Center(
  //               child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
  //             ),
  //             SizedBox(
  //               height: 8,
  //             ),
  //             Text('Mohon Maaf', style: PopUpTitle),
  //             SizedBox(
  //               height: 12,
  //             ),
  //             Text(
  //               'Service Sedang Maintenance',
  //               style: infoStyle,
  //               textAlign: TextAlign.center,
  //             )
  //           ],
  //         ),
  //         buttonText: 'Ok, saya Mengerti',
  //         ontap: () {
  //           Get.back();
  //           // Navigator.of(context).pop();
  //         }));
  //   } else {
  //     // Get.back();
  //     var errorCode = prefs!.getString('errorCode') ?? "";
  //     return Get.dialog(
  //       PopoutWrapContent(
  //           textTitle: '',
  //           button_radius: 4,
  //           content: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Center(
  //                 child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
  //               ),
  //               SizedBox(
  //                 height: 8,
  //               ),
  //               Text(
  //                 'Mohon Maaf',
  //                 style: PopUpTitle,
  //               ),
  //               SizedBox(
  //                 height: 12,
  //               ),
  //               Text(
  //                 ListError().errorMessage(errorCode),
  //                 style: infoStyle,
  //                 textAlign: TextAlign.center,
  //               )
  //             ],
  //           ),
  //           buttonText: 'Oke Saya Mengerti',
  //           ontap: () {
  //             Get.back();
  //           }),
  //     );
  //   }
  // }
}
