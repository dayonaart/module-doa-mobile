// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class DropDownFormField extends StatefulWidget {
  List items;
  String labelText;
  TextEditingController selectedValue;
  String? data;
  String param;

  DropDownFormField(
      {required this.items,
      required this.labelText,
      required this.selectedValue,
      this.data,
      required this.param});

  @override
  State<DropDownFormField> createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(child: Text(widget.labelText)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search.text = value;
                });
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            widget.param == '1'
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return search.text == ''
                            ? GestureDetector(
                                onTap: () {
                                  widget.selectedValue.text =
                                      widget.items[index].desc;
                                  Navigator.pop(context, widget.items[index]);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.items[index].desc),
                                  ),
                                ),
                              )
                            : widget.items[index].desc
                                    .toLowerCase()
                                    .contains(search.text.toLowerCase())
                                ? GestureDetector(
                                    onTap: () {
                                      widget.selectedValue.text =
                                          widget.items[index].desc;
                                      Navigator.pop(
                                          context, widget.items[index]);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(widget.items[index].desc),
                                      ),
                                    ),
                                  )
                                : Container();
                      },
                      itemCount: widget.items.length,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return search.text == ''
                            ? GestureDetector(
                                onTap: () {
                                  widget.selectedValue.text =
                                      widget.items[index][widget.data];
                                  Navigator.pop(context, widget.items[index]);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text(widget.items[index][widget.data]),
                                  ),
                                ),
                              )
                            : widget.items[index][widget.data]
                                    .toLowerCase()
                                    .contains(search.text.toLowerCase())
                                ? GestureDetector(
                                    onTap: () {
                                      widget.selectedValue.text =
                                          widget.items[index][widget.data];
                                      Navigator.pop(
                                          context, widget.items[index]);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            widget.items[index][widget.data]),
                                      ),
                                    ),
                                  )
                                : Container();
                      },
                      itemCount: widget.items.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
