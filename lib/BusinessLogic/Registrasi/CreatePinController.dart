import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

// import 'package:detail/device_detail.dart';
import 'package:device_info/device_info.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:eform_modul/src/views/register/Acknowledgement/acknowledgement_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../response_model/active_card_model_response.dart';
import '../../response_model/create_account_model.dart';
import '../../response_model/device_properties.dart';
import '../../response_model/get_card_model_response.dart';
import '../../response_model/update_card_model_response.dart';
import '../../service/activate-card.dart';
import '../../service/create-pin.dart';
import '../../service/get-card.dart';
import '../../service/getReceiptEmail-service.dart';
import '../../service/sendEmail-service.dart';
import '../../service/services.dart';
import '../../service/update-card.dart';
import '../../src/components/Encrypt.dart';
import '../../src/components/Global.dart';
import '../../src/components/url-api.dart';
import '../../src/models/card-and-pin-model.dart';
import '../../src/models/receiptEmail-model.dart';
import '../../src/views/register/register_card_type/card_type_prefs.dart';

class CreatePinController extends GetxController {
  String? nik,
      numberPhone,
      accountType,
      email,
      name,
      openAccReason,
      branch,
      homePhone,
      officePhone,
      patronName,
      bin,
      card_type,
      productType,
      initialDeposit,
      outletName,
      lastDepositDate,
      registerDate,
      registerTime,
      refNumEmail,
      cardName;
  String errorCode = "";
  get provider => (productType?.toLowerCase() == 'taplus diaspora')
      ? 'DISPORA_OPENACCOUNT_RECEIPT'
      : 'BRANCHLESS_OPENACCOUNT_RECEIPT';
  String? newInput, confirmInput = '';
  String responseGetreceipt = '';
  final cardprefs = CardTypePrefs.instance;
  bool isLoading = false;
  String accStatus = '';
  GetCardModelResponse? getCardModelResponse;
  UpdateCardModelResponse? updateCardModelResponse;
  ActiveCardModelResponse? activeCardModelResponse;
  var rng = Random();
  SharedPreferences? prefs;
  Status state = Status.Initial;
  CardandPinModel? cardandPinModelActivate;
  CardandPinModel? cardandPinModel;
  ReceiptEmailModel? receiptEmailModel;

  Encrypt encrypt = Encrypt();
  static const platform = MethodChannel('doa.bni.id/channel');
  Future<DeviceProperties?> getDeviceProperties() async {
    try {
      String result = await platform.invokeMethod('getDeviceProperty');
      return DeviceProperties.fromJson(jsonDecode(result));
    } on PlatformException catch (e) {
      print("Failed to open mbank: '${e.message}'.");
      return null;
    }
  }

  TextEditingController confirmPin = TextEditingController();
  TextEditingController pin = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CreateAccountModelResponse get createAccountModelResponse {
    return Get.find<OtpController>().createAccountModelResponse!;
  }

  // String pinTest = '123456';

  get _bodyCreatePin => '''
<?xml version="1.0"?><soapenv:Envelope xmlns:q0="http://service.bni.co.id/atmpin" xmlns:bo="http://service.bni.co.id/atmpin/bo" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><q0:transaction><request><clientId>KANIA</clientId><reffNum>$refNumEmail</reffNum><content xsi:type="bo:PinCreateReq"><operation>PINCREATE</operation><accountNum>${getCardModelResponse?.accountNum}</accountNum><cardNum>${getCardModelResponse?.cardNum}</cardNum><expDate/><encPin1>${encrypt.encrypt(pin.text)}</encPin1></content></request></q0:transaction></soapenv:Body></soapenv:Envelope>''';
  // String get _bodyCreatePin {
  //   return "<?xml version=\"1.0\"?><soapenv:Envelope xmlns:q0=\"http://service.bni.co.id/atmpin\" xmlns:bo=\"http://service.bni.co.id/atmpin/bo\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><soapenv:Body><q0:transaction><request><clientId>KANIA</clientId><reffNum>$refNumEmail</reffNum><content xsi:type=\"bo:PinCreateReq\"><operation>PINCREATE</operation><accountNum>${getCardModelResponse?.accountNum}</accountNum><cardNum>${getCardModelResponse?.cardNum}</cardNum><expDate/><encPin1>${encrypt.encrypt(pin.text)}</encPin1></content></request><q0:transaction></soapenv:Body></soapenv:Envelope>";
  // }

