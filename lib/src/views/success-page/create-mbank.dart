// ignore_for_file: prefer_const_constructors

import 'package:eform_modul/BusinessLogic/Registrasi/CreateMbankController.dart';
import 'package:eform_modul/src/components/custom_textfromfield.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/register/Acknowledgement/acknowledgement_screen.dart';
import 'package:eform_modul/src/views/success-page/success-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/alert-dialog-new-wrap.dart';
import '../../components/button.dart';
import '../../components/custom_body.dart';
import '../../components/label-text.dart';
import '../../components/leading.dart';
import '../../components/theme_const.dart';
import '../../utility/custom_loading.dart';
import '../syarat-dan-ketentuan/syarat-dan-ketentuan.dart';

class CreateMbank extends StatefulWidget {
  const CreateMbank({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateMbank> createState() => _CreateMbankState();
}

class _CreateMbankState extends State<CreateMbank> {
  CreateMbankController mbankController = Get.put(CreateMbankController());

  @override
  void initState() {
    if (mbankController.prefs == null) {
      mbankController.getData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateMbankController>(builder: (data) {
      return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ButtonCostum(
            ontap: () async {
              CustomLoading().showLoading("Memuat Data");
              // data.sendData(widget.cifnum);
              CustomLoading().dismissLoading();
              data.submit();

              if (data.state == Status.Success) {
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return PopoutWrapContent(
                //           textTitle: 'Maaf',
                //           buttonText: 'Oke Saya Mengerti',
                //           button_radius: 6,
                //           content: Container(
                //             margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                //             child: Column(
                //               children: [
                //                 Text(
                //                   'User ID yang Anda masukkan telah terdaftar di sistem BNI Mobile Banking, silakan masukkan user ID lainnya',
                //                   style: bodyText.copyWith(fontSize: 12),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ],
                //             ),
                //           ),
                //           ontap: () {});
                //     });
                Get.off(() => SuccessScreen(), transition: Transition.rightToLeft);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SuccessScreen(
                //             username: inputUserIdController.text, email: email)),
                //         (route) => false);
                // } else if (state is CekmbankLoading) {
                //   showDialog(
                //       barrierDismissible: false,
                //       context: context,
                //       builder: (context) {
                //         CustomLoading().showLoading("Memuat Data");
                //         return Center(child: SizedBox());
                //       });
              } else if (data.state == Status.Failed) {
                if (data.errorCode == '500') {
                  Get.dialog(PopoutWrapContent(
                      textTitle: '',
                      button_radius: 4,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Mohon Maaf', style: PopUpTitle),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'User ID yang Anda masukkan telah terdaftar di sistem BNI Mobile Banking, silahkan masukkan user ID lainnya',
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
                } else {
                  Get.dialog(PopoutWrapContent(
                      textTitle: '',
                      button_radius: 4,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset('assets/images/icons/bell_icon.svg'),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Mohon Maaf', style: PopUpTitle),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Service Sedang Maintenance',
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
            text: 'Lanjut',
          ),
          appBar: AppBar(
            leading: LeadingIcon(
              context: context,
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AcknowledgementScreen(),
                  ),
                );
              },
            ),
            iconTheme: IconThemeData(color: Color.fromRGBO(51, 51, 51, 1)),
            elevation: 0,
            backgroundColor: CustomThemeWidget.backgroundColorTop,
            centerTitle: true,
            title: Text("Pendaftaran BNI Mobile Banking",
                overflow: TextOverflow.ellipsis, maxLines: 1, style: appBar_Text),
          ),
          body: Column(children: [
            // SizedBox(
            //   height: 24,
            // ),
            // Image.asset(
            //   'assets/images/create-mbank-icon.png',
            //   width: 48,
            //   height: 48,
            // ),
            // SizedBox(
            //   height: 8,
            // ),

            CustomBodyWidgets(
              // headerMarginBottom: 8,

              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User ID Mobile Banking ',
                    style: labelText.copyWith(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextFromField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        final regex = RegExp(r'^(?=.[A-Za-z])(?=.\\d{2,})[A-Za-z\\d]*');
                        String onlyNumber = value!.replaceAll(RegExp(r'[^0-9]'), '');
                        String onlyString = value.replaceAll(RegExp(r'[^A-Za-z]'), '');
                        print('number' + onlyNumber);
                        print('string' + onlyString);
                        if (value.isEmpty) {
                          return "ID Mobile Banking tidak boleh kosong";
                        } else if (onlyNumber.length < 2 || onlyString.length < 2) {
                          return 'ID Mobile Banking hanya boleh menggunakan huruf dan minimal menggunakan 2 angka'
                              '';
                        } else if (value.length < 8 && value.length > 12) {
                          return "ID Mobile Banking minimal 8 makismal 12 karakter";
                        }
                      },
                      controller: mbankController.inputUserIdController),
                ],
              ),
              pathHeaderIcons: "assets/images/icons/mobile-icon.svg",
              headerTextDetail: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: infoStyle,
                  children: [
                    TextSpan(
                      text: "Buat ",
                      style: labelText,
                    ),
                    TextSpan(
                        text: "User ID Mobile Banking Anda ",
                        style: labelText.copyWith(fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: "untuk dapat melakukan aktifitas transaksi di BNI Mobile Banking.",
                        style: labelText),
                  ],
                ),
              ),
            ),

            // Image.asset(
            //   'assets/images/simpanan-form-icon.png',
            //   width: 100,
            //   height: 100,
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            // content()
          ]),
        ),
      );
    });

    // return BlocConsumer<CekmbankCubit, CekmbankState>(
    //   listener: (context, state) {
    //
    //   },
    //   builder: (context, state) {
    //     return ;
    //   },
    // );
  }

  // Widget indicator() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 40),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: List.generate(2, (index) {
  //         return Container(
  //           margin: EdgeInsets.only(right: 5),
  //           width: (index == 0) ? 28 : 16,
  //           height: 16,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(20)),
  //               color: (index == 0)
  //                   ? CustomThemeWidget.orangeButton
  //                   : Colors.grey),
  //         );
  //       }),
  //     ),
  //   );
  // }

  Widget inputUserId() {
    return GetBuilder<CreateMbankController>(builder: (data) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: data.inputUserIdController,
            maxLength: 16,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              final regex = RegExp(r'^(?=.[A-Za-z])(?=.\\d{2,})[A-Za-z\\d]*');
              String onlyNumber = value!.replaceAll(RegExp(r'[^0-9]'), '');
              String onlyString = value.replaceAll(RegExp(r'[^A-Za-z]'), '');
              print('number' + onlyNumber);
              print('string' + onlyString);
              if (value.isEmpty) {
                return "ID Mobile Banking tidak boleh kosong";
              } else if (onlyNumber.length < 2 || onlyString.length < 2) {
                return 'ID Mobile Banking hanya boleh menggunakan huruf dan minimal menggunakan 2 angka'
                    '';
              } else if (value.length < 8 && value.length > 12) {
                return "ID Mobile Banking minimal 8 makismal 12 karakter";
              }
            },
            onChanged: (value) {
              setState(() {
                // if (value.length < 16) {
                //   setState(() {
                //     isZero = false;
                //     isError = true;
                //   });
                // } else {
                //   setState(() {
                //     isError = false;
                //   });
                // }
              });
            },
            decoration: InputDecoration(
                hintText: '',
                hintStyle: blacktext.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
          ),
          // (isError == true)
          //     ? Text(
          //         '* NIK Harus Memiliki 16 Digit',
          //         style: TextStyle(color: Colors.red),
          //       )
          //     : Container()
        ],
      );
    });
  }

  Widget content() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User ID Mobile Banking',
            style: blacktext,
          ),

          inputUserId(),
          // SizedBox(
          //   height: 20,
          // ),
          // Text(
          //   'Tanggal Lahir',
          //   style: blacktext,
          // ),
          // inputTanggal()
        ],
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          offset: Offset(0, 8),
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
