import 'package:eform_modul/BusinessLogic/Registrasi/AlamatController.dart';
import 'package:eform_modul/service/preferences-alamat-luar-indonesia.dart';
import 'package:eform_modul/src/components/form-decoration.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/popup.dart';
import 'package:eform_modul/src/models/alamat-luar-indonesia.dart';
import 'package:eform_modul/src/utility/custom_loading.dart';
import 'package:eform_modul/src/views/pekerjaan-page/pekerjaan_screen.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../components/button.dart';
import '../../components/dropdown.dart';
import '../../components/theme_const.dart';
import '../datadiri-page/data-diri-2.dart';

class AlamatLuarIndonesia extends StatefulWidget {
  const AlamatLuarIndonesia({Key? key}) : super(key: key);

  @override
  State<AlamatLuarIndonesia> createState() => _AlamatLuarIndonesiaState();
}

class _AlamatLuarIndonesiaState extends State<AlamatLuarIndonesia> {
  final formGlobalKey = GlobalKey<FormState>();
  AlamatController alamatController = Get.put(AlamatController());

  Widget seperator(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

// Fetch json negara from the json file

  @override
  void initState() {
    super.initState();
    // getCountryCode();
    if (alamatController.prefs == null) {
      alamatController.askPermissionLocation();
      alamatController.getStringValuesSF();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          title: Text("Alamat", style: appBarText),
        ),
        body: data.isLoadingCountry ? const SizedBox() : form(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ButtonCostum(
          margin: const EdgeInsets.only(bottom: 20),
          text: 'Selanjutnya',
          ontap: () {
            if (formGlobalKey.currentState!.validate()) {
              data.saveAlamatLuarIndonesia();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const PekerjaanScreeen()));
            }
          },
        ),
      );
    });
  }

  Widget form() {
    return GetBuilder<AlamatController>(builder: (data) {
      return Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFEDF1F3),
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.45),
          child: Column(
            children: [
              nav_icon(context, 2),
              Container(margin: const EdgeInsets.only(bottom: 10)),
              Center(
                child: SizedBox(
                  width: 80,
                  child: Image.asset('assets/images/simpanan-form-icon.png'),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                child: Form(
                  key: formGlobalKey,
                  child: Container(
                    margin: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
                    child: Column(
                      children: [
                        //TextFormField Alamat tempat tinggal
                        hintTextFormField('Alamat Sesuai KTP'),
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
                                    return 'RT tidak boleh kosong';
                                  } else if (value.length > 3) {
                                    return 'RT maksimal 3 angka';
                                  }
                                  return null;
                                }, true, false),
                              ),
                            ),
                            Expanded(
                              child: textFormField(false, data.rwController, () {}, (value) {
                                if (value!.isEmpty) {
                                  return 'RW tidak boleh kosong';
                                } else if (value.length > 3) {
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
                                    (data.provinsiController.text.toLowerCase()))
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
                                    labelText: 'Kota/Kab',
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
                                    (data.kecamatanController.text.toLowerCase()))
                                .toList();
                            showDialog(
                              context: context,
                              builder: (BuildContext buildContext) {
                                return DropDownFormField(
                                    items: listKodePosFilter,
                                    labelText: 'Kota/Kab',
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
                  child: Column(
                    children: [
                      //TextFormField Alamat Domisili
                      hintTextFormField('Alamat Domisili'),
                      textFormField(false, data.alamatDomisilinController, () {}, (value) {
                        if (value!.isEmpty) {
                          return 'Alamat Domisili tidak boleh kosong';
                        } else if (value.length < 3 || value.length > 100) {
                          return 'Alamat minimal 3 dan maksimal 100 karakter';
                        }
                        return null;
                      }, false, false),
                      //Dropdown Negara
                      hintTextFormField('Negara'),
                      textFormField(true, data.negaraController, () async {
                        final result = await showDialog(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return DropDownFormField(
                                items: data.listNegara,
                                labelText: 'Negara',
                                selectedValue: data.negaraController,
                                data: ('name'),
                                param: "2");
                          },
                        );
                        if (result != null) {
                          debugPrint('Kode Negara ' + result['code']);
                          if (result['code'] != data.codeNegara) {
                            return showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) {
                                return PopUp(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                                        decoration: const BoxDecoration(
                                            color: CustomThemeWidget.orangeButton,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/tanda_seru.png',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      seperator(0.025),
                                      Text(
                                        'Mohon Maaf',
                                        style: blackRoboto.copyWith(fontSize: 18),
                                      ),
                                      seperator(0.025),
                                      const Text(
                                        'Pastikan lokasi Anda sesuai',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      seperator(0.05),
                                      ButtonCostum(
                                        width: MediaQuery.of(context).size.width - 120,
                                        ontap: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: 'OK, Saya Mengerti',
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }
                      }, (value) {
                        if (value!.isEmpty) {
                          return 'Pilih Negara';
                        }
                        return null;
                      }, false, true),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  Widget floatingActionButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(bottom: 5, top: 10),
      child: FloatingActionButton.extended(
        backgroundColor: const Color(0XFFD45D26),
        onPressed: () {
          if (formGlobalKey.currentState!.validate()) {
            // TODO submit
          }
        },
        label: const Text("Selanjutnya"),
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
