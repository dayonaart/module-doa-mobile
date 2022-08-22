import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/WorkDetailController.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/custom_textfromfield.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/pekerjaan-page/pekerjaan_screen.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:flutter/material.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../components/leading.dart';

class WorkDetailScreen extends StatefulWidget {
  const WorkDetailScreen({Key? key}) : super(key: key);

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final detailFocus = FocusNode();
  final namaTempatFocus = FocusNode();
  final noTelpFocus = FocusNode();
  final alamatFocus = FocusNode();
  final kodePosFocus = FocusNode();
  WorkDetailController workDetailController = Get.put(WorkDetailController());

  @override
  void initState() {
    super.initState();
    workDetailController.getSharedPrefWorkDetail();

    // jsonReader();
  }

  // void jsonReader() async {
  //   readJsonProvinsi();
  //   readJsonKota();
  //   readJsonKantor();
  //   readJsonBi();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(
      builder: (value) {
        return WillPopScope(
          onWillPop: () async {
            Get.off(() => PekerjaanScreeen(), transition: Transition.rightToLeft);
            return true;
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: Scaffold(
                  appBar: AppBar(
                    leading: LeadingIcon(
                      context: context,
                      onPressed: () {
                        Get.off(() => PekerjaanScreeen(), transition: Transition.rightToLeft);
                      },
                    ),
                    elevation: 1,
                    backgroundColor: CustomThemeWidget.backgroundColorTop,
                    iconTheme: const IconThemeData(color: Colors.black),
                    centerTitle: true,
                    title: Text("Detail Pekerjaan", style: appBarText),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: ButtonCostum(
                    ontap: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (value.jobDetail.text == "" ||
                            value.jobPlace.text == "" ||
                            value.officeAddress.text == "" ||
                            value.officePostalCode.text == "") {
                          value.statusTextForm = true;
                          value.update();
                          return null;
                        }
                        if (value.jobDetail.text.length < 5 ||
                            value.jobDetail.text.length > 40 ||
                            value.jobPlace.text.length < 5 ||
                            value.jobPlace.text.length > 60 ||
                            value.officeAddress.text.length < 5 ||
                            value.officeAddress.text.length > 40 ||
                            value.officePostalCode.text.length < 5 ||
                            value.officePostalCode.text.length > 5) {
                          return null;
                        }

                        if (value.statusCharLength == false) {
                          await workDetailController.setSharedPrefWorkDetail(
                              value.jobDetail.text,
                              value.jobPlace.text,
                              value.officePhoneNumber.text,
                              value.officeAddress.text,
                              value.officePostalCode.text);
                          setState(() {});
                          await workDetailController.getSharedPrefWorkDetail();
                          final prefs = Get.find<DataController>().prefs;
                          if (prefs.getString('indexPosisi') == '1') {
                            Get.toNamed(Routes().pemilihanCabangIndonesia);
                          } else {
                            Get.toNamed(Routes().pemilihanCabangLuar);
                          }
                        }
                      }
                    },
                    text: "Selanjutnya",
                  ),
                  body: Form(
                    key: _formKey,
                    child: CustomBodyWidgets(
                      headerMarginBottom: 0,
                      headerTextStep: "Langkah 4 dari 6",
                      pathHeaderIcons: "assets/images/icons/book_icon.svg",
                      isWithIconHeader: true,
                      content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          "Detail Pekerjaan",
                          style: bodyStyle,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        // TextFormCustom(
                        //   keyFormField: const ObjectKey('1'),
                        //   textController: value.detailPekerjaanController,
                        //   minimalChar: 5,
                        //   maximalChar: 40,
                        //   hintText: "",
                        //   statusTextForm: value.statusTextForm,
                        // ),
                        CustomTextFromField(
                          inputFormater: [UpperCaseTextField()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: value.jobDetail,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "tidak boleh kosong";
                            }
                            if (value.length < 5 && value != '') {
                              return "minimal 5 karakter";
                            }

                            if (value.length > 40 && value != '') {
                              return "maksimal 40 karakter";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            "Diisi keterangan pekerjaan saat ini seperti jabatan, posisi pekerjaan atau keterangan lainnya berkaitan dengan pekerjaan yang dipilih.",
                            textAlign: TextAlign.justify,
                            style: infoStyle),
                        const SizedBox(height: 20),
                        Text("Nama Tempat Kerja / Perusahaan", style: bodyStyle),
                        SizedBox(
                          height: 8,
                        ),

                        CustomTextFromField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: value.jobPlace,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "tidak boleh kosong";
                            }
                            if (value.length < 5 && value != '') {
                              return "minimal 5 karakter";
                            }

                            if (value.length > 60 && value != '') {
                              return "maksimal 60 karakter";
                            }
                            return null;
                          },
                          inputFormater: [
                            UpperCaseTextField(),
                            FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9\.\\-\\/\,\\s]'))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text("No. Telpon Tempat Bekerja (bila ada)", style: bodyStyle),
                        SizedBox(
                          height: 8,
                        ),
                        // TextFormCustom(
                        //   keyFormField: const ObjectKey('3'),
                        //   minimalChar: 8,
                        //   maximalChar: 13,
                        //   keyboardType: TextInputType.phone,
                        //   textController: value.noTelponTempatKerjaController,
                        //   itCantEmpty: false,
                        // ),
                        CustomTextFromField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: value.officePhoneNumber,
                          validator: (value) {
                            if (value!.length < 8 && value != '') {
                              return "minimal 8 karakter";
                            }

                            if (value.length > 13 && value != '') {
                              return "maksimal 13 karakter";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          inputFormater: [
                            UpperCaseTextField(),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text("Alamat Tempat Kerja", style: bodyStyle),
                        SizedBox(
                          height: 8,
                        ),
                        // TextFormCustom(
                        //   keyFormField: const ObjectKey('4'),
                        //   minimalChar: 5,
                        //   maximalChar: 40,
                        //   textController: value.alamatKerjaController,
                        //   statusTextForm: value.statusTextForm,
                        // ),
                        CustomTextFromField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: value.officeAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "tidak boleh kosong";
                            }
                            if (value.length < 5 && value != '') {
                              return "minimal 5 karakter";
                            }

                            if (value.length > 40 && value != '') {
                              return "maksimal 40 karakter";
                            }
                            return null;
                          },
                          inputFormater: [
                            UpperCaseTextField(),
                            FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9\.\\-\\/\,\\s]'))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text("Kode Pos", style: bodyStyle),
                        SizedBox(
                          height: 8,
                        ),
                        // TextFormCustom(
                        //   keyFormField: const ObjectKey('5'),
                        //   isCodePost: true,
                        //   minimalChar: 5,
                        //   maximalChar: 5,
                        //   keyboardType: TextInputType.phone,
                        //   textController: value.kodePosController,
                        //   statusTextForm: value.statusTextForm,
                        // ),
                        CustomTextFromField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: value.officePostalCode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "tidak boleh kosong";
                            }
                            if (value.length < 5 && value != '') {
                              return "minimal 5 karakter";
                            }

                            if (value.length > 5 && value != '') {
                              return "maksimal 5 karakter";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          inputFormater: [
                            UpperCaseTextField(),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        )
                      ]),
                      headerTextDetail: Text(
                          "Lengkapi detail informasi mengenai pekerjaan dan tempat bekerja Anda.",
                          style: infoStyle),
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }

  // Widget ashdsa() {
  //   return SingleChildScrollView(
  //     child: Form(
  //       key: _formKey,
  //       autovalidateMode: AutovalidateMode.onUserInteraction,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           headerForm(
  //             "assets/images/icons/book_icon.svg",
  //             "",
  //             Text(
  //               "Lengkapi detail informasi mengenai pekerjaan dan tempat bekerja Anda.",
  //               style: TextStyle(
  //                   fontFamily: CustomThemeWidget.montserrat,
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: 14),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 32,
  //           ),
  //           Text(
  //             "Detail Pekerjaan",
  //             style: TextStyle(
  //                 fontFamily: CustomThemeWidget.montserrat,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 14),
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           // TextFormCustom(
  //           //   keyFormField: const ObjectKey('1'),
  //           //   textController: value.detailPekerjaanController,
  //           //   minimalChar: 5,
  //           //   maximalChar: 40,
  //           //   hintText: "",
  //           //   statusTextForm: value.statusTextForm,
  //           // ),
  //           CustomTextFromField(
  //             controller: value.detailPekerjaanController,
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "tidak boleh kosong";
  //               }
  //               if (value.length < 5 && value != '') {
  //                 return "minimal 5 karakter";
  //               }

  //               if (value.length > 40 && value != '') {
  //                 return "maksimal 40 karakter";
  //               }
  //               return null;
  //             },
  //           ),
  //           SizedBox(
  //             height: 16,
  //           ),
  //           Text(
  //             "Diisi keterangan pekerjaan saat ini seperti jabatan, posisi pekerjaan atau keterangan lainya berkaitan dengan pekerjaan yang dipilih",
  //             textAlign: TextAlign.justify,
  //             style: TextStyle(
  //                 fontFamily: CustomThemeWidget.montserrat,
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: 14),
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             "Nama Tempat Kerja / Perusahaan",
  //             style: TextStyle(
  //                 fontFamily: CustomThemeWidget.montserrat,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 14),
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           // TextFormCustom(
  //           //   keyFormField: const ObjectKey('2'),
  //           //   hintText: "",
  //           //   minimalChar: 5,
  //           //   maximalChar: 60,
  //           //   withSymbol: true,
  //           //   textController: value.namaTempatKerjaController,
  //           //   statusTextForm: value.statusTextForm,
  //           // ),
  //           CustomTextFromField(
  //             controller: value.namaTempatKerjaController,
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "tidak boleh kosong";
  //               }
  //               if (value.length < 5 && value != '') {
  //                 return "minimal 5 karakter";
  //               }

