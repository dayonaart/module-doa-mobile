import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';

import 'button-wrap.dart';
import 'button.dart';

class AlertLocation extends StatefulWidget {
  const AlertLocation({Key? key}) : super(key: key);

  @override
  State<AlertLocation> createState() => _AlertLocationState();
}

class _AlertLocationState extends State<AlertLocation> {
  @override
  Widget build(BuildContext context) {
    Widget seperator(double height) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * height,
      );
    }

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
        insetPadding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: const BoxDecoration(
                    color: CustomThemeWidget.orangeButton, shape: BoxShape.circle),
                child: Center(
                  child: Image.asset(
                    'assets/images/tanda_seru.png',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Mohon Maaf',
                style: blackRoboto.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                'Pastikan lokasi Anda sesuai',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonCustomWrap(
                ontap: () {
                  Navigator.of(context).pop();
                },
                text: 'OK, Saya Mengerti',
                radius: 6,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
