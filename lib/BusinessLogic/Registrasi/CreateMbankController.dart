import 'dart:convert';
import 'dart:developer';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/response_model/create_mbank_model_response/create_mbank_model_response.dart';
import 'package:eform_modul/service/services.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

import '../../service/checkMbank-service.dart';
import '../../service/createMbank-service.dart';
import 'CreatePinController.dart';

class CreateMbankController extends GetxController {
  TextEditingController inputUserIdController = TextEditingController(text: '');
  String email = '';
  String name = '';
  String phonenum = '';
  SharedPreferences? prefs;
  Status state = Status.Initial;
  Xml2Json xml2Json = Xml2Json();
  String errorCode = "";
  //NOTES CIFNUM DIDAPAT DARI RESPON SERVICE UPDATE CARD, JADI YANG DISINI TUNGGU DULU SERVICE UPDATE CARD SELESAI
  get _bodyCekMbank =>
      '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:new="http://service.bni.co.id/echannel/newmobile"><soapenv:Header/><soapenv:Body><new:inquiryAllParam><cifNum>${Get.find<CreatePinController>().getCardModelResponse?.cifNum}</cifNum><username>${inputUserIdController.text}</username><phone>${Get.find<OtpController>().phoneNumber}</phone><email>$email</email></new:inquiryAllParam></soapenv:Body></soapenv:Envelope>
''';
//   get _bodyCreateMbank => '''
// <soapenv:Envelope
// xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
// xmlns:new="http://service.bni.co.id/echannel/newmobile">
//    <soapenv:Header/>
//    <soapenv:Body>
//       <new:registerUserNewMb>
//          <request>
//             <username>${inputUserIdController.text}</username>
//             <cifnum>${Get.find<CreatePinController>().getCardModelResponse?.cifNum}</cifnum>
//             <fullname>$name</fullname>
//             <segmentation>MASS</segmentation>
//             <phonenum>${Get.find<OtpController>().phoneNumber}</phonenum>
//             <email>$email</email>
//             <employeeId></employeeId>
//             <branchcode></branchcode>
//             <supervisorId></supervisorId>
//             <channel></channel>
//          </request>
//       </new:registerUserNewMb>
//    </soapenv:Body>
// </soapenv:Envelope>
// ''';

  get _bodyCreateMbank =>
      '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:new="http://service.bni.co.id/echannel/newmobile"><soapenv:Header/><soapenv:Body><new:registerUserNewMb><request><username>${inputUserIdController.text}</username><cifnum>${Get.find<CreatePinController>().getCardModelResponse?.cifNum}</cifnum><fullname>$name</fullname><segmentation>MASS</segmentation><phonenum>${Get.find<OtpController>().phoneNumber}</phonenum><email>$email</email><employeeId></employeeId><branchcode></branchcode><supervisorId></supervisorId><channel></channel></request></new:registerUserNewMb></soapenv:Body></soapenv:Envelope>
''';

  getData() async {
    prefs = Get.find<DataController>().prefs;
    // prefs = await SharedPreferences.getInstance();
    phonenum = prefs!.getString('nomorHandphone') ?? '';
    phonenum = phonenum.replaceAll("+", "");
    phonenum = phonenum.replaceAll("-", "");
    email = prefs!.getString('email') as String;
    name = prefs!.getString('namaSesuaiKTP') as String;
  }

  sendData(String cifnum) async {
    await cekMbank(
        username: inputUserIdController.text,
        name: name,
        phonenum: phonenum,
        email: email,
        cifnum: cifnum);
  }

  Future<void> submit() async {
    CustomLoading().showLoading('Memuat Data');
    var _resCekMbank =
        await Services().POST(urlcheckCIFMbank, 'Api Check Mbank', body: _bodyCekMbank);
    // if (kDebugMode) {
    //   print(_resCekMbank!.statusCode);
    //   print(_resCekMbank.data?.header);
    // }
    var data = _resCekMbank?.data?.header
        .toString()
        .split("<")
        .where((e) => e.contains("faultstring>"))
        .where((e) => !e.contains('/'))
        .join()
        .replaceAll("faultstring>", "");
    // print("ERROR CODE $data");

    // CustomLoading().dismissLoading();
    if (_resCekMbank!.statusCode == 500) {
      await Future.delayed(Duration(seconds: 3));
      if (data == '9001') {
        var _resCreateMbank =
            await Services().POST(urlcheckCIFMbank, 'Api Create Mbank', body: _bodyCreateMbank);
        // print('Ini Error Code CreATE mBANK' +
        //     _resCreateMbank!.statusCode.toString());
        CustomLoading().dismissLoading();

        if (_resCreateMbank?.statusCode == 200) {
          // print(_resCreateMbank?.data);

          CustomLoading().dismissLoading();
          Get.offNamed('successPage');
        } else {
          CustomLoading().dismissLoading();
          ERROR_DIALOG();
        }
      } else {
        CustomLoading().dismissLoading();
        ERROR_DIALOG(errorCode: 'RCS');
      }
    } else if (_resCekMbank.statusCode == 200) {
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: 'RCS');
    } else {
      CustomLoading().dismissLoading();
      ERROR_DIALOG();
    }
    // if (_resCekMbank?.statusCode == 500) {
    // } else if (_resCekMbank?.statusCode == 200) {
    //   ERROR_DIALOG(errorCode: 'RCS');
    // } else {
    //   ERROR_DIALOG(errorCode: '');
    // }
  }

  Future<void> cekMbank(
      {required String username,
      required String email,
      required String cifnum,
      required String phonenum,
      required String name}) async {
    try {
      // emit(CekmbankLoading());

      errorCode = await cekMbankService()
          .cekMbank(username: username, email: email, phone: phonenum, cifnum: cifnum);
      // emit(CekmbankSuccess(errorCode));
      if (errorCode == '500') {
        // emit(CekmbankLoading());
        errorCode = await createMbankService().createMbank(
            username: username, name: name, cifnum: cifnum, phonenum: phonenum, email: email);
        if (errorCode == '200') {
          state = Status.Success;
          // emit(CreatembankSuccess(erroCodeCreateMbank));

        } else if (errorCode == "500") {
          state = Status.Failed;
          // emit(CekmbankFailed());
        } else {
          state = Status.FailedChek;
        }
      } else {
        state = Status.Failed;
        // emit(CekmbankFailed());
      }
      // var errorCode = await createMbankService().createMbank(
      //     username: username,
      //     email: email,
      //     cifnum: cifnum,
      //     phonenum: phonenum,
      //     name: name);

      // if (errorCode == '9001') {
      //   // var errorCodeCreate = await createMbankService().createMbank();
      //   // print('Ini ErrorCode Cubit ' + errorCodeCreate.toString());
      //   // if (errorCodeCreate == '9001') {
      //   //   emit(CekmbankSuccess(errorCode));
      //   // } else {
      //   //   emit(CekmbankFailed());
      //   // }
      // } else {
      //   emit(CekmbankFailed());
      // }

    } catch (e) {
      state = Status.Failed;
      // emit(CekmbankFailed());
    }
  }
}
