import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

class ReadStatusRadio extends StatelessWidget {
  const ReadStatusRadio({
    Key key,
    this.onChanged,
    this.readStatus,
  }) : super(key: key);

  final Function onChanged;
  final String readStatus;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: kNeumorphicStyle.copyWith(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeumorphicRadio(
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.rect(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              child: Text(
                TOREAD,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        readStatus == TOREAD ? kPrimaryColor : kDarkTextColor),
              ),
            ),
            value: TOREAD,
            groupValue: readStatus,
            onChanged: (value) {
              onChanged(value);
            },
          ),
          NeumorphicRadio(
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.rect(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              child: Text(
                READING,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        readStatus == READING ? kPrimaryColor : kDarkTextColor),
              ),
            ),
            value: READING,
            groupValue: readStatus,
            onChanged: (value) {
              onChanged(value);
            },
          ),
          NeumorphicRadio(
            style: NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.rect(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              child: Text(
                READ,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: readStatus == READ ? kPrimaryColor : kDarkTextColor),
              ),
            ),
            value: READ,
            groupValue: readStatus,
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
