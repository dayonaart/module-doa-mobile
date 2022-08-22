import 'package:eform_modul/BusinessLogic/Registrasi/CreatePinController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/label-text.dart';
import '../../../components/theme_const.dart';

class CreatePinScreen extends StatefulWidget {
  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  var createPinController = Get.put(CreatePinController());
  var otpController = Get.put(OtpController());

  @override
  void initState() {
    super.initState();
    if (createPinController.nik == null) {
      createPinController.getSharedprefData();
    }
  }

  @override
  Widget build(BuildContext context) {
    //getSharedprefData();
    return GetBuilder<CreatePinController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scaffold(
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color.fromRGBO(51, 51, 51, 1)),
              elevation: 0,
              backgroundColor: CustomThemeWidget.backgroundColorTop,
              centerTitle: true,
              title: Text("Buat PIN",
                  overflow: TextOverflow.ellipsis, maxLines: 1, style: appBar_Text),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: ButtonCostum(
              ontap: !(_.pin.text == _.confirmPin.text &&
                      _.pin.text.length == 6 &&
                      _.confirmPin.text.length == 6)
                  ? null
                  : () async {
                      await _.submit();
                    },
              text: "Selanjutnya",
            ),
            body: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(
                      height: 24,
                    ),
                    SvgPicture.asset('assets/images/icons/create_pin_icon.svg'),
                    SizedBox(
                      height: 16,
                    ),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: infoStyle,
                        children: [
                          TextSpan(
                              text: "Buat 6 digit PIN Kartu Debit\n",
                              style: labelText.copyWith(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  "PIN akan digunakan untuk melakukan aktivasi pada BNI Mobile Banking. Masukkan 6 angka yang dapat Anda ingat dan jangan bagikan PIN ini ke siapapun.",
                              style: labelText.copyWith(fontWeight: FontWeight.w400, fontSize: 12))
                        ],
                      ),
                    ),
                    Form(
                        key: _.formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24, right: 24),
                              child: PinCodeTextField(
                                onChanged: (value) {
                                  // _.newInput = value;
                                  print('test' + value);
                                  print(_.pin.text);
                                },
                                validator: (value) => _.validation(value!),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                obscuringCharacter: '*',
                                controller: _.pin,
                                obscureText: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                ],
                                keyboardType: TextInputType.phone,
                                pinTheme: PinTheme(
                                    selectedColor: CustomThemeWidget.orangeButton,
                                    activeColor: Color(0xffE7E7E7),
                                    fieldWidth: 30,
                                    inactiveColor: Color(0xffE7E7E7)),
                                appContext: context,
                                length: 6,
                              ),
                            ),
                            SizedBox(
                              height: 56,
                            ),
                            RichText(
                              text: TextSpan(
                                style: infoStyle,
                                children: [
                                  TextSpan(
                                      text: "Konfirmasi PIN Baru Anda.\n",
                                      style: labelText.copyWith(fontWeight: FontWeight.w600)),
                                  TextSpan(
                                    text: "Pastikan PIN sama dengan PIN yang Anda buat diatas.",
                                    style: labelText.copyWith(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24, right: 24),
                              child: PinCodeTextField(
                                controller: _.confirmPin,
                                onChanged: (value) {
                                  print('test' + value);
                                  print(_.confirmPin.text);
                                },
                                validator: (value) => _.validation(value!),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                obscuringCharacter: '*',
                                obscureText: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                ],
                                keyboardType: TextInputType.phone,
                                pinTheme: PinTheme(
                                    selectedColor: CustomThemeWidget.orangeButton,
                                    activeColor: Color(0xffE7E7E7),
                                    fieldWidth: 30,
                                    inactiveColor: Color(0xffE7E7E7)),
                                appContext: context,
                                length: 6,
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            )
                          ],
                        )),
                  ]),
                )
              ]),
            ),
          ),
        ),
      );
    });
  }
}
