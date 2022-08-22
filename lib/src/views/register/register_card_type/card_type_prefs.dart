import 'package:shared_preferences/shared_preferences.dart';

class CardTypePrefs {
  CardTypePrefs._();
  static CardTypePrefs instance = CardTypePrefs._();
  static String? binValue, cardTypeValue, namaKartuValue, indexValue;

  setCardTypePrefs(String bin, String cardType, String namaKartu,
      SharedPreferences prefs, String index) {
    prefs.setString('bin', bin);
    prefs.setString("cardType", cardType);
    prefs.setString("namaKartu", namaKartu);
    prefs.setString("curIndType", index);
    // await prefs.reload();
  }

  setDefaultCardTypePrefs(SharedPreferences prefs) {
    if (prefs.getString("bin") == null ||
        prefs.getString("bin") == "" && prefs.getString("cardType") == null ||
        prefs.getString("cardType") == "" &&
            prefs.getString("namaKartu") == null ||
        prefs.getString("namaKartu") == "") {
      prefs.setString('bin', "13");
      prefs.setString("cardType", "1");
      prefs.setString("namaKartu", "BNI Card Silver Virtual");
    }
  }

  getCardTypePrefs(SharedPreferences prefs) {
    binValue = prefs.getString("bin");
    cardTypeValue = prefs.getString("cardType");
    namaKartuValue = prefs.getString("namaKartu");
    indexValue = prefs.getString("curIndType");

    print("bin $binValue, cardtype $cardTypeValue, namaKartu $namaKartuValue");
  }

  // jangan di pakai, buat debugging
}
