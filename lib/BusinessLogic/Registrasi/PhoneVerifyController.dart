import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:eform_modul/src/views/data-file/data-file-list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/components/list-error.dart';
import '../../src/views/otp-page/otp-screen.dart';

class PhoneVerifyController extends GetxController {
  String idNumber = '';
  //dummy phoneNumber

  String numberPhone = "";
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
  String homeAddress = '';
  String job = '';
  String yearlyIncome = '';
  String dateOfBirth = '';

  String officeAddress = '';
  String branch = '';
  String jobDetail = '';
  String gender = '';
  String status = '';
  String jobPostalCode = '';
  String jobPlace = '';
  String patronCompanyAddress = '';
  String patronMobileNum = '';
  String patronRelationship = '';
  String publisherCity = '';
  String religion = '';
  String landline = '';
  String officePhone = '';
  String patronName = '';
  String projDep = '';
  String channelPromotionCode = '';
  SharedPreferences? prefs;

  addStringValuesSF(String value) async {
    // final prefs = prefs!;
    prefs!.setString('otpSender', value);
  }

  getData() async {
    if (prefs == null) prefs = Get.find<DataController>().prefs;

    // prefs = await SharedPreferences.getInstance();
    idNumber = prefs!.getString('nik') ?? '';
    // print('ini nik user : ' + idNumber);
    //prefs.setString('nomorHandphone', '81360426152');
    //prefs.reload();
    numberPhone = '+' + prefs!.getString('dialCodeNegara')!;
    for (var i = 0; i < prefs!.getString('nomorHandphone')!.length - 4; i++) {
      numberPhone += '*';
    }

    numberPhone += prefs!
        .getString('nomorHandphone')!
        .substring(prefs!.getString('nomorHandphone')!.length - 4);
    //prefs.setString("email", "value@value.value");
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
    homeAddress = prefs!.getString('alamatDomisili') ?? '';
    job = prefs!.getString('pekerjaan') ?? '';
    yearlyIncome = prefs!.getString('penghasilanPerbulan') ?? '';
    dateOfBirth = prefs!.getString('tanggalLahir') ?? '';

    srcOfFund = prefs!.getString('sumberDana') ?? '';
    openAccReason = prefs!.getString('tujuanPembukaanRekening') ?? '';
    officeAddress = prefs!.getString('alamatTempatKerjaDetailPekerjaan') ?? '';
    branch = prefs!.getString('kodeOutlet') ?? ''; //belum
    jobDetail = prefs!.getString('detailPekerjaan') ?? '';
    gender = prefs!.getString('jenisKelamin') ?? '';
    status = prefs!.getString('statusPerkawinan') ?? '';
    jobPostalCode = prefs!.getString('kodePosDetailPekerjaan') ?? '';
    jobPlace = prefs!.getString('namaTempatKerjaDetailPekerjaan') ?? '';
    patronCompanyAddress = prefs!.getString('alamatPemilikDana') ?? '';
    patronMobileNum = prefs!.getString('telpPemilikDana') ?? '';
    patronRelationship = prefs!.getString('hubunganPemberiDana') ?? '';
    publisherCity = prefs!.getString('kotaPenerbitIdentitas') ?? '';
    religion = prefs!.getString('agama') ?? '';
    landline = prefs!.getString('noTelpRumah') ?? '';
    officePhone = prefs!.getString('noTelpDetailPekerjaan') ?? '';
    patronName = prefs!.getString('namaPemilikDana') ?? '';
    projDep = prefs!.getString('perkiraanNilaiTransaksi') ?? '';

    channelPromotionCode = prefs!.getString('kode_referal') ?? '';
  } //data

  checkProses(BuildContext context) {
    if (Get.find<OtpController>().state == Status.Success) {
      if (Get.find<OtpController>().sendOtpModel!.errorCode == "") {
        CustomLoading().dismissLoading();
        Get.off(() => OTPScreen(sendOtpModel: Get.find<OtpController>().sendOtpModel),
            transition: Transition.rightToLeft);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           OTPScreen(sendOtpModel: state.sendOtpModel)),
        //       (route) => false,
        // );
      } else {
        Get.offAll(() => DataFileListPage(), transition: Transition.rightToLeft);
      }
    }
  }
}
