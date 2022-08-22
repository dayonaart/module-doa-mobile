import 'package:eform_modul/BusinessLogic/Registrasi/RegistrasiNomorController.dart';
import 'package:eform_modul/src/components/custom_intl_phone/custom_intl_dialog.dart';
import 'package:eform_modul/src/components/custom_intl_phone/models_intl/custom%20_country_controller.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/views/registrasi/register_nomor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../custom_textfromfield.dart';

class CustomIntlCountry extends StatefulWidget {
  final TextEditingController dialNumberController;
  final TextEditingController bodyNumberController;
  final String pathUrlFlag;
  final String countryName;

  const CustomIntlCountry({
    Key? key,
    required this.dialNumberController,
    required this.bodyNumberController,
    required this.pathUrlFlag,
    this.countryName = 'negara luar',
  }) : super(key: key);

  @override
  State<CustomIntlCountry> createState() => _CustomIntlCountryState();
}

class _CustomIntlCountryState extends State<CustomIntlCountry> {
  RegistrasiNomorController numberRegisterController = Get.put(RegistrasiNomorController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrasiNomorController>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: InkWell(
              onTap: (() {
                showDialog(context: context, builder: (_) => CustomIntlDialog());
              }),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.pathUrlFlag,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.countryName,
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
            ),
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
                      readOnly: true,
                      isColorGrey: true,
                      borderColor: Theme.of(context).scaffoldBackgroundColor,
                      controller: widget.dialNumberController),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: CustomTextFromField(
                      onChanged: (val) {
                        _.onchanged(_.formKey.currentState!.validate());
                      },
                      inputFormater: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ((value) {
                        if (value!.length < 8) {
                          return "nomor tidak boleh kurang dari 8";
                        }
                        if (value.length > 16) {
                          return "nomor tidak boleh lebih dari 13";
                        }
                        return null;
                      }),
                      keyboardType: TextInputType.phone,
                      // borderColor: Theme.of(context)
                      //     .scaffoldBackgroundColor,
                      controller: widget.bodyNumberController))
            ],
          )
        ],
      );
    });
  }
}
