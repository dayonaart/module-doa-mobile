import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataDiri1Controller.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataDiri2Controller.dart';
import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/custom_dropdown_search.dart';
import 'package:eform_modul/src/components/custom_textfromfield.dart';
import 'package:eform_modul/src/components/label-text.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:eform_modul/src/views/datadiri-page/data-diri-1.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataDiri2 extends StatefulWidget {
  const DataDiri2({Key? key}) : super(key: key);

  @override
  State<DataDiri2> createState() => _DataDiri2State();
}

class _DataDiri2State extends State<DataDiri2> {
  DataDiri2Controller dataDiri2Controller = Get.put(DataDiri2Controller());
  DataController dataController = Get.find<DataController>();

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    dataDiri2Controller.getStringValuesSF();
  }

  Widget overseasField() {
    return GetBuilder<DataDiri2Controller>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Negara Domisili Saat Ini'),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomDropDownWidgets(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: dataDiri2Controller.countryController,
                validator: (val) => dataDiri2Controller.validatorFormField(val, "country"),
                onTap: () async => await dataDiri2Controller.dropDownOntap("country", context),
                label: 'Negara'),
          ),
          _title('Domisili Saat Ini (Luar Indonesia)'),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomTextFromField(
              controller: dataDiri2Controller.overseasAddressController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) => dataDiri2Controller.validatorFormField(val, "domicile"),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataDiri2Controller>(builder: (_) {
      return WillPopScope(
        onWillPop: () async {
          Get.off(() => DataDiri1(), transition: Transition.rightToLeft);
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
                "Data Diri",
                style: appBarText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: LeadingIcon(
                  context: context,
                  onPressed: () {
                    Get.off(() => DataDiri1(), transition: Transition.rightToLeft);
                  }),
            ),
            body: SingleChildScrollView(
              child: CustomBodyWidgets(
                content: Form(
                  onChanged: _.onchanged(),
                  key: _.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Kota Penerbit Identitas'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          inputFormater: [UpperCaseTextField()],
                          controller: dataDiri2Controller.publisherCityController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => _.validatorFormField(val, "publiserCity"),
                        ),
                      ),
                      _title('Nama Sesuai e-KTP'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          isColorGrey: true,
                          filled: true,
                          inputFormater: [UpperCaseTextField()],
                          readOnly: true,
                          controller: dataDiri2Controller.nameController,
                          // autovalidateMode: _.checkErrorCode("name", _.errorCode),
                          // validator: (val) => _.validatorFormField(val, "name"),
                        ),
                      ),
                      _title('Tanggal Lahir'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          isColorGrey: true,
                          filled: true,
                          readOnly: true,
                          controller: dataDiri2Controller.dobController,
                          // autovalidateMode: _.checkErrorCode("dob", _.errorCode),
                          // validator: (val) =>
                          //     _.validatorFormField(val, "dateOfBirth"),
                        ),
                      ),
                      _title('Tempat Lahir'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          isColorGrey: true,
                          filled: true,
                          readOnly: true,
                          inputFormater: [UpperCaseTextField()],
                          controller: dataDiri2Controller.birthPlaceController,
                          // autovalidateMode: _.checkErrorCode("bop", _.errorCode),
                          // validator: (val) =>
                          //     _.validatorFormField(val, "birthPlace"),
                        ),
                      ),
                      _title('Jenis Kelamin'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomDropDownWidgets(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => _.validatorFormField(val, 'gender'),
                            controller: dataDiri2Controller.genderController,
                            onTap: () async => await _.dropDownOntap("gender", context),
                            label: 'Jenis Kelamin'),
                      ),
                      _title('Agama'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomDropDownWidgets(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => _.validatorFormField(val, 'religion'),
                          controller: dataDiri2Controller.religionController,
                          label: 'Agama',
                          onTap: () async => await _.dropDownOntap("religion", context),
                        ),
                      ),
                      _title('Email'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                            inputFormater: [UpperCaseTextField()],
                            keyboardType: TextInputType.emailAddress,
                            controller: dataDiri2Controller.emailController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => _.validatorFormField(val, "email")),
                      ),
                      _title('Nomor Telepon'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          isColorGrey: true,
                          filled: true,
                          controller: dataDiri2Controller.phoneNumberController,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: RichText(
                          text: TextSpan(style: labelText, children: [
                            TextSpan(text: 'Nomor Telepon Rumah '),
                            TextSpan(
                              text: '(opsional)',
                              style: medium12,
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: CustomTextFromField(
                                  // inputFormater: [
                                  //   FilteringTextInputFormatter.digitsOnly,
                                  //   LengthLimitingTextInputFormatter(16),
                                  // ],
                                  keyboardType: TextInputType.number,
                                  controller: dataDiri2Controller.prefixLandlineNumber,
                                  autovalidateMode:
                                      dataDiri2Controller.landlineNumberController.text == ''
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.onUserInteraction,
                                  validator: (val) => _.validatorFormField(val, "landlineCode"),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Expanded(
                                flex: 3,
                                child: CustomTextFromField(
                                  // inputFormater: [
                                  //   FilteringTextInputFormatter.digitsOnly,
                                  //   LengthLimitingTextInputFormatter(16),
                                  // ],
                                  keyboardType: TextInputType.number,
                                  controller: dataDiri2Controller.landlineNumberController,
                                  autovalidateMode:
                                      dataDiri2Controller.prefixLandlineNumber.text == ''
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.onUserInteraction,
                                  validator: (val) => _.validatorFormField(val, "landlineNumber"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: RichText(
                          text: TextSpan(style: labelText, children: [
                            TextSpan(text: 'Nomor NPWP '),
                            TextSpan(
                              text: '(opsional)',
                              style: medium12,
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          // inputFormater: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          //   LengthLimitingTextInputFormatter(16),
                          // ],
                          keyboardType: TextInputType.number,
                          controller: dataDiri2Controller.npwpController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => _.validatorFormField(val, "npwp"),
                        ),
                      ),
                      _title('Status Perkawinan'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomDropDownWidgets(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => _.validatorFormField(val, 'marital'),
                            controller: dataDiri2Controller.maritalStatusController,
                            onTap: () async => await _.dropDownOntap("marital", context),
                            label: 'Status Perkawinan'),
                      ),
                      _title('Nama Ibu Kandung'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          inputFormater: [UpperCaseTextField()],
                          controller: dataDiri2Controller.motherNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => _.validatorFormField(val, "motherName"),
                        ),
                      ),
                      _title('Alamat Tempat Tinggal'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          controller: dataDiri2Controller.addressController,
                          inputFormater: [UpperCaseTextField()],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => _.validatorFormField(val, "address"),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'RT',
                              style: labelText,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Expanded(
                            child: Text(
                              'RW',
                              style: labelText,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: CustomTextFromField(

                                    // inputFormater: [
                                    //   FilteringTextInputFormatter.digitsOnly,
                                    //   LengthLimitingTextInputFormatter(16),
                                    // ],
                                    keyboardType: TextInputType.number,
                                    controller: dataDiri2Controller.neighbourhoodController,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (val) => _.validatorFormField(val, "rt")),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Expanded(
                                child: CustomTextFromField(
                                  // inputFormater: [
                                  //   FilteringTextInputFormatter.digitsOnly,
                                  //   LengthLimitingTextInputFormatter(16),
                                  // ],
                                  keyboardType: TextInputType.number,
                                  controller: dataDiri2Controller.hamletController,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (val) => _.validatorFormField(val, "rw"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Provinsi',
                          style: labelText,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomDropDownWidgets(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => _.validatorFormField(val, 'province'),
                            controller: dataDiri2Controller.provinceController,
                            onTap: () async => await _.dropDownOntap("province", context),
                            label: 'Provinsi'),
                      ),
                      _title('Kota / Kabupaten'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomDropDownWidgets(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => _.validatorFormField(val, 'city'),
                            controller: dataDiri2Controller.cityController,
                            onTap: () async => _.dropDownOntap("city", context),
                            label: 'Kota / Kabupaten'),
                      ),
                      _title('Kecamatan'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomDropDownWidgets(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => _.validatorFormField(val, 'district'),
                            controller: dataDiri2Controller.subDistrictController,
                            onTap: () async => await _.dropDownOntap("district", context),
                            label: 'Kecamatan'),
                      ),
                      _title('Desa / Kelurahan'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFromField(
                          inputFormater: [UpperCaseTextField()],
                          controller: dataDiri2Controller.urbanVillageController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => _.validatorFormField(val, "village"),
                        ),
                      ),
                      _title('Kode Pos'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomDropDownWidgets(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => _.validatorFormField(val, 'postalCode'),
                            controller: dataDiri2Controller.postalCodeController,
                            onTap: () async => await _.dropDownOntap("postalCode", context),
                            label: 'Kecamatan'),
                      ),
                      if (dataDiri2Controller.prefs!.getString('indexPosisi') == '2')
                        overseasField()
                    ],
                  ),
                ),
                pathHeaderIcons: "assets/images/icons/card_icon.svg",
                headerTextStep: 'Langkah 2 dari 6',
                headerTextDetail: RichText(
                  text: TextSpan(
                    style: semibold14,
                    children: [
                      TextSpan(text: 'Pastikan semua data diri ', style: infoStyle),
                      TextSpan(
                        text: 'sudah sesuai dengan e-KTP Anda.',
                        style: semibold14,
                      )
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: ButtonCostum(
              width: double.infinity,
              ontap: !_.validationButton
                  ? null
                  : () {
                      if (_.formKey.currentState!.validate()) dataDiri2Controller.checkProgress();
                    },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        ),
      );
    });
  }

  Padding _title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: labelText,
        textAlign: TextAlign.left,
      ),
    );
  }
}
