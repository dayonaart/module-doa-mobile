// import 'package:bloc/bloc.dart';
// import 'package:eform_modul/service/checkMbank-service.dart';
// import 'package:eform_modul/service/createMbank-service.dart';
// import 'package:equatable/equatable.dart';
//
// part 'cekmbank_state.dart';
//
// class CekmbankCubit extends Cubit<CekmbankState> {
//   CekmbankCubit() : super(CekmbankInitial());
//
//   void cekMbank(
//       {required String username,
//       required String email,
//       required String cifnum,
//       required String phonenum,
//       required String name}) async {
//     try {
//       emit(CekmbankLoading());
//
//       var errorCode = await cekMbankService()
//           .cekMbank(username: username, email: email, phone: phonenum);
//       emit(CekmbankSuccess(errorCode));
//       if (errorCode == '9001') {
//         emit(CekmbankLoading());
//         var erroCodeCreateMbank = await createMbankService().createMbank(
//             username: username,
//             name: name,
//             cifnum: cifnum,
//             phonenum: phonenum,
//             email: email);
//         if (errorCode == '9001') {
//           emit(CreatembankSuccess(erroCodeCreateMbank));
//         } else {
//           emit(CekmbankFailed());
//         }
//       } else {
//         emit(CekmbankFailed());
//       }
//       // var errorCode = await createMbankService().createMbank(
//       //     username: username,
//       //     email: email,
//       //     cifnum: cifnum,
//       //     phonenum: phonenum,
//       //     name: name);
//
//       // if (errorCode == '9001') {
//       //   // var errorCodeCreate = await createMbankService().createMbank();
//       //   // print('Ini ErrorCode Cubit ' + errorCodeCreate.toString());
//       //   // if (errorCodeCreate == '9001') {
//       //   //   emit(CekmbankSuccess(errorCode));
//       //   // } else {
//       //   //   emit(CekmbankFailed());
//       //   // }
//       // } else {
//       //   emit(CekmbankFailed());
//       // }
//
//     } catch (e) {
//       emit(CekmbankFailed());
//     }
//   }
// }
