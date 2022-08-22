import 'dart:io';

import 'package:eform_modul/BusinessLogic/Registrasi/AcknowledgementController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/CreatePinController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/button-wrap.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:eform_modul/src/views/buka-rekening/home-buka-rekening.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, rootBundle;
import 'package:get/get.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import '../../success-page/create-mbank.dart';

class AcknowledgementScreen extends StatefulWidget {
  @override
  State<AcknowledgementScreen> createState() => _AcknowledgementScreenState();
}

class _AcknowledgementScreenState extends State<AcknowledgementScreen> {
  //Load the image using PdfBitmap.
  AcknowledgementController acknowledgementController = Get.put(AcknowledgementController());
  CreatePinController createPinController = Get.put(CreatePinController());
  DataController dataController = Get.put(DataController());

  @override
  void initState() {
    // TODO: implement initState

    print(createPinController.getCardModelResponse?.cardNum.toString());
    acknowledgementController.getStringValuesSF(
        createPinController.getCardModelResponse?.accountNum,
        createPinController.errorCode,
        createPinController.getCardModelResponse?.cardNum);
    //mode jika ingin jump
    // acknowledgementController.getStringValuesSF(
    //     "1112233445566", "", "21321321321321");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcknowledgementController>(builder: (data) {
      // return check(data);
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: CustomThemeWidget.backgroundColorTop,
              centerTitle: true,
              title: Text(
                'Selesai',
                style: appBarText,
              ),
              elevation: 0,
            ),
            // floatingActionButton:
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: CustomBodyWidgets(
              pathHeaderIcons: "assets/images/icons/thumb_icon.svg",
              headerTextStep: '',
              isWithIconHeader: true,
              headerMarginBottom: 16,
              headerTextDetail: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Pembukaan Rekening Anda Berhasil!",
                    style: infoStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Nomor Rekening",
                  style: infoStyle,
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Nomor Rekening  Berhasil Disalin"),
                      duration: Duration(seconds: 1),
                    ));
                    Clipboard.setData(ClipboardData(
                        text: Get.find<CreatePinController>().getCardModelResponse?.accountNum
                            as String));
                  },
                  child: Row(children: [
                    Text(
                      Get.find<CreatePinController>().getCardModelResponse?.accountNum as String,
                      style: infoStyle.copyWith(color: CustomThemeWidget.formOrange, fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.copy_outlined,
                      color: CustomThemeWidget.formOrange,
                      size: 22.0,
                      semanticLabel: 'Copy',
                    ),
                  ]),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Segera lakukan setoran awal minimal Rp${data.minimumDeposit} paling lambat sebelum ${data.depositDeadline} agar rekening Anda tidak tertutup otomatis. \n\nSelanjutnya Anda dapat mengunjungi kantor cabang BNI terdekat untuk mengambil kartu debit fisik atau buku tabungan.",
                  style: infoStyle,
                ),
              ]),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    thickness: 1,
                    color: CustomThemeWidget.dividerColor,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  for (var i = 0; i < data.attributeAck.length; i++)
                    // rowtext(
                    //   data.attributeAck[i],
                    //   data.valueAck[i],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: Text(data.attributeAck[i], style: infoStyle)),
                          Expanded(
                            flex: 3,
                            child: Text(
                              data.valueAck[i],
                              textAlign: TextAlign.right,
                              style: infoStyle.copyWith(color: CustomThemeWidget.formOrange),
                            ),
                          )
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email",
                        style: infoStyle,
                      ),
                      Text(
                        data.email,
                        style: infoStyle.copyWith(color: CustomThemeWidget.formOrange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Divider(
                    thickness: 1,
                    color: CustomThemeWidget.dividerColor,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonCustomWrap(
                        margin: EdgeInsets.all(0),
                        styleButton: "2",
                        text: "Simpan Bukti Pendaftaran",
                        ontap: () async {
                          await data.generatePDF();
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ButtonCustomWrap(
                          margin: EdgeInsets.all(0),
                          styleButton: "2",
                          text: "Registrasi BNI Mobile Banking",
                          ontap: () async {
                            await data.submit();
                            // CustomLoading().showLoading("Memuat Data");
                            // await data.cekMif(
                            //     cifnum: createPinController.cardandPinModel!.cifNum,
                            //     email: data.email,
                            //     phone: data.phone);
                            // context.read<CekmifCubit>().cekMif(
                            //     cifnum: widget.cardandPinModel.cifNum,
                            //     email: email,
                            //     phone: phone);
                            CustomLoading().dismissLoading();
                          }),
                      SizedBox(
                        height: 8,
                      ),
                      ButtonCustomWrap(
                        margin: EdgeInsets.all(0),
                        styleButton: "1",
                        text: "Selesai",
                        ontap: () async {
                          data.openMBank();
                          // exit(0);
                          // await dataController.prefs.clear;
                          // Get.deleteAll();
                          // Get.offAll(() => HomeBukaRekening(),
                          //     transition: Transition.rightToLeft);
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// return BlocConsumer<CekmifCubit, CekmifState>(
//   listener: (context, state) {
//     if (state is CekmifSuccess) {
//       if (state.errorCode == '9001') {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CreateMbank(
//                       cifnum: widget.cardandPinModel.cifNum,
//                     )));
//       }
//     } else if (state is CekmifFailed) {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return Dialog(
//                 insetPadding: EdgeInsets.only(
//                   top: 10,
//                   left: 10,
//                   right: 10,
//                 ),
//                 // child: Container(
//                 //   width: 900,
//                 //   height: 40sadsadasd,
//                 // ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           margin: EdgeInsets.only(left: 20, right: 20),
//                           decoration: BoxDecoration(
//                               color: themeWidget.orangeButton,
//                               shape: BoxShape.circle),
//                           child: Center(
//                             child: Image.asset(
//                               'assets/images/tanda_seru.png',
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'Mohon Maaf',
//                           style: blackRoboto.copyWith(fontSize: 18),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'User ID yang Anda masukkan telah terdaftar di sistem BNI Mobile Banking, silahkan masukkan user ID lainnya',
//                           textAlign: TextAlign.center,
//                           style: blackRoboto.copyWith(
//                               fontWeight: FontWeight.normal),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 10),
//                       child: ButtonCostum(
//                         width: MediaQuery.of(context).size.width - 120,
//                         ontap: () {
//                           Navigator.of(context).pop();
//                         },
//                         text: 'Oke Saya Mengerti',
//                       ),
//                     )
//                   ],
//                 ));
//           });
//       // Navigator.pop(context);
//     }
//   },
//   builder: (context, state) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 223, 239, 250),
//       body: Center(
//         child: (isLoading == true || state is CekmifLoading)
//             ? CircularProgressIndicator()
//             : ListView(
//                 children: [
//                   Column(
//                     children: [
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       SizedBox(
//                           height: 100,
//                           width: 100,
//                           child: Image.asset(
//                               "assets/images/simpanan-jempol-icon.png")),
//                       Center(
//                           child: Text(
//                         "Yeay!",
//                         style: blackRoboto.copyWith(
//                           fontSize: 50,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       )),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Center(
//                           child: Text(
//                         "Proses pembukaan rekening Anda berhasil",
//                         style: blackRoboto.copyWith(
//                           fontWeight: FontWeight.normal,
//                         ),
//                       )),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding:
//                         const EdgeInsets.only(left: 10, right: 30, top: 20),
//                     width: MediaQuery.of(context).size.width * 1,
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10))),
//                     child: Column(
//                       children: [
//                         for (var i = 0; i < attributeAck.length; i++)
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 20),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       attributeAck[i],
//                                       style: blackRoboto.copyWith(
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                     )),
//                                 Expanded(
//                                     child: Text(
//                                   valueAck[i],
//                                   textAlign: TextAlign.left,
//                                   style: blackRoboto.copyWith(
//                                       fontWeight: FontWeight.normal,
//                                       fontSize: 13,
//                                       color: themeWidget.mainOrange),
//                                 ))
//                               ],
//                             ),
//                           )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 1,
//                     decoration: const BoxDecoration(
//                         color: Color.fromARGB(255, 255, 217, 207)),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 30, bottom: 20, left: 20, right: 20),
//                           child: Text(
//                             firstParagraph,
//                             textAlign: TextAlign.justify,
//                             style: blackRoboto.copyWith(
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 15, bottom: 20, left: 20, right: 20),
//                           child: Visibility(
//                             visible: indexPosisi == "1" ? true : false,
//                             child: Text(
//                               secondParagraph,
//                               textAlign: TextAlign.justify,
//                               style: blackRoboto.copyWith(
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ),
//                         ButtonCostum(
//                           ontap: () {
//                             context.read<CekmifCubit>().cekMif(
//                                 cifnum: widget.cardandPinModel.cifNum,
//                                 email: email,
//                                 phone: phone);
//                           },
//                           text: "Pendaftaran BNI Mobile Banking",
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, right: 8),
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   primary: themeWidget.mainOrange,
//                                   minimumSize: const Size(340, 40),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(20))),
//                               onPressed: (() {
//                                 createPDF();
//                               }),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                   Icon(Icons.print),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     "Simpan Bukti Pendaftaran",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   },
// );
