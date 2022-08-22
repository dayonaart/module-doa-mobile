// ignore_for_file: prefer_const_constructors

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/src/components/alert-dialog-new-wrap.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/models/Status.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../BusinessLogic/Registrasi/DataDiri1Controller.dart';
import '../../components/custom_body.dart';
import '../../components/custom_textfromfield.dart';
import '../../components/custom_textfromfield_date.dart';
import '../../components/leading.dart';

class DataDiri1 extends StatefulWidget {
  const DataDiri1({Key? key}) : super(key: key);

  @override
  State<DataDiri1> createState() => _DataDiri1State();
}

class _DataDiri1State extends State<DataDiri1> {
  DataDiri1Controller dataDiri1Controller = Get.put(DataDiri1Controller());
  DataController dataController = Get.put(DataController());

  // bool isError = false;
  bool isZero = true;
  // bool isErrorReferal = false;

  @override
  void initState() {
    dataDiri1Controller.getStringValuesSF();
    if (kDebugMode) {
      print('Ini Nomor HP : ');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await dataDiri1Controller.willPop(dataController.prefs),
      child: GetBuilder<DataDiri1Controller>(builder: (data) {
        return MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            appBar: AppBar(
              leading: LeadingIcon(
                context: context,
                onPressed: () => dataDiri1Controller.onBackButton(dataController.prefs),
              ),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Data e-KTP",
                style: appBarText,
              ),
              backgroundColor: CustomThemeWidget.backgroundColorTop,
            ),
            body: CustomBodyWidgets(
              pathHeaderIcons: "assets/images/icons/person_icon.svg",
              headerTextStep: 'Langkah 1 dari 6',
              headerTextDetail: RichText(
                text: TextSpan(
                  style: infoStyle,
                  children: [
                    TextSpan(
                      text: "Pastikan semua  data diri ",
                      style: labelText,
                    ),
                    TextSpan(
                        text: "sudah sesuai dengan e-KTP Anda.",
                        style: labelText.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              content: Form(
                onChanged: data.onchanged(),
                key: data.formKey,
                child: Container(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("NIK", style: labelText),
                    SizedBox(height: 8),
                    CustomTextFromField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: dataDiri1Controller.idNumber,
                      keyboardType: TextInputType.number,
                      inputFormater: [
                        UpperCaseTextField(),
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                      validator: (value) => dataDiri1Controller.validatorField('nik'),
                    ),
                    SizedBox(height: 15),
                    Text("Nama Sesuai e-KTP", style: labelText),
                    SizedBox(height: 8),
                    CustomTextFromField(
                      inputFormater: [UpperCaseTextField()],
                      controller: dataDiri1Controller.name,
                      autovalidateMode: dataDiri1Controller.checkErrorCode(
                          "name", dataController.prefs.getString('errorCode')!),
                      validator: (value) => dataDiri1Controller.validatorField("name"),
                    ),
                    SizedBox(height: 15),
                    Text("Tanggal Lahir", style: labelText),
                    SizedBox(height: 8),
                    // CupertinoDatePicker(onDateTimeChanged: onDateTimeChanged),
                    CustomTextFromFieldDate(
                      controller: dataDiri1Controller.date,
                      initialDate: dataDiri1Controller.initialDate,
                      autovalidateMode: dataDiri1Controller.checkErrorCode(
                          "dob", dataController.prefs.getString('errorCode')!),
                      validator: (value) => dataDiri1Controller.validatorField("dob"),
                      hintText: 'DD/MM/YYYY',
                    ),
                    SizedBox(height: 15),
                    Text("Tempat Lahir", style: labelText),
                    SizedBox(height: 8),
                    CustomTextFromField(
                      inputFormater: [UpperCaseTextField()],
                      controller: dataDiri1Controller.birthOfPlace,
                      autovalidateMode: dataDiri1Controller.checkErrorCode(
                          "bop", dataController.prefs.getString('errorCode')!),
                      validator: (value) => dataDiri1Controller.validatorField("birthPlace"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        style: infoStyle,
                        children: [
                          TextSpan(
                            text: "Kode Referral ",
                            style: labelText,
                          ),
                          TextSpan(
                            text: "(opsional)",
                            style: labelText.copyWith(
                              fontSize: 12,
                              color: Color(0xFF8E8E8E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFromField(
                        inputFormater: [UpperCaseTextField()],
                        controller: dataDiri1Controller.referralCode),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
                ),
              ),
            ),
            floatingActionButton: GetBuilder<DataController>(
              builder: (value) {
                return ButtonCostum(
                  width: double.infinity,
                  ontap: !data.validationButton
                      ? null
                      : () {
                          if (data.formKey.currentState!.validate()) {
                            // context.read<CekuserCubit>().ubahState();
                            value.state = Status.Initial;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return PopoutWrapContent(
                                    textTitle: '',
                                    button_radius: 4,
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 16),
                                          Text(
                                            'Pembukaan Tabungan Digital BNI\n hanya berlaku untuk nasabah baru',
                                            textAlign: TextAlign.center,
                                            style: blackRoboto.copyWith(fontSize: 18),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: Text(
                                              'Jika Anda sudah menjadi nasabah BNI, silakan lakukan Aktivasi BNI Mobile Banking (Android atau IOS) dan lakukan penambahan tabungan melalui menu Rekeningku atau kunjungi Kantor Cabang BNI terdekat.',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    buttonText: 'Ok, saya mengerti',
                                    ontap: () async {
                                      Get.back();
                                      await dataDiri1Controller.submit();
                                      // await dataDiri1Controller.checkProgress(context);
                                    },
                                  );
                                });
                          }
                        },
                );
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        );
      }),
    );
  }
}
