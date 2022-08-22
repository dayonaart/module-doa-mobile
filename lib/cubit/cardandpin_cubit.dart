// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:eform_modul/service/activate-card.dart';
// import 'package:eform_modul/service/get-card.dart';
// import 'package:eform_modul/service/getReceiptEmail-service.dart';
// import 'package:eform_modul/service/sendEmail-service.dart';
// import 'package:eform_modul/src/models/card-and-pin-model.dart';
// import 'package:eform_modul/src/models/receiptEmail-model.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:developer' as devmode;
// import '../service/create-pin.dart';
// import '../service/update-card.dart';
//
// part 'cardandpin_state.dart';
//
// class CardandpinCubit extends Cubit<CardandpinState> {
//   CardandpinCubit() : super(CardandpinInitial());
//
//   Future<void> cardAndPin({
//     required String refnum,
//     required String accountNum,
//     required String cifNum,
//     required String bin,
//     required String cardType,
//     required String pin,
//     required SharedPreferences prefs,
//   }) async {
//     emit(StateLoading());
//     // print(state);
//     CardandPinModel cardandPinModel = await GetcardService().getCard(
//         accountNum: accountNum, cifNum: cifNum, bin: bin, cardType: cardType);
//
//     prefs.setString("cardNumber", cardandPinModel.cardNum);
//
//     emit(GetCardStateSuccess(cardandPinModel));
//     if (cardandPinModel.errorCode == "") {
//       // print(state);
//
//       CardandPinModel cardandPinModelActivate = await ActivateCardService()
//           .activateCard(
//               accountNum: cardandPinModel.accountNum,
//               cardNum: cardandPinModel.cardNum,
//               cifNumm: cardandPinModel.cifNum,
//               bin: bin,
//               card_type: cardType);
//       emit(ActivateCardStateSuccess(cardandPinModelActivate));
//       if (cardandPinModelActivate.errorCode == "") {
//         // print(state);
//         CardandPinModel cardandPinModelUpdate = await UpdateCardService()
//             .updateCard(
//                 accountNum: cardandPinModelActivate.accountNum,
//                 bin: bin,
//                 cardNum: cardandPinModel.cardNum,
//                 cardType: cardType,
//                 cifNum: cardandPinModel.cifNum);
//         emit(UpdateCardStateSuccess(cardandPinModelUpdate));
//         print(state);
//         if (cardandPinModelUpdate.errorCode == '') {
//           print(state);
//           String errorCode = await CreatePinService().createPin(
//               refnum: refnum,
//               cardnum: cardandPinModel.cardNum,
//               accountnum: cardandPinModel.accountNum,
//               pin: pin);
//           print("ini Error Code : " + errorCode);
//           Future.delayed(Duration(seconds: 3), () {
//             if (errorCode != '00') {
//               String errorCode = '3';
//               print("ini error code " + errorCode);
//               emit(CardandPinErrorCode(errorCode, cardandPinModelUpdate));
//             } else {
//               emit(GetCreatePin('00', cardandPinModelUpdate));
//               print("ini error code " + errorCode);
//             }
//           });
//         }
//       } else {
//         String errorCode = '2';
//         emit(CardandPinErrorCode(errorCode, cardandPinModelActivate));
//       }
//     } else {
//       String errorCode = '1';
//       emit(CardandPinErrorCode(errorCode, cardandPinModel));
//     }
//   }
//
//   Future<void> getReceiptEmail(
//       {required String custName,
//       required String refNum,
//       required String registerDate,
//       required String registerTime,
//       required String newAccountNum,
//       required String accountType,
//       //required String cardNum,
//       required String accountBranch,
//       required String branchName,
//       required String accStatus,
//       required String cardType,
//       required String initialDeposit,
//       required String lastDepositDate,
//       required SharedPreferences prefs}) async {
//     print("Getting Email Receipt: " + state.toString());
//     String? _cardnum = prefs.getString("cardNumber").toString();
//     devmode.log("ISIANNNNNNNNNN\n"
//         "custName : $custName,\n refNum: $refNum,\n registerDate: $registerDate,\n registerTime: $registerTime,\n newAccountNum: $newAccountNum,\n accountType: $accountType,\n cardNum: $_cardnum,\n accountBranch: $accountBranch,\n branchName: $branchName,\n accStatus: Terbuka (Open),\n cardType: $cardType,\n initialDeposit: $initialDeposit,\n lastDepositDate: $lastDepositDate");
//
//     ReceiptEmailModel receiptEmailModel = await GetReceiptEmailService()
//         .getReceiptEmail(
//             custName: custName,
//             refNum: refNum,
//             registerDate: registerDate,
//             registerTime: registerTime,
//             newAccountNum: newAccountNum,
//             accountType: accountType,
//             cardNum: _cardnum,
//             accountBranch: accountBranch,
//             branchName: branchName,
//             accStatus: accStatus,
//             cardType: cardType,
//             initialDeposit: initialDeposit,
//             lastDepositDate: lastDepositDate);
//     emit(GetReceiptEmailStateSuccess(receiptEmailModel));
//     if (receiptEmailModel.responseCode == "200") {
//       print("berhasil receipt email");
//     } else {
//       print("gagal receipt email");
//     }
//   }
//
//   Future<void> sendEmail(
//       {required String custName,
//       required String refNum,
//       required String registerDate,
//       required String registerTime,
//       required String newAccountNum,
//       required String jenisRekening,
//       required String cardNum,
//       required String accountBranch,
//       required String branchName,
//       required String accStatus,
//       required String cardType,
//       required String initialDeposit,
//       required String lastDepositDate,
//       required String email}) async {
//     print("Sending Email: " + state.toString());
//
//     ReceiptEmailModel receiptEmailModel = await sendEmailService().sendEmail(
//         custName: custName,
//         refNum: refNum,
//         registerDate: registerDate,
//         registerTime: registerTime,
//         newAccountNum: newAccountNum,
//         jenisRekening: jenisRekening,
//         cardNum: cardNum,
//         accountBranch: accountBranch,
//         branchName: branchName,
//         accStatus: accStatus,
//         cardType: cardType,
//         initialDeposit: initialDeposit,
//         lastDepositDate: lastDepositDate,
//         email: email);
//     emit(SendEmailStateSuccess(receiptEmailModel));
//     if (receiptEmailModel.responseCode == "200") {
//       print("berhasil send email");
//     } else {
//       print("gagal send email");
//     }
//   }
// }
