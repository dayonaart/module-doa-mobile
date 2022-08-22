import 'package:eform_modul/BusinessLogic/Registrasi/WorkDetailController.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:eform_modul/src/views/pekerjaan-page/pekerjaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../BusinessLogic/Registrasi/DataController.dart';
import '../../../../components/custom_textfromfield.dart';
import '../../../../components/leading.dart';
import '../../../../components/theme_const.dart';
import '../../../../utility/Routes.dart';

class WorkDetailScreenAlt extends StatefulWidget {
  const WorkDetailScreenAlt({Key? key}) : super(key: key);

  @override
  State<WorkDetailScreenAlt> createState() => _WorkDetailScreenAltState();
}

class _WorkDetailScreenAltState extends State<WorkDetailScreenAlt> {
  WorkDetailController workDetailController = Get.put(WorkDetailController());

  @override
  void initState() {
    super.initState();
    workDetailController.getSharedPrefWorkDetail();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(builder: (data) {
      return WillPopScope(
        onWillPop: () async {
          Get.off(() => PekerjaanScreeen(), transition: Transition.rightToLeft);
          return true;
        },
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
          floatingActionButton: ButtonCostum(
              ontap: !data.validationbutton
                  ? null
                  : () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      bool checkValid = data.validationButton();
                      print(checkValid);
                      if (checkValid == true) {
                        final prefs = Get.find<DataController>().prefs;
                        if (prefs.getString('indexPosisi') == '1') {
                          Get.offNamed(Routes().pemilihanCabangIndonesia);
                        } else {
                          Get.offNamed(Routes().pemilihanCabangLuar);
                        }
                      }
                    }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: Form(
            onChanged: data.onchanged(),
            key: data.formKey,
            child: CustomBodyWidgets(
                isWithIconHeader: true,
                pathHeaderIcons: "assets/images/icons/book_icon.svg",
                headerTextStep: "Langkah 4 dari 6",
                headerTextDetail: Text(
                  "Lengkapi detail informasi mengenai pekerjaan dan tempat bekerja Anda.",
                  style: infoStyle,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Pekerjaan",
                      style: labelText,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFromField(
                      inputFormater: [UpperCaseTextField()],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.jobDetail,
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
                      "Diisi keterangan pekerjaan saat ini seperti jabatan, posisi pekerjaan atau keterangan lainya berkaitan dengan pekerjaan yang dipilih",
                      textAlign: TextAlign.justify,
                      style: infoStyle,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Nama Tempat Kerja / Perusahaan",
                      style: labelText,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFromField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.jobPlace,
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
                    Text(
                      "No. Telpon Tempat Bekerja (bila ada)",
                      style: labelText,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFromField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.officePhoneNumber,
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
                    Text(
                      "Alamat Tempat Kerja",
                      style: labelText,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFromField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.officeAddress,
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
                    Text(
                      "Kode Pos",
                      style: labelText,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFromField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.officePostalCode,
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
                  ],
                )),
          ),
        ),
      );
    });
  }
}
