// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/services.dart';
//
// part 'kantorcabang_state.dart';
//
// class KantorcabangCubit extends Cubit<KantorcabangState> {
//   KantorcabangCubit() : super(KantorcabangInitial());
//
//   // void getKantorCabang() async {
//   //   try {
//   //     emit(KantorcabangLoading());
//   //     print(state);
//   //
//   //     List kota = await readJsonKota();
//   //     // print(kota.toString());
//   //     List provinsi = await readJsonProvinsi();
//   //     // print(provinsi.toString());
//   //     List kantor = await readJsonKantor();
//   //     print("ini kantor ");
//   //     log(kantor.toString());
//   //     List kodeBi = await readJsonBi();
//   //     // print(kodeBi.toString());
//   //
//   //     emit(KantorcabangSucess(kota, provinsi, kantor, kodeBi));
//   //   } catch (e) {
//   //     emit(KantorcabangFailed(e.toString()));
//   //   }
//   // }
//
//   Future<List> readJsonProvinsi() async {
//     final String response =
//         await rootBundle.loadString('assets/jsonfiles/provinsi_cabang.json');
//     final data = await json.decode(response);
//
//     return data["regions"];
//
//     // print("inisiasi:" + _listProvinsi.toString() + "\n");
//   }
//
//   // Fetch json kota from the json file
//   Future<List> readJsonKota() async {
//     final String response =
//         await rootBundle.loadString('assets/jsonfiles/kota_cabang.json');
//     final data = await json.decode(response);
//
//     return data["regions"];
//
//     // print("inisiasi:" + _listKota.toString() + "\n");
//   }
//
//   // Fetch json kota from the json file
//   Future<List> readJsonKantor() async {
//     final String response =
//         await rootBundle.loadString('assets/jsonfiles/kantor_cabang.json');
//
//     final data = await jsonDecode(response);
//
//     return data["regions"];
//
//     // print("inisiasi:" + _listkantor.toString() + "\n");
//   }
//
//   Future<List> readJsonBi() async {
//     final String response =
//         await rootBundle.loadString('assets/jsonfiles/bi.json');
//     final data = await json.decode(response);
//
//     return data["bi"];
//
//     // print("inisiasi:" + _listkodebi.toString() + "\n");
//   }
// }
