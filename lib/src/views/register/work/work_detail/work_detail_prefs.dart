// import 'package:shared_preferences/shared_preferences.dart';

// class WorkDetailController {
//   WorkDetailController._();
//   static WorkDetailController instance = WorkDetailController._();
//   static String getDetailPekerjaan = "",
//       getNamaTempatKerja = "",
//       getNoTelp = "",
//       getAlamatTempatKerja = "",
//       getKodePos = "";

//   Future setSharedPrefWorkDetail(
//       String detailPekerjaan, namaTempat, noTelp, alamatTempat, kodePos) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('detailPekerjaan', detailPekerjaan);
//     prefs.setString('namaTempatKerjaDetailPekerjaan', namaTempat);
//     prefs.setString('noTelpDetailPekerjaan', noTelp);
//     prefs.setString('alamatTempatKerjaDetailPekerjaan', alamatTempat);
//     prefs.setString('kodePosDetailPekerjaan', kodePos);
//     // prefs.reload();
//   }

//   Future getSharedPrefWorkDetail() async {
//     final prefs = await SharedPreferences.getInstance();
//     getDetailPekerjaan = prefs.getString("detailPekerjaan")!;
//     getNamaTempatKerja = prefs.getString("namaTempatKerjaDetailPekerjaan")!;
//     getNoTelp = prefs.getString("noTelpDetailPekerjaan")!;
//     getAlamatTempatKerja = prefs.getString("alamatTempatKerjaDetailPekerjaan")!;
//     getKodePos = prefs.getString("kodePosDetailPekerjaan")!;
//     print("$getDetailPekerjaan $getAlamatTempatKerja $getNamaTempatKerja");
//   }

//   Future defaultSharedPrefWorkDetail() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('detailPekerjaan', "");
//     prefs.setString('namaTempatKerjaDetailPekerjaan', "");
//     prefs.setString('noTelpDetailPekerjaan', "");
//     prefs.setString('alamatTempatKerjaDetailPekerjaan', "");
//     prefs.setString('kodePosDetailPekerjaan', "");
//   }
// }
