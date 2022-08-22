import 'package:eform_modul/src/components/custom_intl_phone/models_intl/custom%20_country_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BusinessLogic/Registrasi/RegistrasiNomorController.dart';

class CustomIntlDialog extends StatefulWidget {
  const CustomIntlDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomIntlDialog> createState() => _CustomIntlDialogState();
}

class _CustomIntlDialogState extends State<CustomIntlDialog> {
  RegistrasiNomorController registrasiNomorController = Get.put(RegistrasiNomorController());

  CustomCountryController? country;

  @override
  void initState() {
    registrasiNomorController.loadCountryJson();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrasiNomorController>(builder: (data) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('Pilih Negara')),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  data.search.text = value;
                  List tempDataList = [];
                  tempDataList.addAll(data.nameSearch);
                  if (value.isNotEmpty) {
                    List tempData = [];
                    tempDataList.forEach((element) {
                      if (element.contains(value)) {
                        tempData.add(
                            tempDataList.indexWhere((indexElement) => indexElement == element));
                      }
                    });
                    data.indexResult = [];
                    data.indexResult.addAll(tempData);
                    data.update();
                    return;
                  } else {
                    print("im here too");
                    data.indexResult = [];
                    data.update();
                    data.indexResult.addAll(data.nameCountry);
                    data.update();
                  }
                },
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        data.search.text == '' ? data.object.length : data.indexResult.length,
                    itemBuilder: (context, index) {
                      return data.search.text == '' || data.search.text.isEmpty
                          ? GestureDetector(
                              onTap: (() {
                                data.defaultSaveCountry(index);
                                setState(() {});
                                Navigator.pop(context);
                              }),
                              child: Card(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                          data.flagUrl[index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Color(0xffBABABA))),
                                    ),
                                  ),
                                  Flexible(child: Text(data.nameCountry[index])),
                                  // Flexible(child: Text(data.dialCode[index]))
                                ],
                              )),
                            )
                          : data.nameSearch.contains(data.search.text)
                              ? GestureDetector(
                                  onTap: () {
                                    data.saveCountry(index);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                      child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(
                                              data.flagUrl[data.indexResult[index]],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Color(0xffBABABA))),
                                        ),
                                      ),
                                      Flexible(
                                          child: Text(data.nameCountry[data.indexResult[index]])),
                                      // Flexible(child: Text(data.dialCode[index]))
                                    ],
                                  )),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    data.saveCountry(index);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                      child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(
                                              data.flagUrl[data.indexResult[index]],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Color(0xffBABABA))),
                                        ),
                                      ),
                                      Flexible(
                                          child: Text(data.nameCountry[data.indexResult[index]])),
                                      // Flexible(child: Text(data.dialCode[index]))
                                    ],
                                  )),
                                );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
