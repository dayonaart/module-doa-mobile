import 'package:eform_modul/BusinessLogic/Registrasi/AlamatController.dart';
import 'package:eform_modul/service/preferences-alamat-indonesia.dart';
import 'package:eform_modul/src/components/form-decoration.dart';
import 'package:eform_modul/src/components/header-form.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/models/alamat-indonesia.dart';
import 'package:eform_modul/src/views/datadiri-page/data-diri-2.dart';
import 'package:eform_modul/src/views/pekerjaan-page/pekerjaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../components/button.dart';
import '../../components/dropdown.dart';
import '../register/work/work_detail/textform_custom.dart';

class AlamatIndonesia extends StatefulWidget {
  const AlamatIndonesia({Key? key}) : super(key: key);

  @override
  State<AlamatIndonesia> createState() => _AlamatIndonesiaState();
}

class _AlamatIndonesiaState extends State<AlamatIndonesia> {
  final formGlobalKey = GlobalKey<FormState>();
  AlamatController alamatController = Get.put(AlamatController());

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    // loadPrefTextfield();
    if (alamatController.prefs == null) {
      alamatController.getStringValuesSF();
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlamatController>(builder: (data) {
      return Scaffold(
        appBar: AppBar(
          leading: LeadingIcon(
            context: context,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataDiri2(),
                ),
              );
            },
          ),
          elevation: 1,
          backgroundColor: CustomThemeWidget.backgroundColorTop,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text("Alamat Tempat Tinggal", style: appBarText),
        ),
        body: FormCustom(
            context,
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
              child: Column(
                children: [
                  Form(
                    key: formGlobalKey,
                    child: Column(
                      children: [
                        //TextFormField Alamat tempat tinggal
                        hintTextFormField('Alamat Tempat Tinggal Sekarang'),
                        textFormField(false, data.alamatController, () {}, (value) {
                          if (value!.isEmpty) {
                            return 'Alamat tidak boleh kosong';
                          } else if (value.length < 3 || value.length > 100) {
                            return 'Alamat minimal 3 dan maksimal 100 karakter';
                          }
                          return null;
                        }, false, false),
                        //TextFormField RT/RW
                        hintTextFormField('RT/RW'),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: textFormField(false, data.rtController, () {}, (value) {
                                  if (value!.isEmpty) {
                                    // data.update();
                                    return 'RT tidak boleh kosong';
                                  } else if (value.length > 3) {
                                    // data.update();
                                    return 'RT maksimal 3 angka';
                                  }
                                  return null;
                                }, true, false),
                              ),
                            ),
                            Expanded(
                              child: textFormField(false, data.rwController, () {}, (value) {
                                // print("Cek");
                                if (value!.isEmpty) {
                                  // data.update();
                                  return 'RW tidak boleh kosong';
                                } else if (value.length > 3) {
                                  // data.update();
                                  return 'RW maksimal 3 angka';
                                }
                                return null;
                              }, true, false),
                            )
                          ],
                        ),
                        //Dropdown Provinsi
                        hintTextFormField('Provinsi'),
                        textFormField(true, data.provinsiController, () async {
                          String temp = data.provinsiController.text;
                          final result = await showDialog(
                            context: context,
                            builder: (BuildContext buildContext) {
                              return DropDownFormField(
                                  items: data.listProvinsi,
                                  labelText: 'Provinsi',
                                  selectedValue: data.provinsiController,
                                  data: ('provinsi'),
                                  param: "2");
                            },
                          );

                          if (result != null) {
                            if (result['provinsi'] != temp) {
                              data.kotaController.clear();
                              data.kecamatanController.clear();
                              data.kodePosController.clear();
                            }
                          }
                        }, (value) {
                          if (value!.isEmpty) {
                            return 'Pilih Provinsi';
                          }
                          return null;
                        }, false, true),

                        //Dropdown Kota/Kab
                        hintTextFormField('Kota/Kab'),
                        textFormField(true, data.kotaController, () async {
                          if (data.provinsiController.text.isNotEmpty) {
                            //Filter list kota sesuai dengan provinsi yang dipilih
                            String temp = data.kotaController.text;
                            List listkotaFilter = data.listKota
                                .where((x) =>
                                    x['idprovinsi'].toLowerCase() ==
                                    data.provinsiController.text.toLowerCase())
                                .toList();
                            final result = await showDialog(
                              context: context,
                              builder: (BuildContext buildContext) {
                                return DropDownFormField(
                                    items: listkotaFilter,
                                    labelText: 'Kota/Kab',
                                    selectedValue: data.kotaController,
                                    data: ('kota'),
                                    param: "2");
                              },
                            );
                            if (result != null) {
                              if (result['kota'] != temp) {
                                data.kecamatanController.clear();
                                data.kodePosController.clear();
                              }
                            }
                          } else {
                            return;
                          }
                        }, (value) {
                          if (value!.isEmpty) {
                            return 'Pilih Kota/Kab';
                          }
                          return null;
                        }, false, true),

                        //Dropdown Kecamatan
                        hintTextFormField('Kecamatan'),
                        textFormField(true, data.kecamatanController, () async {
                          if (data.kotaController.text.isNotEmpty) {
                            //Filter list kecamatan sesuai dengan kota/kab yang dipilih
                            String temp = data.kecamatanController.text;
                            List listKecamatanFilter = data.listKecamatan
                                .where((x) =>
                                    x['idkota'].toLowerCase() ==
                                    (data.kotaController.text.toLowerCase()))
                                .toList();
                            final result = await showDialog(
                              context: context,
                              builder: (BuildContext buildContext) {
                                return DropDownFormField(
                                    items: listKecamatanFilter,
                                    labelText: 'Kecamatan',
                                    selectedValue: data.kecamatanController,
                                    data: ('kecamatan'),
                                    param: "2");
                              },
                            );
                            if (result != null) {
                              if (result['kecamatan'] != temp) {
                                data.kodePosController.clear();
                              }
                            }
                          }
                        }, (value) {
                          if (value!.isEmpty) {
                            return 'Pilih Kecamatan';
                          }
                          return null;
                        }, false, true),

                        //TextFormField Desa/Kelurahan
                        hintTextFormField('Desa/Kelurahan'),
                        textFormField(false, data.desaKelurahanController, () {}, (value) {
                          if (value!.isEmpty) {
                            return 'Desa/Kelurahan tidak boleh kosong';
                          } else if (value.length < 2 || value.length > 30) {
                            return 'Alamat minimal 2 dan maksimal 30 karakter';
                          }
                          return null;
                        }, false, false),
                        //Dropdown Kode Pos
                        hintTextFormField('Kode Pos'),
                        textFormField(true, data.kodePosController, () {
                          if (data.kecamatanController.text.isNotEmpty) {
                            List listKodePosFilter = data.listKodePos
                                .where((x) =>
                                    x['idkecamatan'].toLowerCase() ==
                                    data.kecamatanController.text.toLowerCase())
                                .toList();
                            showDialog(
                              context: context,
                              builder: (BuildContext buildContext) {
                                return DropDownFormField(
                                    items: listKodePosFilter,
                                    labelText: 'Kode Pos',
                                    selectedValue: data.kodePosController,
                                    data: ('kodepos'),
                                    param: "2");
                              },
                            );
                          }
                        }, (value) {
                          if (value!.isEmpty) {
                            return 'Pilih Kode Pos';
                          }
                          return null;
                        }, false, true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            2),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ButtonCostum(
          margin: const EdgeInsets.only(bottom: 20),
          text: 'Selanjutnya',
          ontap: () {
            print("Cek");
            if (formGlobalKey.currentState!.validate()) {
              data.saveAlamatIndonesia();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PekerjaanScreeen()));
            } else {
              print("Coba");
            }
          },
        ),
      );
    });
  }

  Widget hintTextFormField(String hintText) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      alignment: Alignment.topLeft,
      child: Text(
        hintText,
        style: blackRoboto.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget textFormField(bool dropdown, TextEditingController controller, void Function() onTap,
      String? Function(String? value) validator, bool angka, bool enable) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        inputFormatters: [UpperCaseTextField()],
        decoration: dropdown
            ? const InputDecoration(
                suffixIcon: Icon(
                  // Add this
                  Icons.arrow_drop_down, // Add this
                  color: Color.fromRGBO(153, 153, 153, 1), // Add this
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(206, 2012, 2018, 1),
                  ),
                ),
              )
            : null,
        controller: controller,
        onTap: onTap,
        validator: validator,
        keyboardType: angka ? TextInputType.number : TextInputType.text,
        readOnly: enable,
      ),
    );
  }
}