  get _bodyGetCard async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      "channel": "EFORM",
      "accountNum": createAccountModelResponse.newAccountNum,
      "cifNum": createAccountModelResponse.cifNum,
      "bin": bin,
      "cardType": card_type,
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  // get _bodyGetCard async {
  //   var device = await getDeviceProperties();
  //   return {
  //     "channel": "EFORM",
  //     "accountNum":
  //         '${Get.find<OtpController>().createAccountModelResponse!.newAccountNum}',
  //     "cifNum":
  //         '${Get.find<OtpController>().createAccountModelResponse!.cifNum}',
  //     "bin": '13',
  //     "cardType": '1',
  //     "userAppVersion_code": device?.versionCode,
  //     "userAppVersion_name": device?.versionName,
  //     "device_type": device?.deviceType,
  //     "osVersion": device?.osVersion,
  //     "ip_address": device?.ipAddress
  //   };
  // }

  // Future<Map<String, dynamic>> get _bodyUpdateCard async {
  //   var device = await getDeviceProperties();
  //   return {
  //     "cardNum": getCardModelResponse?.cardNum,
  //     "channel": "EFORM",
  //     "accountNum": getCardModelResponse?.accountNum,
  //     "cifNum": getCardModelResponse?.cifNum,
  //     "bin": bin,
  //     "cardType": card_type,
  //     "oldStatus": "USED",
  //     "newStatus": "ACTIVATED",
  //     "userAppVersion_code": device?.versionCode,
  //     "userAppVersion_name": device?.versionName,
  //     "device_type": device?.deviceType,
  //     "osVersion": device?.osVersion,
  //     "ip_address": device?.ipAddress
  //   };
  // }

  Future<Map<String, dynamic>> get _bodyUpdateCard async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      "cardNum": getCardModelResponse?.cardNum,
      "channel": "EFORM",
      "accountNum": getCardModelResponse?.accountNum,
      "cifNum": getCardModelResponse?.cifNum,
      "bin": '13',
      "cardType": '1',
      "oldStatus": "USED",
      "newStatus": "ACTIVATED",
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  // Future<Map<String, dynamic>> get _bodyActiveCard async {
  //   var device = await getDeviceProperties();
  //   return {
  //     "cardNum": getCardModelResponse?.cardNum,
  //     "channel": "EFORM",
  //     "accountNum": getCardModelResponse?.accountNum,
  //     "cifNum": getCardModelResponse?.cifNum,
  //     "bin": bin,
  //     "cardType": card_type,
  //     "userAppVersion_code": device?.versionCode,
  //     "userAppVersion_name": device?.versionName,
  //     "device_type": device?.deviceType,
  //     "osVersion": device?.osVersion,
  //     "ip_address": device?.ipAddress
  //   };
  // }
  Future<Map<String, dynamic>> get _bodyActiveCard async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      "cardNum": getCardModelResponse?.cardNum,
      "channel": "EFORM",
      "accountNum": getCardModelResponse?.accountNum,
      "cifNum": getCardModelResponse?.cifNum,
      "bin": '13',
      "cardType": '1',
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  String? validation(String val) {
    switch (name) {
      case "pin":
        if (val.isEmpty) {
          return "Pin tidak boleh kosong";
        }
        if (val.length < 6) {
          return "Pin minimal 6 angka";
        }
        return null;
      case "confpin":
        if (val.isEmpty) {
          return "Pin tidak boleh kosong";
        }
        if (val.length < 6) {
          return "Pin minimal 6 angka";
        }
        return null;
      default:
        return null;
    }
  }

  bool validationButton = false;

  bool confirmPinFunction() {
    if (pin.text.length == 6 && confirmPin.text.length == 6) {
      return true;
    }

    return false;
  }

