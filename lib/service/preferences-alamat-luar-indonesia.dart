import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/models/alamat-luar-indonesia.dart';

class PreferencesAlamatLuarIndonesia {
  Future saveAlamatLuarIndonesia(AlamatLuarIndonesiaModel alamatluarIndonesia) async {
    final preferences = Get.find<DataController>().prefs;

    preferences.setString('alamat', alamatluarIndonesia.alamat);
    preferences.setString('rt', alamatluarIndonesia.rt);
    preferences.setString('rw', alamatluarIndonesia.rw);
    preferences.setString('provinsi', alamatluarIndonesia.provinsi);
    preferences.setString('kota', alamatluarIndonesia.kota);
    preferences.setString('kecamatan', alamatluarIndonesia.kecamatan);
    preferences.setString('desa', alamatluarIndonesia.desa);
    preferences.setString('kodePos', alamatluarIndonesia.kodePos);
    preferences.setString('alamatDomisili', alamatluarIndonesia.alamatDomisili);
    preferences.setString('negaraDomisili', alamatluarIndonesia.negaraDomisili);
    //await preferences.clear();
    print('Saved Alamat Luar Indonesia');
  }

  Future<AlamatLuarIndonesiaModel> getAlamatLuarIndonesia() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.getString('alamat') != null) {
      final alamat = preferences.getString('alamat');
      final rt = preferences.getString('rt');
      final rw = preferences.getString('rw');
      final provinsi = preferences.getString('provinsi');
      final kota = preferences.getString('kota');
      final kecamatan = preferences.getString('kecamatan');
      final desa = preferences.getString('desa');
      final kodePos = preferences.getString('kodePos');
      final alamatDomisili = preferences.getString('alamatDomisili');
      final negaraDomisili = preferences.getString('negaraDomisili');

      return AlamatLuarIndonesiaModel(alamat!, rt!, rw!, provinsi!, kota!, kecamatan!, desa!,
          kodePos!, alamatDomisili!, negaraDomisili!);
    } else {
      return AlamatLuarIndonesiaModel('', '', '', '', '', '', '', '', '', '');
    }
  }
}
