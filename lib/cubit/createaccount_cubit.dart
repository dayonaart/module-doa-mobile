// import 'package:bloc/bloc.dart';
// import 'package:eform_modul/service/create-account.dart';
// import 'package:eform_modul/src/models/create-account-model.dart';
// import 'package:equatable/equatable.dart';
//
// part 'createaccount_state.dart';
//
// class CreateaccountCubit extends Cubit<CreateaccountState> {
//   CreateaccountCubit() : super(CreateaccountInitial());
//
//   void createAccountt(
//       {required String image,
//       required String otp,
//       required String refnum,
//       required String branch,
//       required String accountType,
//       required String subCat,
//       required String othersOpenAccReason,
//       required String othersSrcOfFund,
//       required String nik,
//       required String name,
//       required String pob,
//       required String dateOfBirth,
//       required String motherMaidenName,
//       required String email,
//       required String homePhone,
//       required String mobileNum,
//       required String openAccReason,
//       required String srcOfFund,
//       required String projDep,
//       required String taxId,
//       required String customerAddress,
//       required String rt,
//       required String rw,
//       required String kelurahan,
//       required String kecamatan,
//       required String city,
//       required String province,
//       required String postalCode,
//       required String negara,
//       required String alamatDomisili,
//       required String job,
//       required String yearlyIncome,
//       required String officePhone,
//       required String patronName,
//       required String patronRelationship,
//       required String patronCompanyAddress,
//       required String patronMobileNum,
//       required String channelPromotionCode,
//       required String gender,
//       required String religion,
//       required String publisherCity,
//       required String isMaried,
//       required String detailPekerjaan,
//       required String namaTempatKerja,
//       required String alamatTempatKerja,
//       required String kodePos,
//       required String biLocationCode,
//       required String otpSender,
//       required String otp_account}) async {
//     try {
//       emit(CreateaccountLoading());
//       print('Ini adalah state Loading Create Account' + state.toString());
//       CreateAccountModel createAccountModel =
//           await CreateAccountService().createAccount(
//               image: image,
//               nik: nik,
//               mobileNum: mobileNum,
//               otpSender: otpSender,
//               biLocationCode: biLocationCode,
//               accountType: accountType,
//               email: email,
//               motherMaidenName: motherMaidenName,
//               name: name,
//               pob: pob,
//               subCat: subCat,
//               othersOpenAccReason: othersOpenAccReason,
//               othersSrcOfFund: othersSrcOfFund,
//               taxId: taxId,
//               customerAddress: customerAddress,
//               rt: rt,
//               rw: rw,
//               kelurahan: kelurahan,
//               kecamatan: kecamatan,
//               city: city,
//               province: province,
//               postalCode: postalCode,
//               negara: negara,
//               alamatDomisili: alamatDomisili,
//               job: job,
//               yearlyIncome: yearlyIncome,
//               dateOfBirth: dateOfBirth,
//               alamatTempatKerja: alamatTempatKerja,
//               branch: branch,
//               detailPekerjaan: detailPekerjaan,
//               gender: gender,
//               isMaried: isMaried,
//               kodePos: kodePos,
//               namaTempatKerja: namaTempatKerja,
//               patronCompanyAddress: patronCompanyAddress,
//               patronMobileNum: patronMobileNum,
//               patronRelationship: patronRelationship,
//               publisherCity: publisherCity,
//               religion: religion,
//               homePhone: homePhone,
//               officePhone: officePhone,
//               patronName: patronName,
//               projDep: projDep,
//               openAccReason: openAccReason,
//               srcOfFund: srcOfFund,
//               channelPromotionCode: channelPromotionCode,
//               otp: otp,
//               // otp_account: otp_account,
//               refnum: refnum);
//       // print(
//       //     'Ini Adalah Model Create Account : ' + createAccountModel.toString());
//       // print("Ini Adalah State :" + state.toString());
//       // print("Ini Adalah Error Code : " + createAccountModel.errorCode);
//       emit(CreateaccountSuccess(createAccountModel));
//     } catch (e) {
//       emit(CreateaccountLoading());
//       print('Ini adalah state Loading Create Account' + state.toString());
//       CreateAccountModel createAccountModel =
//           await CreateAccountService().createAccount(
//               image: image,
//               nik: nik,
//               mobileNum: mobileNum,
//               otpSender: otpSender,
//               biLocationCode: biLocationCode,
//               accountType: accountType,
//               email: email,
//               motherMaidenName: motherMaidenName,
//               name: name,
//               pob: pob,
//               subCat: subCat,
//               othersOpenAccReason: othersOpenAccReason,
//               othersSrcOfFund: othersSrcOfFund,
//               taxId: taxId,
//               customerAddress: customerAddress,
//               rt: rt,
//               rw: rw,
//               kelurahan: kelurahan,
//               kecamatan: kecamatan,
//               city: city,
//               province: province,
//               postalCode: postalCode,
//               negara: negara,
//               alamatDomisili: alamatDomisili,
//               job: job,
//               yearlyIncome: yearlyIncome,
//               dateOfBirth: dateOfBirth,
//               alamatTempatKerja: alamatTempatKerja,
//               branch: branch,
//               detailPekerjaan: detailPekerjaan,
//               gender: gender,
//               isMaried: isMaried,
//               kodePos: kodePos,
//               namaTempatKerja: namaTempatKerja,
//               patronCompanyAddress: patronCompanyAddress,
//               patronMobileNum: patronMobileNum,
//               patronRelationship: patronRelationship,
//               publisherCity: publisherCity,
//               religion: religion,
//               homePhone: homePhone,
//               officePhone: officePhone,
//               patronName: patronName,
//               projDep: projDep,
//               openAccReason: openAccReason,
//               srcOfFund: srcOfFund,
//               channelPromotionCode: channelPromotionCode,
//               otp: otp,
//               // otp_account: otp_account,
//               refnum: refnum);
//
//       print(
//           'Ini Adalah Model Create Account : ' + createAccountModel.toString());
//       print("Ini Adalah State :" + state.toString());
//       print("Ini Adalah Error Code : " + createAccountModel.errorCode);
//       emit(CreateaccountSuccess(createAccountModel));
//     }
//   }
// }
