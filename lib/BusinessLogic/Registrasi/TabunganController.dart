import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/preferences-tabungan.dart';
import '../../src/models/jenis-tabungan.dart';
import '../../src/views/register/register_card_type/card_type_prefs.dart';

class TabunganController extends GetxController {
  SharedPreferences? prefs;
  int activeTabIndex = 0;
  final preferencesTabungan = PreferencesTabungan();
  final cardPrefs = CardTypePrefs.instance;

  Future saveIndexTabungan() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt('indexTabungan', activeTabIndex);
  }

  void saveTabungan() {
    final Tabungan newTabungan;
    if (activeTabIndex == 0) {
      newTabungan = Tabungan('Taplus', '2000-0001', '', '', '');
      print(newTabungan.produk);
      preferencesTabungan.saveTabungan(newTabungan, prefs!);
    } else if (activeTabIndex == 1) {
      newTabungan = Tabungan(
          'Taplus Muda', '2003-1001', '13', '1', 'BNI Card Silver Virtual');
      preferencesTabungan.saveTabungan(newTabungan, prefs!);
      print(newTabungan.produk);
    } else if (activeTabIndex == 2) {
      newTabungan = Tabungan('Taplus Bisnis', '2300-0001', '19', '2',
          'BNI Card Gold Tabi Virtual');
      print(newTabungan.produk);
      preferencesTabungan.saveTabungan(newTabungan, prefs!);
    }
  }

  void saveTabunganDiaspora() {
    final Tabungan newTabungan;
    newTabungan = Tabungan('Taplus Diaspora', '2000-1101', '19', '2',
        'BNI Card Diaspora Gold Virtual');
    print(newTabungan);
    preferencesTabungan.saveTabungan(newTabungan, prefs!);
    // savingsController.preferencesTabungan
    //     .saveTabungan(newSavings, savingsController.prefs!);
  }
}