  //               if (value.length > 60 && value != '') {
  //                 return "maksimal 60 karakter";
  //               }
  //               return null;
  //             },
  //             inputFormater: [
  //               FilteringTextInputFormatter.allow(
  //                   RegExp('[A-Za-z0-9\.\\-\\/\,\\s]'))
  //             ],
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             "No. Telpon Tempat Bekerja (bila ada)",
  //             style: TextStyle(
  //                 fontFamily: CustomThemeWidget.montserrat,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 14),
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           // TextFormCustom(
  //           //   keyFormField: const ObjectKey('3'),
  //           //   minimalChar: 8,
  //           //   maximalChar: 13,
  //           //   keyboardType: TextInputType.phone,
  //           //   textController: value.noTelponTempatKerjaController,
  //           //   itCantEmpty: false,
  //           // ),
  //           CustomTextFromField(
  //             controller: value.noTelponTempatKerjaController,
  //             validator: (value) {
  //               if (value!.length < 8 && value != '') {
  //                 return "minimal 8 karakter";
  //               }

  //               if (value.length > 13 && value != '') {
  //                 return "maksimal 13 karakter";
  //               }
  //               return null;
  //             },
  //             keyboardType: TextInputType.phone,
  //             inputFormater: [
  //               FilteringTextInputFormatter.allow(RegExp('[0-9]'))
  //             ],
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             "Alamat Tempat Kerja",
  //             style: TextStyle(
  //                 fontFamily: CustomThemeWidget.montserrat,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 14),
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           // TextFormCustom(
  //           //   keyFormField: const ObjectKey('4'),
  //           //   minimalChar: 5,
  //           //   maximalChar: 40,
  //           //   textController: value.alamatKerjaController,
  //           //   statusTextForm: value.statusTextForm,
  //           // ),
  //           CustomTextFromField(
  //             controller: value.alamatKerjaController,
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "tidak boleh kosong";
  //               }
  //               if (value.length < 5 && value != '') {
  //                 return "minimal 5 karakter";
  //               }

