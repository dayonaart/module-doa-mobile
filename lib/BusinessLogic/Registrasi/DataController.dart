import 'dart:convert';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:eform_modul/src/components/Global.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/cek-user.dart';
import '../../src/components/button.dart';
import '../../src/components/popup.dart';
import '../../src/components/theme_const.dart';
import '../../src/models/create-account-model.dart';
import '../../src/utility/Routes.dart';
import '../../src/views/home-page/home-screen.dart';
import 'package:crypto/crypto.dart';

class DataController extends GetxController {
  late SharedPreferences prefs;
  String nik = "",
      errorCode = "",
      tglLahir = "",
      kotaPenerbit = "",
      tempatLahir = "",
      jenisKel = "",
      agama = "",
      email = "",
      npwp = "",
      statusKawin = "",
      prefixnoTelpRumah = "",
      noTelpRumah = "",
      namaIbu = "",
      selfie = "",
      idPhoto = "",
      signaturePhoto = "",
      namaKtp = "",
      noHp = "",
      indexPosisi = "",
      sandiBI = "",
      kotaBI = "",
      namaOutlet = "",
      kodeOutlet = "",
      alamatOutlet = "",
      hubPemberiDana = "",
      namaPemilikDana = "",
      alamatPemilikDana = "",
      idSelfie = "",
      selectedPekerjaan = "",
      telpPemilikDana = "",
      alamatDomisili = "",
      negaraDomisili = "",
      alamat = "",
      rt = "",
      rw = "",
      provinsi = "",
      kota = "",
      kecamatan = "",
      desa = "",
      kodePos = "",
      detailPekerjaan = "",
      namaTempatKerja = "",
      noTelpKerja = "",
      alamatKerja = "",
      kodePosKerja = "",
      pekerjaan = "",
      penghasilan = "",
      sumberDana = "",
      sumberDanaLain = "",
      nilaiTransaksi = "",
      tujuanRekening = "",
      provinsiCabang = "",
      kotaCabang = "",
      kantorCabang = "",
      alamatCabang = "",
      tempNomorHp = "",
      perkiraanNilaiTransaksi = "",
      idSession = "",
      idUser = "";
  int indexTabungan = 0, indexCardType = 0;
  Global global = Global();
  Status state = Status.Initial;

  @override
  onInit() {
    initData();

    super.onInit();
  }

  String generateMd5(String input) {
    // print(utf8.encode(input));
    return md5.convert(utf8.encode(input)).toString();
  }

