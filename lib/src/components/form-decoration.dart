import 'package:flutter/material.dart';
import 'package:eform_modul/src/components/theme_const.dart';
import 'package:eform_modul/src/components/dropdown.dart';

Widget FormCustom(BuildContext context, Widget content, int param) {
  return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFFEDF1F3),
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.65),
        child: Column(
          children: [
            nav_icon(context, param),
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
                    )),
                child: content),
          ],
        ),
      ));
}

Widget inputTextFieldTemplate(BuildContext context, String label,
    TextEditingController textEditingController, String? Function(String? value) validator) {
  return Container(
    margin: EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            label,
            style: blackRoboto.copyWith(
              color: Color.fromRGBO(44, 44, 51, 1),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            style: blackRoboto.copyWith(
              fontWeight: FontWeight.normal,
            ),
            decoration: const InputDecoration(
                errorMaxLines: 3,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(206, 2012, 2018, 1)))),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: textEditingController,
          ),
        ),
      ],
    ),
  );
}

Widget dropDown_template(BuildContext context, String label,
    TextEditingController textEditingController, List dropdownItemList) {
  bool isValid = true;
  return Container(
    margin: EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            label,
            style: blackRoboto.copyWith(
              color: Color.fromRGBO(44, 44, 51, 1),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return label + ' tidak boleh kosong';
              }
              return null;
            },
            controller: textEditingController,
            readOnly: true,
            style: blackRoboto.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
            decoration: const InputDecoration(
                suffixIcon: Icon(
                  // Add this
                  Icons.arrow_drop_down, // Add this
                  color: Color.fromRGBO(153, 153, 153, 1), // Add this
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(206, 2012, 2018, 1)))),
            onTap: () async {
              final result = await showDialog(
                context: context,
                builder: (BuildContext context) => DropDownFormField(
                  items: dropdownItemList,
                  labelText: label,
                  selectedValue: textEditingController,
                  param: '1',
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget nav_icon(BuildContext context, int param) {
  return Padding(
    padding: const EdgeInsets.only(top: 3.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 9; i++)
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              width: i == param ? 20 : 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: i <= param ? const Color(0xffF15A23) : Colors.grey,
              ),
            ),
          ),
      ],
    ),
  );
}

@override
Widget pegawai_list(BuildContext context) {
  return Container(
    child: DropdownButtonFormField<String>(
      hint: Text(''),
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(206, 2012, 2018, 1)))),
      icon: Icon(
        // Add this
        Icons.arrow_drop_down, // Add this
        color: Color.fromRGBO(153, 153, 153, 1), // Add this
      ),
      items: <String>['A', 'B', 'C', 'D'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    ),
  );
}