  Future<void> submit() async {
    CustomLoading().showLoading('Memuat Data');

    try {
      var bodyGetCard = await _bodyGetCard;

      var _res = await Services().POST(urlGetCard, 'Api Get Card', body: bodyGetCard);

      // print('Ini di otpController ' + prefs!.getString('otpSender').toString());
      // print(_res!.toJson());
      // print("ini status code getCard : ${_res?.statusCode}");
      // print("ini data getCard : ${_res?.data}");

      ///=======///
      if (_res?.statusCode == 200) {
        getCardModelResponse = GetCardModelResponse.fromJson(_res?.data!.body);
        var _jwtBody = (_res?.data?.body as Map<String, dynamic>).values.toList();
        assert(Global().compareableJwtBody(
            responseBody: getCardModelResponse?.toJson().values.toList(), jwtBody: _jwtBody));
        // CustomLoading().dismissLoading();
        await Future.delayed(Duration(seconds: 3));

        ///=====///
        var bodyActivateCard = await _bodyActiveCard;
        if ((getCardModelResponse?.status == 'SUCCESS')) {
          var _resActivatedCard =
              await Services().POST(urlActivateCard, 'Api Active Card', body: bodyActivateCard);
          print("ini status code active : ${_resActivatedCard?.statusCode}");
          // print("ini data active : ${_resActivatedCard?.data!.body}");

          /// === ///
          if (_resActivatedCard!.statusCode == 200) {
            await Future.delayed(Duration(seconds: 3));

            /// === ///
            if (_resActivatedCard.data!.body['status'] == 'SUCCESS') {
              var bodyUpdateCard = await _bodyUpdateCard;

              var _resUpdateCard =
                  await Services().POST(urlUpdateCard, 'Api Update Card', body: bodyUpdateCard);
              print("ini status code update : ${_resUpdateCard?.statusCode}");
              // print("ini data update : ${_resUpdateCard?.data}");

              ///
              if (_resUpdateCard!.statusCode == 200) {
                await Future.delayed(Duration(seconds: 3));
                if (_resUpdateCard.data!.body['operationStatus'] == 'SUCCESS') {
                  var _resCreatPin = await Services()
                      .POST(urlCreatePin, 'Api Create Pin', body: await _bodyCreatePin);

                  if (_resCreatPin!.statusCode == 200) {
                    accStatus = "Rekening Berhasil Terbuka";
                    await testEmail();

                    errorCode = "00";

                    update();
                    Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
                  } else {
                    accStatus = "Gagal Membuat Pin";
                    await testEmail();

                    errorCode = "3";
                    Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
                  }
                } else {
                  accStatus = "Gagal Membuat Pin";
                  await testEmail();

                  errorCode = '3';
                  Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
                }
              } else {
                accStatus = "Gagal Membuat Pin";
                await testEmail();

                errorCode = '3';
                Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
              }
            } else {
              accStatus = "Gagal Aktivasi Kartu";
              await testEmail();

              errorCode = '2';
              Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
            }
          } else {
            accStatus = "Gagal Aktivasi Kartu";
            await testEmail();

            errorCode = '2';
            Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
          }
        } else {
          accStatus = "Gagal Membuat Kartu";
          await testEmail();

          errorCode = '1';
          Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
        }
      } else {
        accStatus = "Gagal Membuat Kartu";
        await testEmail();

        errorCode = '1';
        Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
      }
      CustomLoading().dismissLoading();
    } on AssertionError {
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: '000');
    } catch (e) {
      accStatus = "Gagal Membuat Kartu";
      await testEmail();
      errorCode = '1';
      Get.to(() => AcknowledgementScreen(), transition: Transition.rightToLeft);
    }
  }

  // Future<void> submit() async {
  //   CustomLoading().showLoading('Memuat Data');
  //   await Future.delayed(Duration(seconds: 1));

  //   var bodyGetCard = await _bodyGetCard;

  //   var _res =
  //       await Services().POST(urlGetCard, 'Api Get Card', body: bodyGetCard);

  //   // print('Ini di otpController ' + prefs!.getString('otpSender').toString());
  //   print(_res!.toJson());
  //   print("ini status code getCard : ${_res.statusCode}");
  //   print("ini data getCard : ${_res.data}");

  //   ///=======///
  //   if (_res.statusCode == 200) {
  //     getCardModelResponse = GetCardModelResponse.fromJson(_res.data?.body);
  //     update();
  //     await Future.delayed(Duration(seconds: 3));

  //     ///=====///
  //     var bodyActivateCard = await _bodyActiveCard;
  //     if ((getCardModelResponse?.errorCode == null) ||
  //         getCardModelResponse!.errorCode!.isEmpty) {
  //       var _resActivatedCard = await Services()
  //           .POST(urlActivateCard, 'Api Active Card', body: bodyActivateCard);
  //       print("ini status code active : ${_resActivatedCard?.statusCode}");
  //       print("ini data active : ${_resActivatedCard?.data}");

  //       /// === ///
  //       if (_resActivatedCard!.statusCode == 200) {
  //         // activeCardModelResponse =
  //         //     ActiveCardModelResponse.fromJson(_resActivatedCard.data?.body);
  //         // print(activeCardModelResponse!.toJson());
  //         // update();
  //         await Future.delayed(Duration(seconds: 3));

  //         /// === ///
  //         if ((_resActivatedCard.data!.body['errorCode'] == null) ||
  //             _resActivatedCard.data!.body['errorCode']) {
  //           var bodyUpdateCard = await _bodyUpdateCard;
  //           try {
  //             CustomLoading().dismissLoading();
  //             var _resUpdateCard = await Services()
  //                 .POST(urlUpdateCard, 'Api Update Card', body: bodyUpdateCard);
  //             print("ini status code update : ${_resUpdateCard?.statusCode}");
  //             print("ini data update : ${_resUpdateCard?.data}");

  //             ///
  //             await _updateCardResult(_resUpdateCard);
  //           } catch (e) {
  //             CustomLoading().dismissLoading();
  //             print('Stop at update card');
  //             print(e);
  //           }
  //         } else {
  //           // await EmailSending(getCardModelResponse?.accountNum as String,
  //           //     'Gagal Aktivasi Kartu');
  //           errorCode = '2';
  //           Get.to(() => AcknowledgementScreen(),
  //               transition: Transition.rightToLeft);
  //         }
  //       } else {
  //         // await EmailSending(getCardModelResponse?.accountNum as String,
  //         //     'Gagal Aktivasi Kartu');
  //         errorCode = '2';
  //         Get.to(() => AcknowledgementScreen(),
  //             transition: Transition.rightToLeft);
  //       }
  //     } else {
  //       // await EmailSending(getCardModelResponse?.accountNum as String,
  //       //     'Gagal Mendapatkan Kartu');
  //       errorCode = '1';
  //       Get.to(() => AcknowledgementScreen(),
  //           transition: Transition.rightToLeft);
  //     }
  //   }
  //   CustomLoading().dismissLoading();
  // }

  // Future<void> _updateCardResult(WrapResponse? _resUpdateCard) async {
  //   if (_resUpdateCard!.statusCode == 200) {
  //     CustomLoading().dismissLoading();
  //     print(_resUpdateCard.toJson());
  //     print(jsonEncode(_resUpdateCard.data?.body));
  //     updateCardModelResponse = UpdateCardModelResponse.fromJson(
  //         jsonDecode(_resUpdateCard.data?.body));

  //     update();
  //     return;

  //     print(updateCardModelResponse);
  //     await Future.delayed(Duration(seconds: 3));
  //     if ((updateCardModelResponse?.errorCode == null) ||
  //         updateCardModelResponse!.errorCode!.isEmpty) {
  //       var _resCreatPin = await Services().POST(urlCreatePin, 'Api Create Pin',
  //           body: await _bodyCreatePin, serviceType: 'xml');
  //       if (_resCreatPin!.statusCode == 200) {
  //         // await EmailSending(updateCardModelResponse?.accountNum as String,
  //         //     'Rekening Berhasil Terbuka');
  //         errorCode = "00";

  //         update();
  //         Get.to(() => AcknowledgementScreen(),
  //             transition: Transition.rightToLeft);
  //       } else {
  //         await EmailSending(
  //             getCardModelResponse?.accountNum as String, 'Gagal Membuat Pin');
  //         errorCode = "3";
  //         Get.to(() => AcknowledgementScreen(),
  //             transition: Transition.rightToLeft);
  //       }
  //     } else {
  //       await EmailSending(
  //           getCardModelResponse?.accountNum as String, 'Gagal Membuat Pin');
  //       errorCode = '3';
  //       Get.to(() => AcknowledgementScreen(),
  //           transition: Transition.rightToLeft);
  //     }
  //   }
  // }

  // Future<void> submit(BuildContext context, OtpController otpController) async {
  //   // setState(() {
  //   // });
  //   print(newInput);
  //   print(confirmInput);
  //   print(' error Code : ' + errorCode);

  //   if (newInput != confirmInput) {
  //     showDialog(
  //         context: context,
  //         builder: (_) {
  //           return const AlertDialog(
  //             title: Text("Peringatan!"),
  //             content: Text("pin baru tidak sama dengan pin konfirmasi"),
  //           );
  //         });
  //   } else {
  //     CustomLoading().showLoading("Memproses Data");
  //     await processData(otpController.createAccountModel!.cifNum,
  //         otpController.createAccountModel!.newAccountNum, pin.text);

  //     if (state == Status.Success) {
  //       await EmailSending(otpController.createAccountModel!.newAccountNum);
  //       // setState(() {
  //       //   isLoading = false;
  //       // });
  //       print('data error code : ' + errorCode);
  //       CustomLoading().dismissLoading();
  //       if (errorCode == "00") {
  //         // CustomLoading().dismissLoading();
  //         Get.to(() => AcknowledgementScreen(),
  //             transition: Transition.rightToLeft);
  //       }
  //     } else if (state == Status.Failed) {
  //       await EmailSending(otpController.createAccountModel!.newAccountNum);
  //       // setState(() {
  //       //   isLoading = false;
  //       // });
  //       // CustomLoading().dismissLoading();
  //       Get.to(() => AcknowledgementScreen(),
  //           transition: Transition.rightToLeft);
  //       CustomLoading().dismissLoading();
  //     } else {
  //       CustomLoading().showLoading("Memproses Data");
  //       await processData(otpController.createAccountModel!.cifNum,
  //           otpController.createAccountModel!.newAccountNum, pin.text);

  //       if (state == Status.Success) {
  //         await EmailSending(otpController.createAccountModel!.newAccountNum);
  //         // setState(() {
  //         //   isLoading = false;
  //         // });
  //         print('data error code : ' + errorCode);
  //         CustomLoading().dismissLoading();
  //         if (errorCode == "00") {
  //           // CustomLoading().dismissLoading();
  //           Get.to(() => AcknowledgementScreen(),
  //               transition: Transition.rightToLeft);
  //         }
  //       } else if (state == Status.Failed) {
  //         await EmailSending(otpController.createAccountModel!.newAccountNum);
  //         // setState(() {
  //         //   isLoading = false;
  //         // });
  //         // CustomLoading().dismissLoading();
  //         Get.to(() => AcknowledgementScreen(),
  //             transition: Transition.rightToLeft);
  //       } else {
  //         CustomLoading().dismissLoading();
  //       }
  //       // Navigator.of(context).push(
  //       //     MaterialPageRoute(builder: (context) => AcknowledgementScreen()));
  //     }
  //   }
  // }

  Future<void> getSharedprefData() async {
    // prefs = Get.find<DataController>().prefs;
    prefs = await SharedPreferences.getInstance();
    nik = prefs!.getString('nik').toString();
    numberPhone = prefs!.getString('nomorHandphone').toString();
    accountType = prefs!.getString('accountType').toString();
    email = prefs!.getString('email').toString();
    name = prefs!.getString('namaSesuaiKTP').toString();
    openAccReason = prefs!.getString('tujuanPembukaanRekening').toString();
    branch = prefs!.getString('kodeOutlet').toString();
    homePhone = prefs!.getString('noTelpRumah').toString();
    patronName = prefs!.getString('namaPemilikDana').toString();
    productType = prefs!.getString('produk').toString();
    outletName = prefs!.getString('namaOutlet').toString();

    cardName = prefs!.getString('namaKartu').toString();
    bin = prefs!.getString('bin').toString();
    card_type = prefs!.getString('cardType').toString();
    //Jika ada perubahan kartu, antara mas yafi atau rafi REVISI
    // if (namaKartu == "Taplus") {
    //   namaKartu = CardTypePrefs.namaKartuValue;
    //   bin = CardTypePrefs.binValue;
    //   card_type = CardTypePrefs.cardTypeValue;
    // }
    DateTime now = DateTime.now();

    registerDate =
        DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime(now.year, now.month, now.day));
    registerTime = DateFormat('HH:mm:ss').format(now) + " WIB";

    lastDepositDate =
        DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime(now.year, now.month + 1, now.day));

    refNumEmail = "${DateTime.now().millisecondsSinceEpoch}"
        "${(List.generate(7, (i) => rng.nextInt(9)).map((e) => e)).join("")}";
    print("sharedpref loading done");
    processData();
  }

  processData() {
    // isLoading = true;
    if (productType?.toLowerCase() == 'taplus muda') {
      // setState(() {
      initialDeposit = '100.000,';
      update();
      // });
    } else if (productType?.toLowerCase() == 'taplus') {
      // setState(() {
      initialDeposit = '250.000,';
      update();
      // });
    } else if (productType?.toLowerCase() == 'taplus bisnis') {
      // setState(() {
      initialDeposit = '1.000.000,';
      update();
      // });
    } else if (productType?.toLowerCase() == 'taplus diaspora') {
      // setState(() {
      initialDeposit = '500.000,';
      update();
      // });
    }
  }

  Future<void> cardAndPin({
    required String refnum,
    required String accountNum,
    required String cifNum,
    required String bin,
    required String cardType,
    required String pin,
    required SharedPreferences prefs,
  }) async {
    // emit(StateLoading());
    state = Status.Loading;
    // print(state);
    cardandPinModel = await GetcardService()
        .getCard(accountNum: accountNum, cifNum: cifNum, bin: bin, cardType: cardType);

    prefs.setString("cardNumber", cardandPinModel!.cardNum);

    // emit(GetCardStateSuccess(cardandPinModel));
    if (cardandPinModel!.errorCode == "") {
      // print(state);

      cardandPinModelActivate = await ActivateCardService().activateCard(
          accountNum: cardandPinModel!.accountNum,
          cardNum: cardandPinModel!.cardNum,
          cifNumm: cardandPinModel!.cifNum,
          bin: bin,
          card_type: cardType);
      // emit(ActivateCardStateSuccess(cardandPinModelActivate));
      if (cardandPinModelActivate!.errorCode == "") {
        // print(state);
        CardandPinModel cardandPinModelUpdate = await UpdateCardService().updateCard(
            accountNum: cardandPinModelActivate!.accountNum,
            bin: bin,
            cardNum: cardandPinModel!.cardNum,
            cardType: cardType,
            cifNum: cardandPinModel!.cifNum);
        // emit(UpdateCardStateSuccess(cardandPinModelUpdate));
        // print(state);
        if (cardandPinModelUpdate.errorCode == '') {
          // print(state);
          errorCode = await CreatePinService().createPin(
              refnum: refnum,
              cardnum: cardandPinModel!.cardNum,
              accountnum: cardandPinModel!.accountNum,
              pin: pin);
          // print("ini Error Code : " + errorCode);
          if (errorCode != '00') {
            state = Status.Failed;
            errorCode = '3';
            // print("ini error code " + errorCode);
            // emit(CardandPinErrorCode(errorCode, cardandPinModelUpdate));
          } else {
            errorCode = "00";
            state = Status.Success;
            // emit(GetCreatePin('00', cardandPinModelUpdate));
            // print("ini error code " + errorCode);
          }
          // await Future.delayed(Duration(seconds: 3), () {
          //
          // });
        }
      } else {
        state = Status.Failed;
        errorCode = '2';
        // emit(CardandPinErrorCode(errorCode, cardandPinModelActivate));
      }
    } else {
      state = Status.Failed;
      errorCode = '1';
      // emit(CardandPinErrorCode(errorCode, cardandPinModel));
    }
  }

