import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatefulWidget {
  @override
  _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  bool _selected = false;

  bool available = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ChoiceChip(
        label: Text('56'),
        selected: _selected,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: available ? Color(0xffc99a48) : Color(0xffebebeb))),
        selectedColor: Color(0xffab7c39),
        labelStyle: TextStyle(
          fontFamily: 'HelveticaNeueLTArabic',
          color: available ? Color(0xff363636) : Color(0xff969696),
          decoration:
              available ? TextDecoration.none : TextDecoration.lineThrough,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ),
        onSelected: (value) => setState(() {
          _selected = value;
          available = !available;
        }),
        backgroundColor: available ? Colors.white12 : Color(0xffebebeb),
      ),
    );
  }
}
