import 'package:eform_modul/src/views/register/register_card_type/card_description.dart';
import 'package:flutter/material.dart';

class AlphabhetList extends StatelessWidget {
  AlphabhetList(this.texts, {Key? key}) : super(key: key);
  final List<String> texts;
  List alphabhet = ['a', 'b', 'c', 'd', 'e'];
  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      widgetList.add(UnorderedListItem(text));

      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(
    this.text, {
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("• "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
