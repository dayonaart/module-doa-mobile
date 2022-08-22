import 'dart:convert';
import 'dart:developer';

// import 'package:device_info/device_info.dart';
// import 'package:detail/device_detail.dart';
import 'package:device_info/device_info.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/PhoneVerifyController.dart';
import 'package:eform_modul/response_model/create_account_model.dart';
import 'package:eform_modul/response_model/data_diri1_model_pref.dart';
import 'package:eform_modul/response_model/send_otp_model_response.dart';
import 'package:eform_modul/service/services.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/data-file/data-file-list.dart';
import 'package:eform_modul/src/views/datadiri-page/data-diri-1.dart';
import 'package:eform_modul/src/views/register/create_pin/create_pin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../response_model/device_properties.dart';
import '../../service/create-account.dart';
import '../../service/save-photo.dart';
import '../../service/send-otp.dart';
import '../../src/components/Global.dart';
import '../../src/components/url-api.dart';
import '../../src/models/create-account-model.dart';
import '../../src/models/send-otp-model.dart';
import '../../src/utility/custom_loading.dart';

class OtpController extends GetxController {
  AnimationController? animationController;
  SendOtpModel? sendOtpModel;
  TextEditingController otpCode = TextEditingController();
  // DataController dataController = Get.put(DataController());
  String image = '';
  String idSelfiePhoto = '';
  String idPhoto = '';
  String signaturePhoto = '';
  bool messageHeaderSendOtp = false;
  String originalSelfiePhotoSize = '';
  String compressedSelfiePhotoSize = '';

  String originalIdSelfiePhotoSize = '';
  String compressedIdSelfiePhotoSize = '';

  String originalIdPhotoSize = '';
  String compressedIdPhotoSize = '';

  String originalSignaturePhotoSize = '';
  String compressedSignaturePhotoSize = '';
  String headerErrorCode = '';
  String idNumber = '';
  String phoneNumber = "";
  String biLocationCode = "";

  String accountType = '';
  String email = '';
  String motherMaidenName = '';
  String name = '';
  String pob = '';
  String subCat = '';
  String srcOfFund = '';
  String openAccReason = '';
  String othersOpenAccReason = '';
  String othersSrcOfFund = '';

  String taxId = '';
  String customerAddress = '';
  String neighbourhood = '';
  String hamlet = '';
  String urbanVillage = '';
  String subDistrict = '';
  String city = '';
  String province = '';
  String postalCode = '';
  String country = '';
  String alamatDomisili = '';
  String job = '';
  String yearlyIncome = '';
  String dateOfBirth = '';

  String jobAddress = '';
  String branch = '';
  String jobDetail = '';
  String gender = '';
  String status = '';
  String jobPostalCode = '';
  String jobPlace = '';
  String patronCompanyAddress = '';
  String patronMobileNum = '';
  String patronRelationship = '';
  String cityPublisher = '';
  String religion = '';
  String landline = '';
  String officePhone = '';
  String patronName = '';
  String projDep = '';
  String currentText = '';
  bool isHide = true;
  String otpSender = '';

  String channelPromotionCode = '';
  Status state = Status.Initial;
  CreateAccountModel? createAccountModel;
  SharedPreferences? prefs;
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

  final formKey = GlobalKey<FormState>();

  String? validation(String val) {
    if (val.isEmpty) {
      return "Kode OTP tidak boleh kosong";
    }
    if (val.length < 6) {
      return "Kode OTP minimal 6 karakter";
    }
    return null;
  }

  bool validationButton = false;

  void onchanged(String validation) {
    if (validation.length == 6) {
      validationButton = true;
      return;
    }
    validationButton = false;
    update();
  }

