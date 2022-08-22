import 'package:eform_modul/BusinessLogic/Registrasi/CabangController.dart';
import 'package:eform_modul/src/components/button-wrap.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/custom_dropdown_search.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/models/kantorCabang_model.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/data-file/data-file-list.dart';
import 'package:eform_modul/src/views/pemilik-dana-page/pemilikdana_screen.dart';
import 'package:eform_modul/src/views/register/work/work_detail/work_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../BusinessLogic/Registrasi/DataController.dart';
import '../../components/dropdown.dart';
import '../../components/form-decoration.dart';

class PemilihanCabangIndonesiaPage extends StatefulWidget {
  @override
  State<PemilihanCabangIndonesiaPage> createState() => _PemilihanCabangIndonesiaPageState();
}

class _PemilihanCabangIndonesiaPageState extends State<PemilihanCabangIndonesiaPage> {
  CabangController cabangController = Get.put(CabangController());

  @override
  void initState() {
    super.initState();
    cabangController.getStringValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    Widget indicator() {
      return Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, defaultMargin, defaultMargin, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                SizedBox(
                  width: 48,
                  child: Image.asset('assets/images/form_logo.png'),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Langkah 4 dari 5",
                  style: semibold14,
                ),
              ]),
              SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(style: infoStyle, children: [
                  TextSpan(
                    text: "Anda dapat mengambil",
                  ),
                  TextSpan(text: " kartu debit fisik dan/atau buku tabungan", style: semibold14),
                  TextSpan(text: "  pada kantor cabang BNI terdekat."),
                ]),
              )
            ],
          ));
    }

    Widget hintTextFormField(String hintText) {
      return Container(
        alignment: Alignment.topLeft,
        child: Text(
          hintText,
          style: labelText,
        ),
      );
    }

    // Widget info() {
    //   return Container(
    //       margin: EdgeInsets.only(top: 0, right: 20, left: 20),
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //               blurRadius: 4,
    //               color: Colors.black.withOpacity(0.1),
    //               spreadRadius: 1,
    //               offset: Offset(0, 8),
    //             ),
    //           ]),
    //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text(
    //             'Info',
    //             style: blackRoboto.copyWith(
    //                 fontWeight: FontWeight.bold, fontSize: 20),
    //           ),
    //           SizedBox(
    //             height: 8,
    //           ),
    //           Divider(
    //             thickness: 1,
    //             color: Colors.grey,
    //           ),
    //           SizedBox(
    //             height: 8,
    //           ),
    //           Text(
    //             'Anda dapat mengambil kartu debit fisik dan/atau buku tabungan pada kantor cabang BNI terdekat yang Anda pilih',
    //             textAlign: TextAlign.center,
    //             style: blackRoboto.copyWith(
    //               fontWeight: FontWeight.normal,
    //             ),
    //           ),
    //         ],
    //       ));
    // }

    return WillPopScope(
      onWillPop: () async {
        final prefs = Get.put(DataController()).prefs;
        if (prefs.getString('detailPekerjaan') == '') {
          Get.off(() => PemilikDanaScreeen(), transition: Transition.rightToLeft);
        } else {
          Get.off(() => WorkDetailScreen(), transition: Transition.rightToLeft);
        }
        return true;
      },
      child: GetBuilder<CabangController>(builder: (data) {
        return MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: LeadingIcon(
                context: context,
                onPressed: () async {
                  final prefs = Get.find<DataController>().prefs;
                  if (prefs.getString('detailPekerjaan') == '') {
                    Get.off(() => PemilikDanaScreeen(), transition: Transition.rightToLeft);
                  } else {
                    Get.off(() => WorkDetailScreen(), transition: Transition.rightToLeft);
                  }
                },
              ),
              elevation: 1,
              backgroundColor: CustomThemeWidget.backgroundColorTop,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              title: Text("Pemilihan Cabang BNI", style: appBar_Text),
            ),
            body: CustomBodyWidgets(
              headerMarginBottom: 32,
              headerTextStep: "Langkah 5 dari 6",
              pathHeaderIcons: "assets/images/icons/book_icon.svg",
              isWithIconHeader: true,
              headerTextDetail: RichText(
                text: TextSpan(style: infoStyle, children: [
                  TextSpan(
                    text: "Anda dapat mengambil",
                  ),
                  TextSpan(text: " kartu debit fisik dan/atau buku tabungan", style: semibold14),
                  TextSpan(text: "  pada kantor cabang BNI terdekat."),
                ]),
              ),
              content: Form(
                onChanged: data.onchanged(),
                key: data.formGlobalKey,
                child: Column(
                  children: [
                    //Dropdown Provinsi
                    hintTextFormField('Provinsi'),
                    SizedBox(
                      height: 8,
                    ),
                    CustomDropDownWidgets(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.province,
                      label: "Provinsi",
                      maxLines: 1,
                      onTap: () async {
                        data.dropDownOntap("province", context);
                      },
                      validator: (value) {
                        return data.validator("province");
                      },
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    //Dropdown Kota/Kab
                    hintTextFormField('Kota/Kab'),
                    SizedBox(
                      height: 8,
                    ),
                    CustomDropDownWidgets(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.city,
                      label: "Kota",
                      maxLines: 1,
                      onTap: () async {
                        data.dropDownOntap("city", context);
                      },
                      validator: (value) {
                        return data.validator("city");
                      },
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    //Dropdown Kota/Kab
                    hintTextFormField('Pilih Kantor Cabang'),
                    SizedBox(
                      height: 8,
                    ),
                    CustomDropDownWidgets(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: data.office,
                      label: "Kota",
                      maxLines: 1,
                      onTap: () async {
                        data.dropDownOntap("office", context);
                      },
                      validator: (value) {
                        return data.validator("office");
                      },
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    //Dropdown Kota/Kab
                    hintTextFormField('Alamat Kantor Cabang Terdekat'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1)),
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(248, 248, 248, 1),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(231, 231, 231, 1)),
                          ),
                          errorStyle: TextStyle(
                            color: Theme.of(context).errorColor, // or any other color
                          ),
                        ),
                        controller: data.address,
                        onTap: () {
                          if (data.office.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Alamat Berhasil Disalin"),
                              duration: Duration(seconds: 1),
                            ));
                            Clipboard.setData(ClipboardData(text: data.office.text.toString()));
                          }
                        },
                        maxLines: 3,
                        readOnly: true,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ButtonCostum(
                radius: 4,
                text: 'Lanjut',
                ontap: !data.validationButton
                    ? null
                    : () {
                        if (data.formGlobalKey.currentState!.validate()) {
                          Get.offNamed(Routes().datafile);
                        }
                      },
              ),
            ),
          ),
        );
      }),
    );
  }
}
