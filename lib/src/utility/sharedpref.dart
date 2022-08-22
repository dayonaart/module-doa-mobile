import 'package:shared_preferences/shared_preferences.dart';

addStringToSF(String namaValue, String isiValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(namaValue, isiValue);
}

getStringValuesSF(String namaValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString(namaValue);
  return stringValue;
}
