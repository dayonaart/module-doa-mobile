import 'package:eform_modul/src/components/button.dart';
import 'package:eform_modul/src/components/form-decoration.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/views/register/work/work_detail/textform_custom.dart';
import 'package:flutter/material.dart';

class MobileBankingRegisterScreen extends StatelessWidget {
  MobileBankingRegisterScreen({Key? key}) : super(key: key);

  TextEditingController userIDMBankingText = TextEditingController();
  final mbankingFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0xfff1f1f1),
        title: Center(child: Text("Mobile Banking", style: appBarText)),
      ),
      floatingActionButton: ButtonCostum(
        ontap: () {},
        width: 400,
        text: "Selanjutnya",
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/simpanan-bg-2.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 2; i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          width: i == 1 ? 20 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: i <= 1 ? const Color(0xffF15A23) : Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 100,
                height: 100,
                child: Image(image: AssetImage("assets/images/simpanan-form-icon.png")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User ID Mobile Banking",
                          style: blackRoboto.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextFormCustom(
                          keyFormField: const ObjectKey('6'),
                          textController: userIDMBankingText,
                          minimalChar: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
