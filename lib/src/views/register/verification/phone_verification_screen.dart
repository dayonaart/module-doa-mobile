// ignore_for_file: prefer_const_constructors

import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/PhoneVerifyController.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:eform_modul/src/views/register/verification/description_verification.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';

import '../../../components/label-text.dart';
import '../../../utility/Routes.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromRGBO(51, 51, 51, 1)),
            elevation: 0,
            backgroundColor: CustomThemeWidget.backgroundColorTop,
            centerTitle: true,
            title: Text("Verifikasi Nomor Handphone",
                overflow: TextOverflow.ellipsis, maxLines: 1, style: appBar_Text),
          ),
          body: _VerificationWidgets(),
        ),
      ),
    );
  }
}

class _VerificationWidgets extends StatefulWidget {
  const _VerificationWidgets({Key? key}) : super(key: key);

  @override
  State<_VerificationWidgets> createState() => _VerificationWidgetsState();
}

class _VerificationWidgetsState extends State<_VerificationWidgets> {
  PhoneVerifyController phoneController = Get.put(PhoneVerifyController());

  @override
  void initState() {
    phoneController.getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneVerifyController>(builder: (data) {
      return CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Column(
                children: [
                  Center(
                      child: Text("Verifikasi Nomor ${data.numberPhone}\nPastikan data Anda Sesuai",
                          textAlign: TextAlign.center, style: appBarText.copyWith(fontSize: 16))),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 245),
              child: Image.asset("assets/images/icon-verifikasi-nomor-new.png"),
            )
            // SizedBox(
            //   height: (MediaQuery.maybeOf(context)!.size.width * 1),
            //   child: const SizedBox(
            //     height: 30,
            //     width: 30,
            //     child: Padding(
            //       padding: EdgeInsets.all(20),
            //       child: Image(
            //         image: AssetImage(
            //             "assets/images/icon-verifikasi-nomor-new.png"),
            //         width: 30,
            //         height: 30,
            //       ),
            //     ),
            //   ),
            // ),
          ])),
          SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print("NIK nya adalah" + data.idNumber);
                            data.addStringValuesSF('SMS');
                            if (Get.find<OtpController>().prefs == null) {
                              await Get.find<OtpController>().getData();
                            }
                            // CustomLoading().showLoading("Memuat Data");
                            // await Get.find<OtpController>().sendOTP("SMS");

