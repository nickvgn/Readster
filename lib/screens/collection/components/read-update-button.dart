import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

class ReadUpdateButton extends StatelessWidget {
  const ReadUpdateButton({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: kNeumorphicStyle.copyWith(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
      child: Text(
        title,
        style: Theme.of(context).textTheme.caption.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      onPressed: press,
    );
  }
}
