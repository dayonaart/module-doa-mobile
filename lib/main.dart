//import 'package:eform_modul/src/views/home-page/tes.dart';
import 'dart:convert';
import 'dart:math';

import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/PekerjaanController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/CabangController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/CreatePinController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataFileController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/DataDiri2Controller.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/PemilikDanaController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/PhoneVerifyController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/RegistrasiNomorController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/WorkDetailController.dart';
import 'package:eform_modul/service/services.dart';
import 'package:eform_modul/src/components/testing.dart';
import 'package:eform_modul/src/components/url-api.dart';
import 'package:eform_modul/src/utility/Routes.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'BusinessLogic/Registrasi/AcknowledgementController.dart';
import 'BusinessLogic/Registrasi/AlamatController.dart';
import 'BusinessLogic/Registrasi/CreateMbankController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(DataController());
  Get.put(CabangController());
  Get.put(OtpController());
  Get.put(AcknowledgementController());
  Get.put(CreatePinController());
  Get.put(PhoneVerifyController());
  Get.put(CreateMbankController());
  Get.put(RegistrasiNomorController());
  Get.put(DataFileController());
  Get.put(PerkerjaanController());
  Get.put(PemilikDanaController());
  Get.put(WorkDetailController());
  Get.put(DataDiri2Controller());
  Get.put(AlamatController());
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      defaultTransition: Transition.leftToRight,
      title: 'Digital Opening Account',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Testing(),
      initialRoute: "/splashScreen",
      getPages: Routes().listPage,
    );
  }
}

String get rootBundleCostum {
  return 'packages/eform_modul/';
}
