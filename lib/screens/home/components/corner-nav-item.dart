import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

class CornerNavItem extends StatelessWidget {
  final Widget icon;
  final bool isLeft;
  final Function press;

  const CornerNavItem({
    Key key,
    this.isLeft,
    this.press,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width * .17,
      child: NeumorphicButton(
        onPressed: press,
        child: icon,
        style: kNeumorphicStyle.copyWith(
          boxShape: NeumorphicBoxShape.roundRect(
            isLeft
                ? BorderRadius.only(
                    topRight: Radius.circular(20),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
          ),
        ),
//        color: kSecondaryColor,
      ),
    );
  }
}
