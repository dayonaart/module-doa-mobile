import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/custom_dropdown_search.dart';
import 'package:eform_modul/src/components/custom_intl_phone/custom_intl_country.dart';

import 'package:eform_modul/src/components/custom_textfromfield.dart';
import 'package:eform_modul/src/components/dropdown.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/models/posisi_list.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/syarat-dan-ketentuan/syarat-dan-ketentuan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../BusinessLogic/Registrasi/RegistrasiNomorController.dart';
import '../../components/button.dart';
import '../../components/custom_body.dart';
import '../../components/custom_dropdown_search.dart';

class RegisterNomorPageAlt extends StatefulWidget {
  RegisterNomorPageAlt({Key? key}) : super(key: key);

  @override
  State<RegisterNomorPageAlt> createState() => _RegisterNomorPageAltState();
}

class _RegisterNomorPageAltState extends State<RegisterNomorPageAlt> {
  RegistrasiNomorController numberRegisterController = Get.put(RegistrasiNomorController());

  @override
  void initState() {
    if (numberRegisterController.prefs == null) {
      numberRegisterController.loadCountryJson();
      numberRegisterController.warningHasAppeared = false;
      numberRegisterController.askPermissionLocation();
      numberRegisterController.getSharedPref();
    }
    super.initState();
  }

  Widget seperator(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrasiNomorController>(builder: (data) {
      return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: WillPopScope(
            onWillPop: () async {
              Get.off(() => SyaratDanKetentuanPage(), transition: Transition.rightToLeft);
              return true;
            },
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Color.fromRGBO(51, 51, 51, 1)),
                  backgroundColor: CustomThemeWidget.backgroundColorTop,
                  title: Text(
                    "Input Nomor Handphone",
                    style: appBar_Text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  leading: LeadingIcon(
                      context: context,
                      onPressed: () {
                        Get.off(() => SyaratDanKetentuanPage(), transition: Transition.rightToLeft);
                      }),
                ),
                floatingActionButton: ButtonCostum(
                  width: double.infinity,
                  ontap: !data.validationButton
                      ? null
                      : () {
                          if (data.formKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (data.bodyNumberPhone.text.length < 8 ||
                                data.bodyNumberPhone.text.length > 13 ||
                                data.bodyNumberPhone.text.isEmpty) {
                            } else {
                              if (data.positionController.text == "Indonesia") {
                                print(data.bodyNumberPhone.text);
                                numberRegisterController.saveSharedPref();

                                Get.toNamed(Routes().jenisTabunganDalam);
                              }
                              if (data.positionController.text == "Luar Indonesia") {
                                print(data.bodyNumberPhone.text);
                                numberRegisterController.saveSharedPref();

                                Get.toNamed(Routes().jenisTabunganLuar);
                              }
                            }
                          }
                        },
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                body: Form(
                  key: data.formKey,
                  child: CustomBodyWidgets(
                      headerTextDetail: SizedBox(),
                      isWithIconHeader: false,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Posisi Anda saat ini", style: labelText),
                          SizedBox(height: 8),
                          CustomDropDownWidgets(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == "Luar Indonesia" && data.country == "Indonesia") {
                                return "Pastikan lokasi sesuai dengan lokasi Anda saat ini.";
                              } else if (value == "Indonesia" && data.country != "Indonesia") {
                                return "Pastikan lokasi sesuai dengan lokasi Anda saat ini.";
                              }
                              return null;
                            },
                            controller: data.positionController,
                            label: 'Pilih Posisi',
                            onTap: () async {
                              numberRegisterController.result = await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) => DropDownFormField(
                                        param: "1",
                                        items: posisiList,
                                        labelText: 'Pilih Posisi',
                                        selectedValue: data.positionController,
                                      ));
                              data.onchanged(data.formKey.currentState!.validate());
                              data.output = data.result?.id.toString();

                              if (numberRegisterController.result!.id.toString() == "1") {
                                data.dialCodePhoneNumber.text = "+62";
                                // data.update();
                              }

                              if (data.result?.id.toString() == "1") {
                                data.valPosition = "1";
                                data.lockCountry = ['ID'];
                                data.positionController.text = "Indonesia";
                                data.update();
                              } else {
                                data.valPosition = "2";
                                data.lockCountry = null;
                                data.positionController.text = "Luar Indonesia";
                                data.dialCodePhoneNumber.text =
                                    data.dialCode[data.currentSelectedIndex!];
                                data.update();
                              }
                              print(data.positionController);
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          data.positionController.text == "Indonesia"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/bendera/indonesia1.svg",
                                          width: 32,
                                          height: 32,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Indonesia",
                                          style: labelText,
                                        ),
                                        SizedBox(
                                          width: 24,
                                        ),
                                        Transform.rotate(
                                          angle: -90 * math.pi / 180,
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            size: 10,
                                            color: CustomThemeWidget.mainOrange,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Nomor Telepon",
                                      style: labelText,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: 50,
                                            child: CustomTextFromField(
                                                onChanged: (val) {
                                                  data.onchanged(
                                                      data.formKey.currentState!.validate());
                                                },
                                                readOnly: true,
                                                isColorGrey: true,
                                                borderColor:
                                                    Theme.of(context).scaffoldBackgroundColor,
                                                controller: data.dialCodePhoneNumber),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: CustomTextFromField(
                                                onChanged: (val) {
                                                  data.onchanged(
                                                      data.formKey.currentState!.validate());
                                                },
                                                inputFormater: [
                                                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                                ],
                                                autovalidateMode:
                                                    AutovalidateMode.onUserInteraction,
                                                validator: ((value) {
                                                  if (value!.length < 8) {
                                                    return "nomor tidak boleh kurang dari 8";
                                                  }
                                                  if (value.length > 13) {
                                                    return "nomor tidak boleh lebih dari 13";
                                                  }
                                                  return null;
                                                }),
                                                keyboardType: TextInputType.phone,
                                                // borderColor: Theme.of(context)
                                                //     .scaffoldBackgroundColor,
                                                controller: data.bodyNumberPhone))
                                      ],
                                    )
                                  ],
                                )
                              : CustomIntlCountry(
                                  countryName: data.countryName!,
                                  pathUrlFlag: data.pathFlagUrl!,
                                  dialNumberController: data.dialCodePhoneNumber,
                                  bodyNumberController: data.bodyNumberPhone),
                          SizedBox(
                            height: 24,
                          ),
                          RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(children: [
                                TextSpan(
                                    style: labelTextBlue,
                                    text:
                                        "Kami akan melakukan proses verifikasi nomor telepon pada proses pembukaan rekening melalui OTP.\n"),
                              ])),
                          RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(children: [
                                TextSpan(
                                    style: labelTextBlue,
                                    text:
                                        "Pengiriman kode OTP dapat dikirimkan melalui SMS atau WhatsApp. Pastikan "),
                                TextSpan(
                                    text:
                                        "Nomor telepon yang Anda isi dapat menerima SMS dengan memiliki pulsa yang cukup atau terhubung dengan akun WhatsApp. ",
                                    style: labelTextBlueBold),
                              ])),
                          SizedBox(
                            height: 24,
                          ),
                          RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(children: [
                                TextSpan(style: labelTextBlueBold, text: "Jaga kerahasiaan OTP "),
                                TextSpan(
                                    text:
                                        "dengan tidak memberitahu kepada siapapun termasuk kepada Petugas Bank. ",
                                    style: labelTextBlue),
                              ])),
                        ],
                      )),
                ),
              ),
            ),
          ));
    });
  }
}
