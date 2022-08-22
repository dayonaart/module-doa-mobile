// import 'package:bloc/bloc.dart';
// import 'package:eform_modul/service/checkCIF-service.dart';
// import 'package:equatable/equatable.dart';
//
// part 'cekmif_state.dart';
//
// class CekmifCubit extends Cubit<CekmifState> {
//   CekmifCubit() : super(CekmifInitial());
//
//   void cekMif(
//       {required String cifnum,
//       required String email,
//       required String phone}) async {
//     try {
//       emit(CekmifLoading());
//       print(state);
//       String errorCode = await CheckMIFService()
//           .cekCIF(cifNum: cifnum, email: email, phone: phone);
//       emit(CekmifSuccess(errorCode));
//     } catch (e) {
//       emit(CekmifFailed());
//     }
//   }
// }
