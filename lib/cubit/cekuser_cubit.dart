// import 'package:bloc/bloc.dart';
// import 'package:eform_modul/service/cek-user.dart';
// import 'package:equatable/equatable.dart';
//
// part 'cekuser_state.dart';
//
// class CekuserCubit extends Cubit<CekuserState> {
//   CekuserCubit() : super(CekuserInitial());
//
//   void cekUser({required String nik, required String tanggal}) async {
//     try {
//       emit(CekUserLoading());
//       print(state);
//       bool status = await CekUser().cekUser(nik, tanggal);
//       emit(CekUserSuccess(status));
//       print(state);
//     } catch (e) {
//       emit(CekUserFailed(e.toString()));
//     }
//   }
//
//   void ubahState() {
//     emit(CekuserInitial());
//     print(state);
//   }
// }