  Future<Map<String, dynamic>> get _body async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      //dari token di mobile tidak usah
      "idMitra": "",
      //hardcode
      "channel": "EFORM",
      //sama seperti idMitra
      "tellerId": "",
      //Gausah
      "accountNum": "",
      //dari page Pemilihan Cabang
      "branch": branch,
      //dari halaman pilih tabungan
      "accountType": accountType,
      //dari halaman pilih tabungan
      "subCat": subCat,
      //dari halaman pilih pekerjaan,tujuan pembukaan rekening
      "othersOpenAccReason": othersOpenAccReason, //tujuan pembukaan dana lainnya
      //dari halaman pilih pekerjaan,tujuan pembukaan rekening
      "othersSrcOfFund": othersSrcOfFund,
      //nik
      "idNum": Get.find<PhoneVerifyController>().idNumber,
      //hardoce
      "idType": "0001",
      //name
      "customerName": name,
      //tempat lahir
      "pob": pob,
      //tanggal lahir
      "dateOfBirth": dateOfBirth,
      //namaibu
      "motherMaidenName": motherMaidenName,
      //email
      "email": email,
      //nomor home (bisa kosong, default 99999999)
      "homePhone": landline,
      //nomor hp
      "mobileNum": phoneNumber,
      //ga di isi di form
      "education": "",
      //ga di isi di form
      "hobby": "",
      //dari halaman pilih pekerjaan,tujuan pembukaan rekening (hanya pilih sumber dana saja)
      "openAccReason": openAccReason,
      //ngikut openAccReason (sumber dana)
      "srcOfFund": srcOfFund, //sumber dana ddl
      //perkiraan transaksi pertahun
      "projDep": projDep,
      //npwp (bisa kosong, default, 999999999999999)
      "taxId": taxId,
      //Alamat tempat tinggal
      "customerAddress": customerAddress,
      //rt
      "rt": neighbourhood,
      //rw
      "rw": hamlet,
      //kelurahan
      "kelurahan": urbanVillage,
      //dropdown kecamatan
      "kecamatan": subDistrict,
      //dropdown city
      "city": city,
      //dropdown province
      "province": province,
      //dropdown postalCode
      "postalCode": postalCode,
      //dropdown (bisa kosong, default kosong)
      "negara": country,
      //alamatDomisili (bisa kosong, default kosong)
      "alamatDomisili": alamatDomisili,
      //dari dropdown pekerjaan
      "job": job,
      //dari pekerjaan bagian penghasilan perbulan
      "yearlyIncome": yearlyIncome,
      //tidak ada di field
      "companyName": "",
      //tidak ada di field
      "companyAddress": "",
      //tidak ada di field
      "companyAddress2": "",
      //tidak ada di field
      "officePostalCode": "",
      //tidak ada di field
      "jobTitle": "",
      //tidak ada di field
      "startWorkDate": "",
      //nomor telfon tempat kerja, dari deetail pekerjaan (default 99999999)
      "officePhone": officePhone,
      //nama pemberi dana (bisa kosong, default kosong)
      "patronName": patronName,
      //ga ada di field
      "patronIdType": "",
      //ga ada di field
      "patronIdNum": "",
      //ga ada di field
      "patronTaxId": "",
      //ga ada di field
      "patronAddress": "",
      //ga ada di field
      "patronRt": "",
      //ga ada di field
      "patronRw": "",
      //ga ada di field
      "patronBuilding": "",
      //ga ada di field
      "patronKel": "",
      //ga ada di field
      "patronKec": "",
      //ga ada di field
      "patronCity": "",
      //ga ada di field
      "patronProvince": "",
      //ga ada di field
      "patronSrcOfFund": "",
      //ga ada di field
      "patronYearlyIncome": "",
      //ga ada di field
      "patronOpenAccReason": "",
      //ga ada di field
      "patronJob": "",
      //ga ada di field
      "patronJobTitle": "",
      //dari halaman pemberi dana, hubungan pemberi dana
      "patronRelationship": patronRelationship,
      //ga ada di field
      "patronPob": "",
      //ga ada di field
      "patronDob": "",
      //ga ada di field
      "patronNationality": "",
      //ga ada di field
      "patronMarriageStatus": "",
      //ga ada di field
      "patronCompany": "",
      //Halaman simpanan pemilik dana, dari alamat pemberi dana
      "patronCompanyAddress": patronCompanyAddress,
      //ga ada di field
      "patronCompanyAddress2": "",
      //ga ada di field
      "patronCompanyPhone": "",
      //ga ada di field
      "patronCompanyPostalCode": "",
      //Halaman simpanan pemilik dana, dari nomor telefon pemilik dana
      "patronMobileNum": patronMobileNum,
      //Data file, (hanya dikirim ketika hit api create account)
      "selfiePhoto": "",
      //ga ada di field
      "idPhoto": "",
      //ga ada di field
      "idSelfiePhoto": "",
      //ga ada di field
      "signaturePhoto": "",
      //referal code (boleh kosong, default kosong)
      "channelPromotionCode": channelPromotionCode,
      //ini otp yang di isikan user (untuk hit api creaete account)
      "otp": "otp_req",
      //ini refnum dapat dari response api send otp
      "refNum": "",
      //dari data diri2
      "gender": gender,
      //ga ada di field
      "tglLahirPemberiDana": "",
      //dari data diri2
      "religion": religion,
      //data diri2
      "publisherCity": cityPublisher,
      //dari data diri2
      "isMaried": status,
      //ga ada di field
      "jenisKelaminPemberiDana": "",
      //ga ada di field
      "alamatLain": "",
      //ga ada di field
      "perumLain": "",
      //ga ada di field
      "rtLainPemberiDana": "",
      //ga ada di field
      "rwLainPemberiDana": "",
      //ga ada di field
      "provinsiLainPemberiDana": "",
      //ga ada di field
      "kabupatenLain": "",
      //ga ada di field
      "kecamatanLainPemberiDana": "",
      //ga ada di field
      "kelDesaLainPemberiDana": "",
      //ga ada di field
      "kodeposLain": "",
      //ga ada di field
      "rtKerjaPemberiDana": "",
      //ga ada di field
      "rwKerjaPemberiDana": "",
      //ga ada di field
      "provinsiKerjaPemberiDana": "",
      //ga ada di field
      "kabKerjaPemberiDana": "",
      //ga ada di field
      "kecamatanKerjaPemberiDana": "",
      //ga ada di field
      "kelDesaKerjaPemberiDana": "",
      //ga ada di field
      "kodeposKerjaPemberiDana": "",
      //ga ada di field
      "noTelp2KerjaPemberiDana": "",
      //ga ada di field
      "komplekKerjaPemberiDana": "",
      //ga ada di field
      "adaNPWP": "",
      //Detail Pekerjaan
      "detailPekerjaan": jobDetail,
      //Detail Pekerjaan
      "namaTempatKerja": jobPlace,
      //ga ada di field
      "alamatTempatKerja2": "",
      //Detail Pekerjaan
      "alamatTempatKerja": jobAddress,
      //Detail Pekerjaan (diketik bukan dropdown)
      "kodePos": jobPostalCode,
      //gabungan dari data cabang (kode outlet kantor cabang.json, di mapping dengan sandi bi dari bi.json)
      "biLocationCode": biLocationCode,
      //Method send otp
      "otpSender": prefs!.getString('otpSender').toString(),
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  Future<Map<String, dynamic>> get _bodyCreateAccount async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      //dari token di mobile tidak usah
      "idMitra": "",
      //hardcode
      "channel": "EFORM",
      //sama seperti idMitra
      "tellerId": "",
      //Gausah
      "accountNum": "",
      //dari page Pemilihan Cabang
      "branch": branch,
      //dari halaman pilih tabungan
      "accountType": accountType,
      //dari halaman pilih tabungan
      "subCat": subCat,
      //dari halaman pilih pekerjaan,tujuan pembukaan rekening
      "othersOpenAccReason": othersOpenAccReason, //tujuan pembukaan dana lainnya
      //dari halaman pilih pekerjaan,tujuan pembukaan rekening
      "othersSrcOfFund": othersSrcOfFund,
      //nik
      "idNum": Get.find<PhoneVerifyController>().idNumber,
      //hardoce
      "idType": "0001",
      //name
      "customerName": name,
      //tempat lahir
      "pob": pob,
      //tanggal lahir
      "dateOfBirth": dateOfBirth,
      //namaibu
      "motherMaidenName": motherMaidenName,
      //email
      "email": email,
      //nomor home (bisa kosong, default 99999999)
      "homePhone": landline,
      //nomor hp
      "mobileNum": phoneNumber,
      //ga di isi di form
      "education": "",
      //ga di isi di form
      "hobby": "",
      //dari halaman pilih pekerjaan,tujuan pembukaan rekening (hanya pilih sumber dana saja)
      "openAccReason": openAccReason,
      //ngikut openAccReason (sumber dana)
      "srcOfFund": srcOfFund, //sumber dana ddl
      //perkiraan transaksi pertahun
      "projDep": projDep,
      //npwp (bisa kosong, default, 999999999999999)
      "taxId": taxId,
      //Alamat tempat tinggal
      "customerAddress": customerAddress,
      //rt
      "rt": neighbourhood,
      //rw
      "rw": hamlet,
      //kelurahan
      "kelurahan": urbanVillage,
      //dropdown kecamatan
      "kecamatan": subDistrict,
      //dropdown city
      "city": city,
      //dropdown province
      "province": province,
      //dropdown postalCode
      "postalCode": postalCode,
      //dropdown (bisa kosong, default kosong)
      "negara": country,
      //alamatDomisili (bisa kosong, default kosong)
      "alamatDomisili": alamatDomisili,
      //dari dropdown pekerjaan
      "job": job,
      //dari pekerjaan bagian penghasilan perbulan
      "yearlyIncome": yearlyIncome,
      //tidak ada di field
      "companyName": "",
      //tidak ada di field
      "companyAddress": "",
      //tidak ada di field
      "companyAddress2": "",
      //tidak ada di field
      "officePostalCode": "",
      //tidak ada di field
      "jobTitle": "",
      //tidak ada di field
      "startWorkDate": "",
      //nomor telfon tempat kerja, dari deetail pekerjaan (default 99999999)
      "officePhone": officePhone,
      //nama pemberi dana (bisa kosong, default kosong)
      "patronName": patronName,
      //ga ada di field
      "patronIdType": "",
      //ga ada di field
      "patronIdNum": "",
      //ga ada di field
      "patronTaxId": "",
      //ga ada di field
      "patronAddress": "",
      //ga ada di field
      "patronRt": "",
      //ga ada di field
      "patronRw": "",
      //ga ada di field
      "patronBuilding": "",
      //ga ada di field
      "patronKel": "",
      //ga ada di field
      "patronKec": "",
      //ga ada di field
      "patronCity": "",
      //ga ada di field
      "patronProvince": "",
      //ga ada di field
      "patronSrcOfFund": "",
      //ga ada di field
      "patronYearlyIncome": "",
      //ga ada di field
      "patronOpenAccReason": "",
      //ga ada di field
      "patronJob": "",
      //ga ada di field
      "patronJobTitle": "",
      //dari halaman pemberi dana, hubungan pemberi dana
      "patronRelationship": patronRelationship,
      //ga ada di field
      "patronPob": "",
      //ga ada di field
      "patronDob": "",
      //ga ada di field
      "patronNationality": "",
      //ga ada di field
      "patronMarriageStatus": "",
      //ga ada di field
      "patronCompany": "",
      //Halaman simpanan pemilik dana, dari alamat pemberi dana
      "patronCompanyAddress": patronCompanyAddress,
      //ga ada di field
      "patronCompanyAddress2": "",
      //ga ada di field
      "patronCompanyPhone": "",
      //ga ada di field
      "patronCompanyPostalCode": "",
      //Halaman simpanan pemilik dana, dari nomor telefon pemilik dana
      "patronMobileNum": patronMobileNum,
      //Data file, (hanya dikirim ketika hit api create account)
      "selfiePhoto": image,
      //ga ada di field
      "idPhoto": "",
      //ga ada di field
      "idSelfiePhoto": "",
      //ga ada di field
      "signaturePhoto": "",
      //referal code (boleh kosong, default kosong)
      "channelPromotionCode": channelPromotionCode,
      //ini otp yang di isikan user (untuk hit api creaete account)
      "otp": currentText,
      //ini refnum dapat dari response api send otp
      "refNum": sendOtpModelResponse!.refNum,
      // "refNum": sendOtpModelResponse!.refNum, JANGAN LUPA NANTI DIGANTI SAMA INI
      //dari data diri2
      "gender": gender,
      //ga ada di field
      "tglLahirPemberiDana": "",
      //dari data diri2
      "religion": religion,
      //data diri2
      "publisherCity": cityPublisher,
      //dari data diri2
      "isMaried": status,
      //ga ada di field
      "jenisKelaminPemberiDana": "",
      //ga ada di field
      "alamatLain": "",
      //ga ada di field
      "perumLain": "",
      //ga ada di field
      "rtLainPemberiDana": "",
      //ga ada di field
      "rwLainPemberiDana": "",
      //ga ada di field
      "provinsiLainPemberiDana": "",
      //ga ada di field
      "kabupatenLain": "",
      //ga ada di field
      "kecamatanLainPemberiDana": "",
      //ga ada di field
      "kelDesaLainPemberiDana": "",
      //ga ada di field
      "kodeposLain": "",
      //ga ada di field
      "rtKerjaPemberiDana": "",
      //ga ada di field
      "rwKerjaPemberiDana": "",
      //ga ada di field
      "provinsiKerjaPemberiDana": "",
      //ga ada di field
      "kabKerjaPemberiDana": "",
      //ga ada di field
      "kecamatanKerjaPemberiDana": "",
      //ga ada di field
      "kelDesaKerjaPemberiDana": "",
      //ga ada di field
      "kodeposKerjaPemberiDana": "",
      //ga ada di field
      "noTelp2KerjaPemberiDana": "",
      //ga ada di field
      "komplekKerjaPemberiDana": "",
      //ga ada di field
      "adaNPWP": "",
      //Detail Pekerjaan
      "detailPekerjaan": jobDetail,
      //Detail Pekerjaan
      "namaTempatKerja": jobPlace,
      //ga ada di field
      "alamatTempatKerja2": "",
      //Detail Pekerjaan
      "alamatTempatKerja": jobAddress,
      //Detail Pekerjaan (diketik bukan dropdown)
      "kodePos": postalCode,
      //gabungan dari data cabang (kode outlet kantor cabang.json, di mapping dengan sandi bi dari bi.json)
      "biLocationCode": biLocationCode,
      //Method send otp
      "otpSender": "SMS",
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

//ENHANCE SERVICE SENDOTP
  SendOtpModelResponse? sendOtpModelResponse;
  Future<void> submitSendOtp() async {
    CustomLoading().showLoading('Memuat Data');
    try {
      var body = await _body;
      // print(body);
      var _res = await Services().POST(urlSendOtpAndCreateAccount, 'Api Send Otp', body: body);

      // print('Ini di otpController ' + prefs!.getString('otpSender').toString());
      // print(_res?.toJson());

      var errorHeaderCode = _res?.data?.header['code'].toString();
      // print(errorHeaderCode);
      CustomLoading().dismissLoading();
      // return;
      if (_res?.statusCode == 200) {
        sendOtpModelResponse = SendOtpModelResponse.fromJson(_res?.data?.body);
        var _jwtBody = (_res?.data?.body as Map<String, dynamic>).values.toList();

        assert(Global().compareableJwtBody(
            responseBody: sendOtpModelResponse?.toJson().values.toList(), jwtBody: _jwtBody));

        if ((sendOtpModelResponse?.errorCode == null) || sendOtpModelResponse!.errorCode!.isEmpty) {
          CustomLoading().dismissLoading();
          Get.offNamed(Routes().otp);
        } else if (sendOtpModelResponse!.errorCode == '9001') {
          messageHeaderSendOtp = true;
          CustomLoading().dismissLoading();
          Get.offNamed(Routes().datadiri);
        } else {
          messageHeaderSendOtp = true;
          CustomLoading().dismissLoading();
          ERROR_DIALOG(errorCode: sendOtpModelResponse?.errorCode);
        }
      } else if (_res?.statusCode == 400 || errorHeaderCode == '1003') {
        // print('Ini Adalah : ${_res?.data?.header}');
        messageHeaderSendOtp = true;
        // print(messageHeaderSendOtp);
        headerErrorCode = errorHeaderCode.toString();

        CustomLoading().dismissLoading();
        // return;
        // print(createAccountModelResponse!.errorCode);

        Get.offAll(() => DataDiri1(), transition: Transition.rightToLeft);
        // Get.toNamed(Routes().datadiri);
      } else {
        // print('Kesinisds');
        CustomLoading().dismissLoading();
        ERROR_DIALOG(errorCode: sendOtpModelResponse?.errorCode);
      }
    } on AssertionError {
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: '000');
    } catch (e) {
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: sendOtpModelResponse?.errorCode);
      print(e);
    }
  }