  Map<String, String> headerJson({required String step}) {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'PR9sMmhmGzWdEc4VPc9NAbMKhc889x4s',
      'sessionId': idSession,
      'id': idUser,
      'step': step,
      'location': (prefs.getString('indexPosisi') == '1') ? 'DN' : 'LN'
    };
    return header;
  }

  Map<String, String> headerSoap({required String step}) {
    var header = {
      'Content-Type': 'text/plain',
      'SOAPAction': 'add',
      'Authorization': 'PR9sMmhmGzWdEc4VPc9NAbMKhc889x4s',
      'sessionId': idSession,
      'id': idUser,
      'step': step,
      'location': ((prefs.getString('indexPosisi') == '1') ? 'DN' : 'LN')
    };
    return header;
  }

  Future<Map<String, dynamic>> jwtHeaderSoap({required String step}) async {
    var header = {
      'sessionId': prefs.getString("sessionId"),
      'id': idUser,
      'step': step,
      'location': ((prefs.getString('indexPosisi') == '1') ? 'DN' : 'LN'),
      'refNumber': prefs.getString('refNumber') ?? "",
      'timestamp': "${DateTime.now().millisecondsSinceEpoch}"
    };
    return header;
  }

  // Future<String?> deviceUnixId() async {
  //   try {
  //     final deviceInfoPlugin = DeviceInfoPlugin();
  //     final deviceInfo = await deviceInfoPlugin.iosInfo;
  //     return deviceInfo.identifierForVendor ?? "xxxx-xxxx-xxxx";
  //   } catch (e) {
  //     return "device unix not found";
  //   }
  // }

  CreateAccountModel createAccountModel = CreateAccountModel.fromJson({
    "refNum": "20220222135959023614",
    "channel": "EFORM",
    "cifNum": "9100781908",
    "accountNum": "",
    "customerName": "FULLAN BIN TESTING",
    "idNum": "3311037107960001",
    "idType": "2",
    "status": "",
    "errorCode": "00",
    "errorMessage": "12312",
    "newAccountNum": "1020139296",
    "cardNum": "5371763765007957"
  }, 123213);

  Future<void> initData() async {
    prefs = await SharedPreferences.getInstance();
    nik = prefs.getString("nik") ?? "";
    tglLahir = prefs.getString("tanggalLahir") ?? "";
    errorCode = prefs.getString("errorCode") ?? "";
    kotaPenerbit = prefs.getString("kotaPenerbitIdentitas") ?? "";
    tempatLahir = prefs.getString("tempatLahir") ?? "";
    jenisKel = prefs.getString("jenisKelamin") ?? "";
    agama = prefs.getString("agama") ?? "";
    email = prefs.getString("email") ?? "";
    npwp = prefs.getString("npwp") ?? "";
    statusKawin = prefs.getString("statusPerkawinan") ?? "";
    prefixnoTelpRumah = prefs.getString("prefixnoTelpRumah") ?? "000";
    noTelpRumah = prefs.getString("noTelpRumah") ?? "99999999";
    namaIbu = prefs.getString("namaIbuKandung") ?? "";
    selfie = prefs.getString("selfiePhoto") ?? "";
    idPhoto = prefs.getString("idPhoto") ?? "";
    signaturePhoto = prefs.getString("signaturePhoto") ?? "";
    namaKtp = prefs.getString("namaSesuaiKTP") ?? "";
    noHp = prefs.getString("nomorHandphone") ?? "";
    indexPosisi = prefs.getString("indexPosisi") ?? "1";
    sandiBI = prefs.getString("sandiBI") ?? "";
    kotaBI = prefs.getString("kotaBI") ?? "";
    namaOutlet = prefs.getString("namaOutlet") ?? "";
    kodeOutlet = prefs.getString("kodeOutlet") ?? "";
    alamatOutlet = prefs.getString("alamatOutlet") ?? "";
    hubPemberiDana = prefs.getString("hubunganPemberiDana") ?? "";
    namaPemilikDana = prefs.getString("namaPemilikDana") ?? "";
    alamatPemilikDana = prefs.getString("alamatPemilikDana") ?? "";
    idSelfie = prefs.getString("idSelfiePhoto") ?? "";
    selectedPekerjaan = prefs.getString("selectedPekerjaan") ?? "";
    telpPemilikDana = prefs.getString("telpPemilikDana") ?? "";
    alamatDomisili = prefs.getString('alamatDomisili') ?? "";
    negaraDomisili = prefs.getString('negaraDomisili') ?? "";
    alamat = prefs.getString('alamat') ?? "";
    rt = prefs.getString('rt') ?? "";
    rw = prefs.getString('rw') ?? "";
    provinsi = prefs.getString('provinsi') ?? "";
    kota = prefs.getString('kota') ?? "";
    kecamatan = prefs.getString('kecamatan') ?? "";
    desa = prefs.getString('desa') ?? "";
    kodePos = prefs.getString('kodePos') ?? "";
    detailPekerjaan = prefs.getString('detailPekerjaan') ?? "";
    namaTempatKerja = prefs.getString('namaTempatKerjaDetailPekerjaan') ?? "";
    noTelpKerja = prefs.getString('noTelpDetailPekerjaan') ?? "";
    alamatKerja = prefs.getString('alamatTempatKerjaDetailPekerjaan') ?? "";
    kodePosKerja = prefs.getString('kodePosDetailPekerjaan') ?? "";
    pekerjaan = prefs.getString("pekerjaan") ?? "";
    penghasilan = prefs.getString("penghasilanPerbulan") ?? "";
    sumberDana = prefs.getString("sumberDana") ?? "";
    sumberDanaLain = prefs.getString("sumberDanaLainnya") ?? "";
    perkiraanNilaiTransaksi = prefs.getString("perkiraanNilaiTransaksi") ?? "";
    tujuanRekening = prefs.getString("tujuanPembukaanRekening") ?? "";
    provinsiCabang = prefs.getString("provinsiCabang") ?? "";
    kotaCabang = prefs.getString("kotaCabang") ?? "";
    kantorCabang = prefs.getString("kantorCabang") ?? "";
    alamatCabang = prefs.getString("alamatCabang") ?? "";
    tempNomorHp = prefs.getString("tempNomorHandphone") ?? "";
    indexTabungan = prefs.getInt("indexTabungan") ?? 0;
    indexCardType = prefs.getInt("indexCardType") ?? 0;
    //tambahan dari fariz, pencegahan null
    prefs.setString("nik", "");
    prefs.setString("tanggalLahir", "");
    prefs.setString("errorCode", "");
    prefs.setString("kotaPenerbitIdentitas", "");
    prefs.setString("tempatLahir", "");
    prefs.setString("jenisKelamin", "");
    prefs.setString("agama", "");
    prefs.setString("email", "");
    prefs.setString("npwp", "");
    prefs.setString("statusPerkawinan", "");
    prefs.setString("prefixnoTelpRumah", "000");
    prefs.setString("noTelpRumah", "99999999");
    prefs.setString("namaIbuKandung", "");
    prefs.setString("selfiePhoto", "");
    prefs.setString("idPhoto", "");
    prefs.setString("signaturePhoto", "");
    prefs.setString("namaSesuaiKTP", "");
    prefs.setString("nomorHandphone", "");
    prefs.setString("indexPosisi", "");
    prefs.setString("sandiBI", "");
    prefs.setString("kotaBI", "");
    prefs.setString("namaOutlet", "");
    prefs.setString("kodeOutlet", "");
    prefs.setString("alamatOutlet", "");
    prefs.setString("hubunganPemberiDana", "");
    prefs.setString("namaPemilikDana", "");
    prefs.setString("alamatPemilikDana", "");
    prefs.setString("idSelfiePhoto", "");
    prefs.setString("selectedPekerjaan", "");
    prefs.setString("telpPemilikDana", "");
    prefs.setString("alamatDomisili", "");
    prefs.setString("negaraDomisili", "");
    prefs.setString("alamat", "");
    prefs.setString("rt", "");
    prefs.setString("rw", "");
    prefs.setString("provinsi", "");
    prefs.setString("kota", "");
    prefs.setString("kecamatan", "");
    prefs.setString("desa", "");
    prefs.setString("kodePos", "");
    prefs.setString("detailPekerjaan", "");
    prefs.setString("namaTempatKerjaDetailPekerjaan", "");
    prefs.setString("noTelpDetailPekerjaan", "");
    prefs.setString("alamatTempatKerjaDetailPekerjaan", "");
    prefs.setString("kodePosDetailPekerjaan", "");
    prefs.setString("pekerjaan", "");
    prefs.setString("penghasilanPerbulan", "");
    prefs.setString("sumberDana", "");
    prefs.setString("sumberDanaLainnya", "");
    prefs.setString("perkiraanNilaiTransaksi", "");
    prefs.setString("tujuanPembukaanRekening", "");
    prefs.setString("provinsiCabang", "");
    prefs.setString("kotaCabang", "");
    prefs.setString("kantorCabang", "");
    prefs.setString("alamatCabang", "");
    prefs.setString("tempNomorHandphone", "");
    prefs.setString("selectedCountryName", "Indonesia");
    prefs.setString('selectedFlagCountry', "assets/images/bendera/id.png");
    prefs.getInt("indexTabungan") ?? 0;
    prefs.getInt("indexCardType") ?? 0;
    idSession = await global.generateIDSession(prefs);
    idUser = global.generateIDUser(prefs);
    // print("Cek Shared Pref");
    // print('ini adalah session id : ${prefs.getString("sessionId")}');
  }

  String getIDSession() {
    return prefs.getString("sessionId") ?? "";
  }

  String getIDUser() {
    return prefs.getString("idUser") ?? "";
  }

  cekUser({required String nik, required String tanggal}) async {
    try {
      // emit(CekUserLoading());
      state = Status.Loading;
      print(state);
      bool status = await CekUser().cekUser(nik, tanggal);
      // emit(CekUserSuccess(status));
      // state = Status.Success;
      print(state);
      print(prefs.getString("indexPosisi"));
    } catch (e) {
      state = Status.Failed;
      // emit(CekUserFailed(e.toString()));
    }
  }

  checkTime(BuildContext context) {
    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
    TimeOfDay timeNow = TimeOfDay.now();
    double realTime = toDouble(timeNow);

    var endTimeNight = TimeOfDay(hour: 23, minute: 00);
    var endTimeMorning = TimeOfDay(hour: 01, minute: 00);
    double endTimeNight_c = toDouble(endTimeNight);
    double endTimeMorning_c = toDouble(endTimeMorning);
    if (realTime < endTimeNight_c || realTime > endTimeMorning_c) {
      // Get.back();
      Get.toNamed(Routes().syarat);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            print("time-now" + timeNow.toString());
            print(realTime.toString() + "<" + endTimeNight_c.toString());
            print(realTime.toString() + ">" + endTimeMorning_c.toString());

            return PopoutWrapContent(
                textTitle: '',
                button_radius: 4,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child:
                          SvgPicture.asset('assets/images/icons/time_icon.svg'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Mohon Maaf', style: PopUpTitle),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Fitur pembukaan rekening hanya tersedia pada pukul 01.00 - 23.00 WIB. Silakan mencoba kembali pada waktu yang sudah ditentukan.',
                      style: infoStyle,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                buttonText: 'Ok, saya Mengerti',
                ontap: () {
                  Get.back();
                  // Navigator.of(context).pop();
                });
          });
    }
  }

  checkProgress(BuildContext context) {
    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
    TimeOfDay timeNow = TimeOfDay.now();
    double realTime = toDouble(timeNow);

    var endTimeNight = TimeOfDay(hour: 23, minute: 00);
    var endTimeMorning = TimeOfDay(hour: 01, minute: 00);
    double endTimeNight_c = toDouble(endTimeNight);
    double endTimeMorning_c = toDouble(endTimeMorning);
    showDialog(
        context: context,
        builder: (context) {
          print("time-now" + timeNow.toString());
          print(realTime.toString() + "<" + endTimeNight_c.toString());
          print(realTime.toString() + ">" + endTimeMorning_c.toString());

          if (realTime < endTimeNight_c || realTime > endTimeMorning_c) {
            return PopUp(
                content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      'Pembukaan Tabungan Digital BNI Hanya Berlaku Untuk Nasabah Baru',
                      textAlign: TextAlign.center,
                      style: PopUpTitle),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Jika Anda sudah menjadi nasabah BNI, silakan lakukan Aktivasi BNI Mobile Banking (Android atau IOS) dan lakukan penambahan tabungan melalui menu Rekeningku atau kunjungi Kantor Cabang BNI terdekat.',
                    style: infoStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PopoutWrapContent(
                            textTitle: '',
                            button_radius: 4,
                            buttonText: 'Saya Mengerti',
                            ontap: () {
                              // Navigator.pop(context);
                              Get.back();
                              Get.toNamed(Routes().syarat);
                              // Navigator.of(
                              //         context)
                              //     .push(MaterialPageRoute(
                              //         builder:
                              //             (context) =>
                              //                 SyaratDanKetentuanPage()));
                            },
                            content: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                    'Untuk Kelancaran Pembukaan Tabungan, Siapkan Dahulu:',
                                    textAlign: TextAlign.center,
                                    style: PopUpTitle),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                child: Image.asset(
                                                    'assets/images/simpanan-info-icon-ktp.png'),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                child: Image.asset(
                                                    'assets/images/simpanan-info-icon-phone.png'),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                child: Image.asset(
                                                    'assets/images/simpanan-info-icon-ttd.png'),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.22,
                                            child: Text(
                                              'E-KTP (wajib) & NPWP (bila ada)',
                                              style: infoStyle,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.21,
                                              child: Text(
                                                'Pulsa/paket data untuk pengiriman OTP',
                                                style: infoStyle,
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.21,
                                              child: Text(
                                                'Kertas & Alat Tulis',
                                                style: infoStyle,
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.022,
                                ),
                                ButtonCostum(
                                  // margin: EdgeInsets.symmetric(horizontal: 15,),
                                  text: 'Saya Mengerti',
                                  ontap: () {
                                    // Navigator.pop(context);
                                    Get.back();
                                    Get.toNamed(Routes().syarat);
                                    // Navigator.of(
                                    //         context)
                                    //     .push(MaterialPageRoute(
                                    //         builder:
                                    //             (context) =>
                                    //                 SyaratDanKetentuanPage()));
                                  },
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text('Lanjutkan Proses Pembukaan Rekening',
                          style: buttonStyle),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: CustomThemeWidget.orangeButton),
                        color: CustomThemeWidget.orangeButton,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ],
            ));
          } else {
            //dialog_daftar(context)
            return const TimeOut();
          }
        });
  }
}