//

  get bodyReceiptEmail => '''
<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:rec='http://service.bni.co.id/receipt' xmlns:obj='http://service.bni.co.id/receipt/obj'><soapenv:Header/><soapenv:Body><rec:compose><rec:request><obj:channelId>EFORM</obj:channelId><obj:jsonStringParams>{'custName':'$name','refNum':'$refNumEmail','registerDate':'$registerDate','registerTime':'$registerTime','newAccountNum':'${getCardModelResponse!.accountNum}','accountType':'$productType','cardNum':'${getCardModelResponse!.cardNum}','accountBranch':'$outletName','branchName':'$outletName','accStatus':'$accStatus','cardType':'${cardName}','initialDeposit':'$initialDeposit','lastDepositDate':'$lastDepositDate'}</obj:jsonStringParams><obj:providerId>$provider</obj:providerId></rec:request></rec:compose></soapenv:Body></soapenv:Envelope>
''';

  get bodySendEmail =>
      '''<?xml version='1.0'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:mail='http://service.bni.co.id/mail'><soapenv:Header/><soapenv:Body><mail:send><emailOut><from>new-mobile-banking@bni.co.id</from><to>$email</to><subject>Pembukaan Rekening BNI</subject><content><![CDATA[<html><head></head><body>$responseGetreceipt</body></html>]]></content></emailOut></mail:send></soapenv:Body></soapenv:Envelope>''';

  Future<void> testEmail() async {
    // CustomLoading().showLoading('Memuat Data');
    await Future.delayed(Duration(seconds: 3));
    var _resEmail =
        await Services().POST(urlReceiptEmail, 'Api Get Receipt Email', body: bodyReceiptEmail);
    print(_resEmail!.statusCode);
    responseGetreceipt = _resEmail.data?.body;
    String _replace1 =
        ('<?xml version="1.0" encoding="utf-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><composeResponse xmlns="http://service.bni.co.id/receipt"><composeReturn><channelId>EFORM</channelId><receipt>&lt;html&gt;');
    String _replace1a = ('&lt;head&gt;');
    String _replace1b = ('&lt;/head&gt;');
    String _replace1c = ('&lt;body&gt;');
    String _replace1d = ('&lt;/body&gt;');
    String replaced = responseGetreceipt.replaceAll(_replace1, "");
    String replaced2 = replaced.replaceAll(_replace1a, "");
    String replaced3 = replaced2.replaceAll(_replace1b, "");
    String replaced4 = replaced3.replaceAll(_replace1c, "");
    String replaced5 = replaced4.replaceAll(_replace1d, "");
    String replaced6 = replaced5.replaceAll("&lt;", "<");
    String replaced7 = replaced6.replaceAll("&gt;", ">");
    String replaced8 = replaced7.replaceAll("&amp;", "&");
    String replaced9 = replaced8.replaceAll("&quot;", '"');
    String replaced10 = replaced9.replaceAll("</html>", '');
    String replaced11 = replaced10.replaceAll(
        "</receipt></composeReturn></composeResponse></soapenv:Body></soapenv:Envelope>", '');
    responseGetreceipt = replaced11;
    if (_resEmail.statusCode == 200) {
      await Future.delayed(Duration(seconds: 3));
      var _resSendEmail =
          await Services().POST(urlSendEmail, 'Api Send Email', body: bodySendEmail);
      print("Ini Status Code Send Email : ${_resSendEmail?.statusCode}");
      if (_resSendEmail?.statusCode == 200) {
        print('Berhasil Kirim Email');
      } else {
        print('Gagal Kirim Email');
      }
      CustomLoading().dismissLoading();
    } else {
      print('gagal Receipt Email');
    }
    // dev.log(responseGetreceipt);
  }
}
