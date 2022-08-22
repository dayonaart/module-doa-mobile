import 'package:eform_modul/BusinessLogic/Registrasi/AcknowledgementController.dart';
import 'package:eform_modul/BusinessLogic/Registrasi/CreatePinController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Coba'),
        onPressed: () {
          Get.find<CreatePinController>().testEmail();
        },
      ),
    );
  }
}
