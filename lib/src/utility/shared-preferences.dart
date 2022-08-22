import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static var _instance;
  static var _sharedPreferences;

  static const String kKtpDanNpwp = "ktp_dan_npwp";

  static Future<SharedPreferencesHelper> getInstance() async {
    _instance ??= SharedPreferencesHelper();
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  /// -----------------------------------------------------------
  /// Method that returns the device id, 'null' if not set
  /// -----------------------------------------------------------
  static Future<String?> getKtpDanNpwp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kKtpDanNpwp);
  }

  /// -----------------------------------------------------------
  /// Method that saves the device id
  /// -----------------------------------------------------------
  static Future<bool> setKtpDanNpwp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kKtpDanNpwp, value);
  }
}
