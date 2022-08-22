// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/models/create-account-model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateAccountService {
  Future<CreateAccountModel> createAccount({
    required String otp,
    required String refnum,
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
    required String image,
    // required String otp_account,
  }) async {
    var url = Uri.parse(urlSendOtpAndCreateAccount);
    // if (kDebugMode) {
    //   print(url.toString());
    // }
    var body = {
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
      "idNum": nik,
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
      "homePhone": homePhone,
      //nomor hp
      "mobileNum": mobileNum,
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
      "rt": rt,
      //rw
      "rw": rw,
      //kelurahan
      "kelurahan": kelurahan,
      //dropdown kecamatan
      "kecamatan": kecamatan,
      //dropdown city
      "city": city,
      //dropdown province
      "province": province,
      //dropdown postalCode
      "postalCode": postalCode,
      //dropdown (bisa kosong, default kosong)
      "negara": negara,
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
      "otp": otp,
      //ini refnum dapat dari response api send otp
      "refNum": refnum,
      //dari data diri2
      "gender": gender,
      //ga ada di field
      "tglLahirPemberiDana": "",
      //dari data diri2
      "religion": religion,
      //data diri2
      "publisherCity": publisherCity,
      //dari data diri2
      "isMaried": isMaried,
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
      "detailPekerjaan": detailPekerjaan,
      //Detail Pekerjaan
      "namaTempatKerja": namaTempatKerja,
      //ga ada di field
      "alamatTempatKerja2": "",
      //Detail Pekerjaan
      "alamatTempatKerja": alamatTempatKerja,
      //Detail Pekerjaan (diketik bukan dropdown)
      "kodePos": kodePos,
      //gabungan dari data cabang (kode outlet kantor cabang.json, di mapping dengan sandi bi dari bi.json)
      "biLocationCode": biLocationCode,
      //Method send otp
      "otpSender": "SMS",
    };
    var headers = Get.find<DataController>().headerJson(step: 'Api Create Account');

    log(body.toString());
    var response = await http.post(url, body: jsonEncode(body), headers: headers);
    print(response.statusCode);
    print(response.body);
    // log(body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['errorCode'] != '') {
        return CreateAccountModel.fromJson(data, 2);
      } else {
        return CreateAccountModel.fromJson(data, 1);
      }
    } else {
      var data = jsonDecode(response.body);
      throw ('gagal');
    }
  }
}
