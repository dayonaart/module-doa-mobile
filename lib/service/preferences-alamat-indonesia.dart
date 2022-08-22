import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/models/alamat-indonesia.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesAlamatIndonesia {
  Future saveAlamatIndonesia(AlamatIndonesiaModel alamatIndonesia) async {
    final preferences = Get.find<DataController>().prefs;

    preferences.setString('alamat', alamatIndonesia.alamat);
    preferences.setString('rt', alamatIndonesia.rt);
    preferences.setString('rw', alamatIndonesia.rw);
    preferences.setString('provinsi', alamatIndonesia.provinsi);
    preferences.setString('kota', alamatIndonesia.kota);
    preferences.setString('kecamatan', alamatIndonesia.kecamatan);
    preferences.setString('desa', alamatIndonesia.desa);
    preferences.setString('kodePos', alamatIndonesia.kodePos);
    print('Saved Alamat Indonesia');
  }

  Future<AlamatIndonesiaModel> getAlamatIndonesia() async {
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

      return AlamatIndonesiaModel(alamat!, rt!, rw!, provinsi!, kota!, kecamatan!, desa!, kodePos!);
    } else {
      return AlamatIndonesiaModel('', '', '', '', '', '', '', '');
    }
  }
}