                            // data.checkProses(context);
                            await Get.find<OtpController>().submitSendOtp();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 48,
                            height: 48,
                            child: Center(
                              child: Text('Kirim melalui SMS',
                                  style: buttonStyleOrange.copyWith(color: Colors.white)),
                            ),
                            decoration: BoxDecoration(
                                color: CustomThemeWidget.orangeButton,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            data.addStringValuesSF('Whatsapp');
                            if (Get.find<OtpController>().prefs == null) {
                              await Get.find<OtpController>().getData();
                            }
                            // CustomLoading().showLoading("Memuat Data");
                            // await Get.find<OtpController>().sendOTP("Whatsapp");
                            // data.checkProses(context);
                            await Get.find<OtpController>().submitSendOtp();
                            // if ((Get.find<OtpController>()
                            //             .sendOtpModelResponse
                            //             ?.errorCode ==
                            //         null) ||
                            //     Get.find<OtpController>()
                            //         .sendOtpModelResponse!
                            //         .errorCode!
                            //         .isEmpty) {
                            //   Get.offNamed(Routes().otp);
                            // }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 48,
                            height: 48,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Kirim melalui Whatsapp',
                                      style: buttonStyleOrange.copyWith(
                                          color: CustomThemeWidget.orangeButton)),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Image.asset(
                                    'assets/images/whatsapp-icon.png',
                                    width: 24,
                                    height: 24,
                                  )
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: CustomThemeWidget.orangeButton),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: blackRoboto.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "Pastikan Keamanan Akun Whatsapp Anda.\n",
                                        style: greyMonserrat.copyWith(
                                            fontSize: 10, color: Color.fromRGBO(11, 17, 13, 0.75))),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showDialog(
                                              context: context,
                                              builder: (x) {
                                                return Center(
                                                  child: AlertDialog(
                                                    title: Text(
                                                      "Tentang Keamanan Verifikasi Akun Whatsapp",
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    content: SizedBox(
                                                      width:
                                                          MediaQuery.of(context).size.width * 0.8,
                                                      // height: MediaQuery.of(
                                                      //             context)
                                                      //         .size
                                                      //         .height *
                                                      //     0.7,

                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: const [
                                                            DescriptionVerification(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      text: "Baca lebih Lanjut",
                                      style: greyMonserrat.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 10,
                                          color: Color.fromRGBO(44, 160, 175, 1)),
                                    ),
                                    TextSpan(
                                        style: greyMonserrat.copyWith(
                                            fontSize: 10, color: Color.fromRGBO(11, 17, 13, 0.75)),
                                        text: " untuk info keamanan verifikasi.")
                                  ])),
                        )
                      ],
                    ),
                  ))),
        ],
      );
    });

    //numberPhone = splitedNumber.join("");
    // return BlocConsumer<SendotpCubit, SendotpState>(
    //   listener: (context, state) {
    //     if (state is SendotpSuccess) {
    //       if (state.sendOtpModel.errorCode == "") {
    //         Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) =>
    //                   OTPScreen(sendOtpModel: state.sendOtpModel)),
    //           (route) => false,
    //         );
    //       } else {
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //             content: (Text(
    //                 ListError().errorMessage(state.sendOtpModel.errorCode)))));
    //       }
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state is SendotpLoading) {
    //       CustomLoading().showLoading("Memuat Data");
    //       return SizedBox();
    //     }
    //     CustomLoading().dismissLoading();
    //     return CustomScrollView(
    //       slivers: [
    //         SliverList(
    //             delegate: SliverChildListDelegate([
    //           Padding(
    //             padding: const EdgeInsets.only(top: 50),
    //             child: Column(
    //               children: [
    //                 Center(
    //                     child: Text(
    //                   "Verifikasi Nomor $numberPhone\nPastikan data Anda Sesuai",
    //                   textAlign: TextAlign.center,
    //                   style: blackRoboto.copyWith(
    //                       fontWeight: FontWeight.normal, fontSize: 16),
    //                 )),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             height: (MediaQuery.maybeOf(context)!.size.width * 1),
    //             child: const SizedBox(
    //               height: 50,
    //               width: 50,
    //               child: Padding(
    //                 padding: EdgeInsets.all(20),
    //                 child: Image(
    //                   image:
    //                       AssetImage("assets/images/icon-verifikasi-nomor.png"),
    //                   width: 50,
    //                   height: 50,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ])),
    //         SliverFillRemaining(
    //             hasScrollBody: false,
    //             child: Align(
    //                 alignment: Alignment.bottomCenter,
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(left: 20, right: 20),
    //                   child: Column(
    //                     children: [
    //                       SizedBox(
    //                         width: 300,
    //                         height: 55,
    //                         child: ElevatedButton(
    //                             style: ElevatedButton.styleFrom(
    //                                 shape: RoundedRectangleBorder(
    //                                     borderRadius:
    //                                         BorderRadius.circular(30)),
    //                                 primary: Colors.white,
    //                                 side: const BorderSide(
    //                                     width: 2,
    //                                     color: themeWidget.mainOrange)),
    //                             onPressed: () {
    //                               print("NIK nya adalah" + nik);
    //                               addStringValuesSF('SMS');
    //                               context.read<SendotpCubit>().sendOtp(
    //                                   nik: nik, //nik,
    //                                   noHP: numberPhone,
    //                                   otpSender: 'SMS',
    //                                   biLocationCode: biLocationCode,
    //                                   accountType: accountType,
    //                                   email: email,
    //                                   motherMaidenName: motherMaidenName,
    //                                   name: name,
    //                                   pob: pob,
    //                                   subCat: subCat,
    //                                   othersOpenAccReason: othersOpenAccReason,
    //                                   othersSrcOfFund: othersSrcOfFund,
    //                                   taxId: taxId,
    //                                   customerAddress: customerAddress,
    //                                   rt: rt,
    //                                   rw: rw,
    //                                   kelurahan: kelurahan,
    //                                   kecamatan: kecamatan,
    //                                   city: city,
    //                                   province: province,
    //                                   postalCode: postalCode,
    //                                   negara: negara,
    //                                   alamatDomisili: alamatDomisili,
    //                                   job: job,
    //                                   yearlyIncome: yearlyIncome,
    //                                   dateOfBirth: dateOfBirth,
    //                                   alamatTempatKerja: alamatTempatKerja,
    //                                   branch: branch,
    //                                   detailPekerjaan: detailPekerjaan,
    //                                   gender: gender,
    //                                   isMaried: isMaried,
    //                                   kodePos: kodePos,
    //                                   namaTempatKerja: namaTempatKerja,
    //                                   patronCompanyAddress:
    //                                       patronCompanyAddress,
    //                                   patronMobileNum: patronMobileNum,
    //                                   patronRelationship: patronRelationship,
    //                                   publisherCity: publisherCity,
    //                                   religion: religion,
    //                                   homePhone: homePhone,
    //                                   officePhone: officePhone,
    //                                   patronName: patronName,
    //                                   projDep: projDep,
    //                                   openAccReason: openAccReason,
    //                                   srcOfFund: srcOfFund,
    //                                   channelPromotionCode:
    //                                       channelPromotionCode);
    //                             },
    //                             child: Text(
    //                               "Kirim melalui SMS",
    //                               style: blackRoboto.copyWith(
    //                                   fontWeight: FontWeight.normal,
    //                                   color: themeWidget.mainOrange),
    //                             )),
    //                       ),
    //                       const SizedBox(
    //                         height: 10,
    //                       ),
    //                       SizedBox(
    //                         width: 300,
    //                         height: 55,
    //                         child: ElevatedButton(
    //                             style: ElevatedButton.styleFrom(
    //                                 primary: Colors.white,
    //                                 side: const BorderSide(
    //                                     width: 2,
    //                                     color: themeWidget.mainOrange)),
    //                             onPressed: () {
    //                               addStringValuesSF('Whatsapp');
    //                               context.read<SendotpCubit>().sendOtp(
    //                                   nik: nik,
    //                                   noHP: numberPhone, //numberPhone,
    //                                   otpSender: 'Whatsapp',
    //                                   biLocationCode: biLocationCode,
    //                                   accountType: accountType,
    //                                   email: email,
    //                                   motherMaidenName: motherMaidenName,
    //                                   name: name,
    //                                   pob: pob,
    //                                   subCat: subCat,
    //                                   othersOpenAccReason: othersOpenAccReason,
    //                                   othersSrcOfFund: othersSrcOfFund,
    //                                   taxId: taxId,
    //                                   customerAddress: customerAddress,
    //                                   rt: rt,
    //                                   rw: rw,
    //                                   kelurahan: kelurahan,
    //                                   kecamatan: kecamatan,
    //                                   city: city,
    //                                   province: province,
    //                                   postalCode: postalCode,
    //                                   negara: negara,
    //                                   alamatDomisili: alamatDomisili,
    //                                   job: job,
    //                                   yearlyIncome: yearlyIncome,
    //                                   dateOfBirth: dateOfBirth,
    //                                   alamatTempatKerja: alamatTempatKerja,
    //                                   branch: branch,
    //                                   detailPekerjaan: detailPekerjaan,
    //                                   gender: gender,
    //                                   isMaried: isMaried,
    //                                   kodePos: kodePos,
    //                                   namaTempatKerja: namaTempatKerja,
    //                                   patronCompanyAddress:
    //                                       patronCompanyAddress,
    //                                   patronMobileNum: patronMobileNum,
    //                                   patronRelationship: patronRelationship,
    //                                   publisherCity: publisherCity,
    //                                   religion: religion,
    //                                   homePhone: homePhone,
    //                                   officePhone: officePhone,
    //                                   patronName: patronName,
    //                                   projDep: projDep,
    //                                   openAccReason: openAccReason,
    //                                   srcOfFund: srcOfFund,
    //                                   channelPromotionCode:
    //                                       channelPromotionCode);
    //                             },
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               children: [
    //                                 Text(
    //                                   "Kirim melalui Whatsapp",
    //                                   style: blackRoboto.copyWith(
    //                                       fontWeight: FontWeight.normal,
    //                                       color: themeWidget.mainOrange),
    //                                 ),
    //                                 SizedBox(
    //                                   width: 10,
    //                                 ),
    //                                 Icon(
    //                                   Icons.whatsapp,
    //                                   color: themeWidget.mainOrange,
    //                                 )
    //                               ],
    //                             )),
    //                       ),
    //                       const SizedBox(
    //                         height: 20,
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(bottom: 30),
    //                         child: RichText(
    //                             textAlign: TextAlign.center,
    //                             text: TextSpan(
    //                                 style: blackRoboto.copyWith(
    //                                   fontWeight: FontWeight.normal,
    //                                 ),
    //                                 children: [
    //                                   const TextSpan(
    //                                       text:
    //                                           "Pastikan Keamanan Akun Whatsapp Anda.\n"),
    //                                   TextSpan(
    //                                     recognizer: TapGestureRecognizer()
    //                                       ..onTap = () {
    //                                         showDialog(
    //                                             context: context,
    //                                             builder: (x) {
    //                                               return Center(
    //                                                 child: AlertDialog(
    //                                                   title: Text(
    //                                                     "Tentang Keamanan Verifikasi Akun Whatsapp",
    //                                                     textAlign:
    //                                                         TextAlign.center,
    //                                                   ),
    //                                                   content: SizedBox(
    //                                                     width: MediaQuery.of(
    //                                                                 context)
    //                                                             .size
    //                                                             .width *
    //                                                         0.8,
    //                                                     // height: MediaQuery.of(
    //                                                     //             context)
    //                                                     //         .size
    //                                                     //         .height *
    //                                                     //     0.7,
    //
    //                                                     child:
    //                                                         SingleChildScrollView(
    //                                                       child: Column(
    //                                                         mainAxisSize:
    //                                                             MainAxisSize
    //                                                                 .min,
    //                                                         children: const [
    //                                                           DescriptionVerification(),
    //                                                         ],
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                 ),
    //                                               );
    //                                             });
    //                                       },
    //                                     text: "Baca lebih Lanjut",
    //                                     style: blackRoboto.copyWith(
    //                                         fontWeight: FontWeight.normal,
    //                                         color: Colors.blue),
    //                                   ),
    //                                   const TextSpan(
    //                                       text:
    //                                           " untuk info keamanan verifikasi.")
    //                                 ])),
    //                       )
    //                     ],
    //                   ),
    //                 ))),
    //       ],
    //     );
    //   },
    // );
  }
}
