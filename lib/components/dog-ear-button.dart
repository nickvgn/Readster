import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

class DogEarButton extends StatelessWidget {
  const DogEarButton({
    Key key,
    this.icon,
    this.press,
    this.title,
  }) : super(key: key);

  final IconData icon;
  final Function press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: 190,
        child: NeumorphicButton(
          style: kNeumorphicStyle.copyWith(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(25),
            ),
          ),
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