//ENHANCE SERVICE CREATE ACCOUNT
  CreateAccountModelResponse? createAccountModelResponse;
  Future<void> createAccountDio() async {
    CustomLoading().showLoading('Memuat Data');

    try {
      // await Future.delayed(Duration(seconds: 1));
      var bodyCreateAccount = await _bodyCreateAccount;
      // log(bodyCreateAccount.toString());
      // print(sendOtpModelResponse!.refNum);
      var _res = await Services()
          .POST(urlSendOtpAndCreateAccount, 'Api Create Account', body: bodyCreateAccount);
      // print("Ini Adalah Respon Create Account : ${_res!.toJson()}");
      // print(
      //     "Ini Adalah error Code di Create Account : ${_res.toJson()['data']['body']['errorCode']}");
      // print(sendOtpModelResponse!.refNum);
      // log(jsonEncode(_bodyCreateAccount));
      // log(jsonDecode(_bodyCreateAccount));
      if (_res?.statusCode == 200) {
        createAccountModelResponse = CreateAccountModelResponse.fromJson(_res?.data?.body);
        var _jwtBody = (_res?.data?.body as Map<String, dynamic>).values.toList();

        assert(Global().compareableJwtBody(
            responseBody: createAccountModelResponse?.toJson().values.toList(), jwtBody: _jwtBody));

        if ((_res?.toJson()['data']['body']['errorCode']) != '') {
          CustomLoading().dismissLoading();

          if (createAccountModelResponse!.errorCode == '9015' ||
              createAccountModelResponse!.errorCode == '9016' ||
              createAccountModelResponse!.errorCode == '9017' ||
              createAccountModelResponse!.errorCode == '9018' ||
              createAccountModelResponse!.errorCode == '9019' ||
              createAccountModelResponse!.errorCode == '9020' ||
              createAccountModelResponse!.errorCode == '9021') {
            CustomLoading().dismissLoading();

            Get.offAll(() => DataDiri1(), transition: Transition.rightToLeft);
          } else {
            CustomLoading().dismissLoading();
            // print(createAccountModelResponse!.errorCode);
            Get.offAll(() => DataFileListPage(), transition: Transition.rightToLeft);
          }
        } else {
          await savePhotoDio();
          CustomLoading().dismissLoading();
          Get.offNamed(Routes().createPin);
        }
      } else {
        CustomLoading().dismissLoading();
        ERROR_DIALOG(errorCode: '000');
      }
    } on AssertionError {
      CustomLoading().dismissLoading();
      ERROR_DIALOG(errorCode: '000');
    } catch (e) {
      CustomLoading().dismissLoading();
      ERROR_DIALOG();
    }
  }

  getData() async {
    if (prefs == null) prefs = Get.find<DataController>().prefs;
    // prefs = Get.find<DataController>().prefs;
    image = prefs!.getString('selfiePhoto') ?? '';
    idSelfiePhoto = prefs!.getString('idSelfiePhoto') ?? '';
    idPhoto = prefs!.getString('idPhoto') ?? '';
    signaturePhoto = prefs!.getString('signaturePhoto') ?? '';

    originalSelfiePhotoSize = prefs!.getString('originalSelfiePhotoSize') ?? '';
    compressedSelfiePhotoSize = prefs!.getString('compressedSelfiePhotoSize') ?? '';

    originalIdSelfiePhotoSize = prefs!.getString('originalIdSelfiePhotoSize') ?? '';
    compressedIdSelfiePhotoSize = prefs!.getString('compressedIdSelfiePhotoSize') ?? '';

    originalIdPhotoSize = prefs!.getString('originalIdPhotoSize') ?? '';
    compressedIdPhotoSize = prefs!.getString('compressedIdPhotoSize') ?? '';

    originalSignaturePhotoSize = prefs!.getString('originalSignaturePhotoSize') ?? '';
    compressedSignaturePhotoSize = prefs!.getString('compressedSignaturePhotoSize') ?? '';

    idNumber = prefs!.getString('nik') ?? '';
    // print(idNumber);

    phoneNumber = prefs!.getString('dialCodeNegara')! + prefs!.getString('nomorHandphone')!;

    biLocationCode = prefs!.getString('kotaBI') ?? '';

    accountType = prefs!.getString('accountType') ?? '';
    subCat = prefs!.getString('subCat') ?? '';
    email = prefs!.getString('email') ?? '';
    motherMaidenName = prefs!.getString('namaIbuKandung') ?? '';
    name = prefs!.getString('namaSesuaiKTP') ?? '';
    pob = prefs!.getString('tempatLahir') ?? '';

    othersOpenAccReason = prefs!.getString('sumberDanaLainnya') ?? '';
    othersSrcOfFund = prefs!.getString('sumberDanaLainnya') ?? '';

    taxId = prefs!.getString('npwp') ?? '';
    customerAddress = prefs!.getString('alamat') ?? '';
    neighbourhood = prefs!.getString('rt') ?? '';
    hamlet = prefs!.getString('rw') ?? '';
    urbanVillage = prefs!.getString('desa') ?? '';
    subDistrict = prefs!.getString('kecamatan') ?? '';
    city = prefs!.getString('kota') ?? '';
    province = prefs!.getString('provinsi') ?? '';
    postalCode = prefs!.getString('kodePos') ?? '';
    country = prefs!.getString('negaraDomisili') ?? '';
    alamatDomisili = prefs!.getString('alamatDomisili') ?? '';
    job = prefs!.getString('pekerjaan') ?? '';
    yearlyIncome = prefs!.getString('penghasilanPerbulan') ?? '';
    dateOfBirth = prefs!.getString('tanggalLahir') ?? '';

    srcOfFund = prefs!.getString('sumberDana') ?? '';
    openAccReason = prefs!.getString('tujuanPembukaanRekening') ?? '';
    jobAddress = prefs!.getString('alamatTempatKerjaDetailPekerjaan') ?? '';
    branch = prefs!.getString('kodeOutlet') ?? ''; //belum
    jobDetail = prefs!.getString('detailPekerjaan') ?? '';
    gender = prefs!.getString('jenisKelamin') ?? '';
    status = prefs!.getString('statusPerkawinan') ?? '';
    jobPostalCode = prefs!.getString('kodePosDetailPekerjaan') ?? '';
    jobPlace = prefs!.getString('namaTempatKerjaDetailPekerjaan') ?? '';
    patronCompanyAddress = prefs!.getString('alamatPemilikDana') ?? '';
    patronMobileNum = prefs!.getString('telpPemilikDana') ?? '';
    patronRelationship = prefs!.getString('hubunganPemberiDana') ?? '';
    cityPublisher = prefs!.getString('kotaPenerbitIdentitas') ?? '';
    religion = prefs!.getString('agama') ?? '';
    landline = '${prefs!.getString('prefixnoTelpRumah')}${prefs!.getString('noTelpRumah')}';
    officePhone = prefs!.getString('noTelpDetailPekerjaan') ?? '';
    patronName = prefs!.getString('namaPemilikDana') ?? '';
    projDep = prefs!.getString('perkiraanNilaiTransaksi') ?? '';

    otpSender = prefs!.getString('otpSender') ?? '';

    channelPromotionCode = prefs!.getString('kode_referal') ?? '';
    update();
    // CustomLoading().dismissLoading();
  }

  sendOTP(String OtpSender) async {
    sendOtpModel = await SendOtpService().sendOtp(
        nik: idNumber,
        mobileNum: phoneNumber,
        otpSender: OtpSender,
        biLocationCode: biLocationCode,
        accountType: accountType,
        email: email,
        motherMaidenName: motherMaidenName,
        name: name,
        pob: pob,
        subCat: subCat,
        othersOpenAccReason: othersOpenAccReason,
        othersSrcOfFund: othersSrcOfFund,
        taxId: taxId,
        customerAddress: customerAddress,
        rt: neighbourhood,
        rw: hamlet,
        kelurahan: urbanVillage,
        kecamatan: subDistrict,
        city: city,
        province: province,
        postalCode: postalCode,
        negara: country,
        alamatDomisili: alamatDomisili,
        job: job,
        yearlyIncome: yearlyIncome,
        dateOfBirth: dateOfBirth,
        alamatTempatKerja: jobAddress,
        branch: branch,
        detailPekerjaan: jobDetail,
        gender: gender,
        isMaried: status,
        kodePos: jobPostalCode,
        namaTempatKerja: jobPlace,
        patronCompanyAddress: patronCompanyAddress,
        patronMobileNum: patronMobileNum,
        patronRelationship: patronRelationship,
        publisherCity: cityPublisher,
        religion: religion,
        homePhone: landline,
        officePhone: officePhone,
        patronName: patronName,
        projDep: projDep,
        openAccReason: openAccReason,
        srcOfFund: srcOfFund,
        channelPromotionCode: channelPromotionCode);
  }

  Future<Map<String, dynamic>> get _bodySavePhotoSelfie async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      'type': 'selfie',
      'nik': idNumber,
      'photo': idSelfiePhoto,
      'originalSize': originalIdSelfiePhotoSize,
      'convertSize': compressedIdSelfiePhotoSize,
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  Future<Map<String, dynamic>> get _bodySavePhotoKTP async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      'type': 'ktp',
      'nik': idNumber,
      'photo': idPhoto,
      'originalSize': originalIdPhotoSize,
      'convertSize': compressedIdPhotoSize,
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  Future<Map<String, dynamic>> get _bodySavePhotoTTD async {
    final devicePropertiesPlugin = DeviceInfo();
    var device = await devicePropertiesPlugin.getDeviceInfo();
    return {
      'type': 'ttd',
      'nik': idNumber,
      'photo': signaturePhoto,
      'originalSize': originalSignaturePhotoSize,
      'convertSize': compressedSignaturePhotoSize,
      "userAppVersion_code": device?.appVersionCode,
      "userAppVersion_name": device?.buildVersionCode,
      "device_type": device?.deviceType,
      "osVersion": device?.osVersion,
      "ip_address": device?.ipAddress
    };
  }

  Future<void> savePhotoDio() async {
    var bodySavePhotoSelfie = await _bodySavePhotoSelfie;
    var _resSelfie =
        await Services().POST(urlSavePhoto, 'Api Save Photo', body: bodySavePhotoSelfie);
    // print("Ini Adalah Status Code Dari Save Photo Selfie" +
    //     _resSelfie!.statusCode.toString());
    await Future.delayed(Duration(seconds: 3));
    var bodySavePhotoKtp = await _bodySavePhotoKTP;
    var _resKTP = await Services().POST(urlSavePhoto, 'Api Save Photo', body: bodySavePhotoKtp);
    // print("Ini Adalah Status Code Dari Save Photo KTP" +
    //     _resKTP!.statusCode.toString());
    await Future.delayed(Duration(seconds: 3));
    var bodySavePhotoTTD = await _bodySavePhotoTTD;
    var _resTTD = await Services().POST(urlSavePhoto, 'Api Save Photo', body: bodySavePhotoTTD);
    // print("Ini Adalah Status Code Dari Save Photo TTD" +
    //     _resTTD!.statusCode.toString());
  }

  savePhoto(
      {required String photo,
      required String originalSize,
      required String convertSize,
      required String type}) async {
    try {
      state = Status.Loading;
      print('Ini adalah state Loading Save Photo' + state.toString());
      var result = await SavePhotoService().savePhoto(
        nik: idNumber,
        photo: photo,
        originalSize: originalSize,
        convertSize: convertSize,
        type: type,
      );
      state = Status.Success;
      // CustomLoading().dismissLoading();
    } catch (err) {
      print("Error save Photo $err");
    }
  }

  addStringValuesSF(String errorCode) async {
    SharedPreferences prefs = Get.find<DataController>().prefs;
    prefs.setString('errorCode', errorCode);
  }

  Future<void> submit(SendOtpModel? sendOtpModel) async {
    if (currentText.length == 6) {
      CustomLoading().showLoading("Memuat Data");

      await createAccount(
          image: image,
          nik: idNumber,
          mobileNum: phoneNumber,
          otpSender: otpSender,
          biLocationCode: biLocationCode,
          accountType: accountType,
          email: email,
          motherMaidenName: motherMaidenName,
          name: name,
          pob: pob,
          subCat: subCat,
          othersOpenAccReason: othersOpenAccReason,
          othersSrcOfFund: othersSrcOfFund,
          taxId: taxId,
          customerAddress: customerAddress,
          rt: neighbourhood,
          rw: hamlet,
          kelurahan: urbanVillage,
          kecamatan: subDistrict,
          city: city,
          province: province,
          postalCode: postalCode,
          negara: country,
          alamatDomisili: alamatDomisili,
          job: job,
          yearlyIncome: yearlyIncome,
          dateOfBirth: dateOfBirth,
          alamatTempatKerja: jobAddress,
          branch: branch,
          detailPekerjaan: jobDetail,
          gender: gender,
          isMaried: status,
          kodePos: jobPostalCode,
          namaTempatKerja: jobPlace,
          patronCompanyAddress: patronCompanyAddress,
          patronMobileNum: patronMobileNum,
          patronRelationship: patronRelationship,
          publisherCity: cityPublisher,
          religion: religion,
          homePhone: landline,
          officePhone: officePhone,
          patronName: patronName,
          projDep: projDep,
          openAccReason: openAccReason,
          srcOfFund: srcOfFund,
          channelPromotionCode: channelPromotionCode,
          otp: currentText,
          otp_account: currentText,
          refnum: sendOtpModel!.refNum);

      await savePhoto(
          type: 'liveness',
          photo: image,
          originalSize: originalSelfiePhotoSize,
          convertSize: compressedSelfiePhotoSize);
      await savePhoto(
          type: 'selfie',
          photo: idSelfiePhoto,
          originalSize: originalIdSelfiePhotoSize,
          convertSize: compressedIdSelfiePhotoSize);
      await savePhoto(
          type: 'ktp',
          photo: idPhoto,
          originalSize: originalIdPhotoSize,
          convertSize: compressedIdPhotoSize);
      await savePhoto(
          type: 'ttd',
          photo: signaturePhoto,
          originalSize: originalSignaturePhotoSize,
          convertSize: compressedSignaturePhotoSize);

      CustomLoading().dismissLoading();

      CustomLoading().dismissLoading();

      if (state == Status.Success) {
        print('disini error code : ' + createAccountModel!.errorCode);
        if (createAccountModel!.errorCode == '') {
          Get.off(() => CreatePinScreen(), transition: Transition.rightToLeft);
        } else if (createAccountModel!.errorCode == '9015' ||
            createAccountModel!.errorCode == '9016' ||
            createAccountModel!.errorCode == '9017' ||
            createAccountModel!.errorCode == '9018' ||
            createAccountModel!.errorCode == '9019' ||
            createAccountModel!.errorCode == '9020' ||
            createAccountModel!.errorCode == '9021') {
          //Handle Error 9015 - 9021
          addStringValuesSF(createAccountModel!.errorCode);
          Get.offAll(() => DataDiri1(), transition: Transition.rightToLeft);
        } else {
          //Handle Error Lain
          addStringValuesSF(createAccountModel!.errorCode);
          Get.offAll(() => DataFileListPage(), transition: Transition.rightToLeft);
        }
      }
    } else {
      if (kDebugMode) {
        print('error');
      }
    }
  }

  createAccount(
      {required String refnum,
      required String otp,
      required String image,
      required String branch,
      required String accountType,
      required String subCat,
      required String othersOpenAccReason,
      required String othersSrcOfFund,
      required String nik,
      required String name,
      required String pob,
      required String dateOfBirth,
      required String motherMaidenName,
      required String email,
      required String homePhone,
      required String mobileNum,
      required String openAccReason,
      required String srcOfFund,
      required String projDep,
      required String taxId,
      required String customerAddress,
      required String rt,
      required String rw,
      required String kelurahan,
      required String kecamatan,
      required String city,
      required String province,
      required String postalCode,
      required String negara,
      required String alamatDomisili,
      required String job,
      required String yearlyIncome,
      required String officePhone,
      required String patronName,
      required String patronRelationship,
      required String patronCompanyAddress,
      required String patronMobileNum,
      required String channelPromotionCode,
      required String gender,
      required String religion,
      required String publisherCity,
      required String isMaried,
      required String detailPekerjaan,
      required String namaTempatKerja,
      required String alamatTempatKerja,
      required String kodePos,
      required String biLocationCode,
      required String otpSender,
      required String otp_account}) async {
    try {
      // emit(CreateaccountLoading());
      state = Status.Loading;
      print('Ini adalah state Loading Create Account' + state.toString());
      createAccountModel = await CreateAccountService().createAccount(
          image: image,
          nik: nik,
          mobileNum: phoneNumber,
          otpSender: otpSender,
          biLocationCode: biLocationCode,
          accountType: accountType,
          email: email,
          motherMaidenName: motherMaidenName,
          name: name,
          pob: pob,
          subCat: subCat,
          othersOpenAccReason: othersOpenAccReason,
          othersSrcOfFund: othersSrcOfFund,
          taxId: taxId,
          customerAddress: customerAddress,
          rt: rt,
          rw: rw,
          kelurahan: kelurahan,
          kecamatan: kecamatan,
          city: city,
          province: province,
          postalCode: postalCode,
          negara: negara,
          alamatDomisili: alamatDomisili,
          job: job,
          yearlyIncome: yearlyIncome,
          dateOfBirth: dateOfBirth,
          alamatTempatKerja: alamatTempatKerja,
          branch: branch,
          detailPekerjaan: detailPekerjaan,
          gender: gender,
          isMaried: isMaried,
          kodePos: kodePos,
          namaTempatKerja: namaTempatKerja,
          patronCompanyAddress: patronCompanyAddress,
          patronMobileNum: patronMobileNum,
          patronRelationship: patronRelationship,
          publisherCity: publisherCity,
          religion: religion,
          homePhone: homePhone,
          officePhone: officePhone,
          patronName: patronName,
          projDep: projDep,
          openAccReason: openAccReason,
          srcOfFund: srcOfFund,
          channelPromotionCode: channelPromotionCode,
          otp: otp,
          refnum: refnum);
      print('Ini Adalah Model Create Account : ' + createAccountModel.toString());
      print("Ini Adalah State :" + state.toString());
      print("Ini Adalah Error Code : " + createAccountModel!.errorCode);
      // emit(CreateaccountSuccess(createAccountModel));
      state = Status.Success;
    } catch (e) {
      // emit(CreateaccountLoading());
      state = Status.Loading;
      print('Ini adalah state Loading Create Account' + state.toString());
      createAccountModel = await CreateAccountService().createAccount(
          image: image,
          nik: nik,
          mobileNum: phoneNumber,
          otpSender: otpSender,
          biLocationCode: biLocationCode,
          accountType: accountType,
          email: email,
          motherMaidenName: motherMaidenName,
          name: name,
          pob: pob,
          subCat: subCat,
          othersOpenAccReason: othersOpenAccReason,
          othersSrcOfFund: othersSrcOfFund,
          taxId: taxId,
          customerAddress: customerAddress,
          rt: rt,
          rw: rw,
          kelurahan: kelurahan,
          kecamatan: kecamatan,
          city: city,
          province: province,
          postalCode: postalCode,
          negara: negara,
          alamatDomisili: alamatDomisili,
          job: job,
          yearlyIncome: yearlyIncome,
          dateOfBirth: dateOfBirth,
          alamatTempatKerja: alamatTempatKerja,
          branch: branch,
          detailPekerjaan: detailPekerjaan,
          gender: gender,
          isMaried: isMaried,
          kodePos: kodePos,
          namaTempatKerja: namaTempatKerja,
          patronCompanyAddress: patronCompanyAddress,
          patronMobileNum: patronMobileNum,
          patronRelationship: patronRelationship,
          publisherCity: publisherCity,
          religion: religion,
          homePhone: homePhone,
          officePhone: officePhone,
          patronName: patronName,
          projDep: projDep,
          openAccReason: openAccReason,
          srcOfFund: srcOfFund,
          channelPromotionCode: channelPromotionCode,
          otp: otp,
          // otp_account: otp_account,
          refnum: refnum);
      print('Ini Adalah Model Create Account : ' + createAccountModel.toString());
      print("Ini Adalah State :" + state.toString());
      print("Ini Adalah Error Code : " + createAccountModel!.errorCode);
      state = Status.Success;
      // emit(CreateaccountSuccess(createAccountModel));
    }
  }
}
