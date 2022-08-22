// import 'package:bloc/bloc.dart';
// import 'package:eform_modul/service/send-otp.dart';
// import 'package:eform_modul/src/models/send-otp-model.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
//
// part 'sendotp_state.dart';
//
// class SendotpCubit extends Cubit<SendotpState> {
//   SendotpCubit() : super(SendotpInitial());
//
//   void sendOtp({
//     required String branch,
//     required String accountType,
//     required String subCat,
//     String srcOfFund = '',
//     String openAccReason = '',
//     String othersOpenAccReason = '',
//     String othersSrcOfFund = '',
//     required String nik,
//     required String name,
//     required String pob,
//     required String dateOfBirth,
//     required String motherMaidenName,
//     required String email,
//     String homePhone = '',
//     required String noHP,
//     //   String openAccReason = '',
//     //   String srcOfFund = '',
//     String projDep = '',
//     String taxId = '',
//     required String customerAddress,
//     required String rt,
//     required String rw,
//     required String kelurahan,
//     required String kecamatan,
//     required String city,
//     required String province,
//     required String postalCode,
//     String negara = '',
//     String alamatDomisili = '',
//     required String job,
//     required String yearlyIncome,
//     String officePhone = '',
//     String patronName = '',
//     required String patronRelationship,
//     required String patronCompanyAddress,
//     required String patronMobileNum,
//     //   required String channelPromotionCode,
//     required String gender,
//     required String religion,
//     required String publisherCity,
//     required String isMaried,
//     required String detailPekerjaan,
//     required String namaTempatKerja,
//     required String alamatTempatKerja,
//     required String kodePos,
//     required String biLocationCode,
//     required String otpSender,
//     required String channelPromotionCode,
//   }) async {
//     try {
//       emit(SendotpLoading());
//       print(state);
//       SendOtpModel sendOtpModel = await SendOtpService().sendOtp(
//           nik: nik,
//           mobileNum: noHP,
//           otpSender: otpSender,
//           biLocationCode: biLocationCode,
//           accountType: accountType,
//           email: email,
//           motherMaidenName: motherMaidenName,
//           name: name,
//           pob: pob,
//           subCat: subCat,
//           othersOpenAccReason: othersOpenAccReason,
//           othersSrcOfFund: othersSrcOfFund,
//           taxId: taxId,
//           customerAddress: customerAddress,
//           rt: rt,
//           rw: rw,
//           kelurahan: kelurahan,
//           kecamatan: kecamatan,
//           city: city,
//           province: province,
//           postalCode: postalCode,
//           negara: negara,
//           alamatDomisili: alamatDomisili,
//           job: job,
//           yearlyIncome: yearlyIncome,
//           dateOfBirth: dateOfBirth,
//           alamatTempatKerja: alamatTempatKerja,
//           branch: branch,
//           detailPekerjaan: detailPekerjaan,
//           gender: gender,
//           isMaried: isMaried,
//           kodePos: kodePos,
//           namaTempatKerja: namaTempatKerja,
//           patronCompanyAddress: patronCompanyAddress,
//           patronMobileNum: patronMobileNum,
//           patronRelationship: patronRelationship,
//           publisherCity: publisherCity,
//           religion: religion,
//           homePhone: homePhone,
//           officePhone: officePhone,
//           patronName: patronName,
//           projDep: projDep,
//           openAccReason: openAccReason,
//           srcOfFund: srcOfFund,
//           channelPromotionCode: channelPromotionCode);
//       print(state);
//       emit(SendotpSuccess(sendOtpModel));
//     } catch (e) {
//       emit(SendotpFailed(e.toString()));
//       if (kDebugMode) {
//         print(state);
//       }
//     }
//   }
// }
