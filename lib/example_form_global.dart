import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/custom_body.dart';
import 'package:eform_modul/src/components/form-decoration.dart';
import 'package:eform_modul/src/components/leading.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'src/views/syarat-dan-ketentuan/syarat-dan-ketentuan.dart';

class ExampleFormGlobalWidgets extends StatefulWidget {
  ExampleFormGlobalWidgets({Key? key}) : super(key: key);

  @override
  State<ExampleFormGlobalWidgets> createState() => _ExampleFormGlobalWidgetsState();
}

class _ExampleFormGlobalWidgetsState extends State<ExampleFormGlobalWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromRGBO(51, 51, 51, 1)),
        backgroundColor: CustomThemeWidget.backgroundColorTop,
        title: Text(
          "Example Form Global",
          style: appBarText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: LeadingIcon(
            context: context,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SyaratDanKetentuanPage(),
                ),
              );
            }),
      ),
      body: CustomBodyWidgets(
        content: Container(
          width: double.infinity,
          height: 400,
          color: Colors.amber,
        ),
        pathHeaderIcons: "assets/images/icons/card_icon.svg",
        headerTextStep: 'Langkah 5 dari 5',
        headerTextDetail: Text("ini bisa pake text biasa atau textspan buat text campuran"),
      ),
      floatingActionButton: ButtonCostum(
        width: double.infinity,
        ontap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
