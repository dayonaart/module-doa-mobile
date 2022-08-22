import 'package:async/async.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/countdown.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/models/send-otp-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final SendOtpModel? sendOtpModel;
  const OTPScreen({Key? key, this.sendOtpModel}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with SingleTickerProviderStateMixin {
  OtpController otpController = Get.put(OtpController());
  TextEditingController otpCode = TextEditingController();

  @override
  void dispose() {
    if (otpController.animationController != null) {
      otpController.animationController!.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    otpController.getData();
    otpController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 3),
    );
    otpController.animationController!.forward();
    otpController.update();
    _countdown(180);
  }

  void _countdown(int _timer) {
    final periodicTimer = RestartableTimer(
      Duration(seconds: _timer),
      () {
        otpController.isHide = !otpController.isHide;
        otpController.animationController!.reset();
        otpController.update();
      },
    );
    periodicTimer.reset();
  }

  Widget seperator(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

  // Widget reminder() {
  //   return Center(
  //     child: Container(
  //       width: MediaQuery.of(context).size.width * 0.9,
  //       decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(6.0),
  //           )),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.only(top: 15),
  //             child: Center(
  //               child: Text(
  //                 'Perhatian',
  //                 style: blackRoboto.copyWith(
  //                     fontWeight: FontWeight.bold, fontSize: 16),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.05,
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(left: 20.0, right: 20),
  //             child: Text(
  //               'Pastikan nomor handphone Anda aktif serta memiliki pulsa untuk pengiriman OTP melalui SMS atau terhubung dengan jaringan internet untuk pengiriman OTP melalui Whatsapp',
  //               textAlign: TextAlign.center,
  //               style: blackRoboto.copyWith(
  //                 fontWeight: FontWeight.normal,
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.05,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            appBar: AppBar(
                elevation: 1,
                backgroundColor: CustomThemeWidget.backgroundColorTop,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                title: Text("Kode OTP", style: appBar_Text)),
            body: Form(
              key: _.formKey,
              child: CustomBodyWidgets(
                content: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PinCodeTextField(
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                          keyboardType: TextInputType.phone,
                          pinTheme: PinTheme(
                              selectedColor: CustomThemeWidget.orangeButton,
                              activeColor: Color(0xffE7E7E7),
                              fieldWidth: 30,
                              inactiveColor: Color(0xffE7E7E7)),
                          appContext: context,
                          length: 6,
                          onCompleted: (value) {
                            _.currentText = value;
                          },
                          onChanged: (value) {
                            _.onchanged(value);
                          }),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (_.isHide == false) {
                                _countdown(180);
                                otpController.animationController!.reset();
                                otpController.animationController!.forward();
                                _.isHide = !_.isHide;
                                _.update();
                                print('isHide =' + _.isHide.toString());
                                print(_.idNumber);
                                await _.submitSendOtp();
                                if (otpController.messageHeaderSendOtp == false) {
                                  return Get.dialog(PopoutWrapContent(
                                      textTitle: '',
                                      button_radius: 4,
                                      content: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                                'assets/images/icons/mail_icon.svg'),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text('Berhasil', style: PopUpTitle),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            'Kode OTP telah dikirim ke nomor handphone Anda.',
                                            style: infoStyle,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      buttonText: 'Ok, saya Mengerti',
                                      ontap: () {
                                        Get.back();
                                        // Navigator.of(context).pop();
                                      }));
                                }
                              }
                            },
                            child: Text(
                              "Kirim ulang kode OTP",
                              style: labelText.copyWith(
                                  color: _.isHide
                                      ? Color.fromRGBO(142, 142, 142, 1)
                                      : CustomThemeWidget.orangeButton,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Countdown(
                            isHide: _.isHide,
                            animation: StepTween(
                              begin: 3 * 60,
                              end: 0,
                            ).animate(otpController.animationController!),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(style: labelTextBlue, children: [
                            TextSpan(
                              text: "Pastikan ",
                            ),
                            TextSpan(
                                text: "nomor handphone Anda aktif dan memiliki pulsa ",
                                style: labelTextBlueBold),
                            TextSpan(text: "untuk pengiriman OTP melalui SMS atau "),
                            TextSpan(
                                text: "terhubung dengan jaringan internet ",
                                style: labelTextBlueBold),
                            TextSpan(text: "untuk pengiriman OTP melalui WhatsApp."),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
                pathHeaderIcons: "assets/images/icons/mark_shield_icon.svg",
                headerTextStep: '',
                headerTextDetail: RichText(
                  text: TextSpan(
                    style: MediumBoldGreyText,
                    text: "Masukkan 6 digit Kode OTP" + "\n",
                    children: [
                      TextSpan(
                          text: "Kode OTP dikirimkan ke nomor +${_.phoneNumber}",
                          style: labelText.copyWith(fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: ButtonCostum(
                width: double.infinity,
                ontap: !_.validationButton ? null : () async => await _.createAccountDio()),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        ),
      );
    });
  }
}
