import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

Widget buildConfirmationButton(String title, context, press,
    {Color color = kPrimaryColor, Color textColor = kLightBackgroundColor}) {
  return SizedBox(
    height: 40,
    width: 130,
    child: NeumorphicButton(
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
      style: kNeumorphicStyle.copyWith(
        color: color,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(25),
        ),
      ),
      onPressed: () {
        if (title == 'Yes' || title == 'Save' || title == 'Finished') {
          press();
        } else {
          Navigator.of(context).pop();
        }
      },
    ),
  );
}