  //               if (value.length > 40 && value != '') {
  //                 return "maksimal 40 karakter";
  //               }
  //               return null;
  //             },
  //             inputFormater: [
  //               FilteringTextInputFormatter.allow(
  //                   RegExp('[A-Za-z0-9\.\\-\\/\,\\s]'))
  //             ],
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             "Kode Pos",
  //             style: TextStyle(
  //                 fontFamily: CustomThemeWidget.montserrat,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 14),
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           // TextFormCustom(
  //           //   keyFormField: const ObjectKey('5'),
  //           //   isCodePost: true,
  //           //   minimalChar: 5,
  //           //   maximalChar: 5,
  //           //   keyboardType: TextInputType.phone,
  //           //   textController: value.kodePosController,
  //           //   statusTextForm: value.statusTextForm,
  //           // ),
  //           CustomTextFromField(
  //             controller: value.kodePosController,
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "tidak boleh kosong";
  //               }
  //               if (value.length < 5 && value != '') {
  //                 return "minimal 5 karakter";
  //               }

  //               if (value.length > 5 && value != '') {
  //                 return "maksimal 5 karakter";
  //               }
  //               return null;
  //             },
  //             keyboardType: TextInputType.phone,
  //             inputFormater: [
  //               FilteringTextInputFormatter.allow(RegExp('[0-9]'))
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
