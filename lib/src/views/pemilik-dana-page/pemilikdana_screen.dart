import 'package:eform_modul/BusinessLogic/Registrasi/PemilikDanaController.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/custom_dropdown_search.dart';
import 'package:eform_modul/src/components/custom_textfromfield.dart';
import 'package:eform_modul/src/components/dropdown.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/models/pemilik-dana-model.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/pekerjaan-page/pekerjaan_screen.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:flutter/material.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:get/get.dart';

class PemilikDanaScreeen extends StatefulWidget {
  const PemilikDanaScreeen({Key? key}) : super(key: key);

  @override
  _PemilikDanaScreenState createState() => _PemilikDanaScreenState();
}

final regexWord = RegExp(r'^[a-zA-Z]+$'); //Check Just Word ex: Samuel
final regexWordSymbol =
    RegExp(r'^[a-zA-Z]+$'); //Check Just Word and symbol - , . /).  ex: Jln. Atok Dalang
final regexNumber = RegExp(r'^[0-9]*$');

class _PemilikDanaScreenState extends State<PemilikDanaScreeen> {
  PemilikDanaController pemilikDanaController = Get.put(PemilikDanaController());

  @override
  void initState() {
    pemilikDanaController.getStringValuesToSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PemilikDanaController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            Get.off(() => PekerjaanScreeen(), transition: Transition.rightToLeft);
            return true;
          },
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
                title: Text("Pemilik Dana", style: appBarText),
              ),
              body: CustomBodyWidgets(
                headerMarginBottom: 0,
                headerTextStep: "Langkah 4 dari 6",
                pathHeaderIcons: "assets/images/icons/book_icon.svg",
                isWithIconHeader: true,
                content: Form(
                  onChanged: _.onchanged(),
                  key: _.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      Text("Hubungan Pemberi Dana", style: bodyStyle),
                      SizedBox(
                        height: 8,
                      ),
                      CustomDropDownWidgets(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          _.validator("relationship", value!);
                        },
                        controller: _.patronRelationship,
                        label: "Hubungan Pemberi Dana",
                        onTap: () {
                          _.dropDownOnTap("relationship", context);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Nama Pemilik Dana", style: bodyStyle),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextFromField(
                        inputFormater: [UpperCaseTextField()],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _.patronName,
                        validator: (value) {
                          _.validator("name", value!);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Alamat Pemilik Dana", style: bodyStyle),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextFromField(
                        inputFormater: [UpperCaseTextField()],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _.patronAddress,
                        validator: (value) {
                          _.validator("address", value!);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text("No. Telepon Pemilik Dana", style: bodyStyle),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextFromField(
                        inputFormater: [UpperCaseTextField()],
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _.patronPhoneNumber,
                        validator: (value) {
                          _.validator("phoneNumber", value!);
                        },
                      ),
                    ],
                  ),
                ),
                headerTextDetail:
                    Text("Lengkapi detail informasi mengenai sumber dana Anda.", style: infoStyle),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: ButtonCostum(
                margin: const EdgeInsets.only(bottom: 20),
                text: 'Selanjutnya',
                ontap: !_.validationButton
                    ? null
                    : () async {
                        if (_.formKey.currentState!.validate()) {
                          _.addStringToSF();
                          _.navigatorPage();
                        }
                      },
              ),
            ),
          ),
        );
      },
    );
  }
}
