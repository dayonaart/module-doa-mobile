import 'package:eform_modul/BusinessLogic/Registrasi/PekerjaanController.dart';
import 'package:eform_modul/src/components/custom_textfromfield.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/datadiri-page/data-diri-2.dart';
import 'package:flutter/material.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:get/get.dart';
import '../../components/custom_body.dart';
import '../../components/custom_dropdown_search.dart';

class PekerjaanScreeen extends StatefulWidget {
  const PekerjaanScreeen({Key? key}) : super(key: key);

  @override
  _PekerjaanScreenState createState() => _PekerjaanScreenState();
}

class _PekerjaanScreenState extends State<PekerjaanScreeen> {
  PerkerjaanController jobController = Get.put(PerkerjaanController());

  @override
  void initState() {
    // TODO: implement initState
    if (jobController.prefs == null) jobController.getStringValuesSF();
    super.initState();
  }

  Widget sumberDanaLainnya() {
    return GetBuilder<PerkerjaanController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sumber Dana Lainnya", style: labelText),
          SizedBox(height: 8),
          CustomTextFromField(
            onChanged: (val) {
              _.onchanged();
              return;
            },
            controller: _.otherSources,
            validator: (val) => _.validation(val!),
            autovalidateMode: AutovalidateMode.always,
          ),
          SizedBox(
            height: 15,
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerkerjaanController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            Get.off(() => DataDiri2(), transition: Transition.rightToLeft);
            return true;
          },
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Scaffold(
              appBar: AppBar(
                leading: LeadingIcon(
                  context: context,
                  onPressed: () async {
                    Get.off(() => DataDiri2(), transition: Transition.rightToLeft);
                  },
                ),
                elevation: 0,
                backgroundColor: CustomThemeWidget.backgroundColorTop,
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: true,
                title: Text("Data Pekerjaan", style: appBarText),
              ),
              body: CustomBodyWidgets(
                pathHeaderIcons: "assets/images/icons/person_icon.svg",
                headerTextStep: 'Langkah 3 dari 6',
                headerTextDetail: Text(
                  "Lengkapi detail informasi mengenai pekerjaan dan tempat bekerja Anda.",
                  style: infoStyle,
                ),
                content: Form(
                    onChanged: _.onchanged(),
                    key: _.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pekerjaan", style: labelText),
                        SizedBox(height: 8),
                        CustomDropDownWidgets(
                          controller: _.job,
                          label: '',
                          validator: (value) => _.dropDownOnChange(value, "job"),
                          onTap: () async => await _.onTap('job', context),
                        ),
                        SizedBox(height: 15),
                        Text("Penghasilan Perbulan", style: labelText),
                        SizedBox(height: 8),
                        CustomDropDownWidgets(
                          controller: _.income,
                          label: '',
                          validator: (value) => _.dropDownOnChange(value, "salary"),
                          onTap: () async => await _.onTap("salary", context),
                        ),
                        SizedBox(height: 15),
                        Text("Sumber Dana", style: labelText),
                        SizedBox(height: 8),
                        CustomDropDownWidgets(
                          controller: _.sourceOfFund,
                          label: 'Pilih Posisi',
                          validator: (value) => _.dropDownOnChange(value, "sourceFund"),
                          onTap: () async => await _.onTap("sourceFund", context),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (_.sourceOfFund.text == "LAINNYA") sumberDanaLainnya(),
                        RichText(
                          text: TextSpan(
                            style: infoStyle,
                            children: [
                              TextSpan(
                                text: "Perkiraan Nilai Transaksi ",
                                style: labelText,
                              ),
                              TextSpan(
                                  text: "(per tahun)",
                                  style:
                                      labelText.copyWith(fontSize: 12, color: Color(0xFF8E8E8E))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomDropDownWidgets(
                          controller: _.transactionEstimation,
                          label: '',
                          validator: (value) => _.dropDownOnChange(value, "estimatedTransaction"),
                          onTap: () async => await _.onTap("estimatedTransaction", context),
                        ),
                        SizedBox(height: 15),
                        Text("Tujuan Pembukaan Rekening", style: labelText),
                        SizedBox(height: 8),
                        CustomDropDownWidgets(
                          controller: _.openAccReason,
                          label: 'Pilih Posisi',
                          validator: (value) => _.dropDownOnChange(value, "destinationTransaction"),
                          onTap: () async => _.onTap("destinationTransaction", context),
                        ),
                        SizedBox(height: 100),
                      ],
                    )),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: ButtonCostum(
                margin: const EdgeInsets.only(bottom: 20),
                text: 'Lanjut',
                ontap: !_.validationButton
                    ? null
                    : () async => await _.submit(_.formKey.currentState!.validate()),
              ),
            ),
          ),
        );
      },
    );
  }
}
