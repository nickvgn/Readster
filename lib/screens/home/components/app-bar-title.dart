import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarTitle extends StatefulWidget {
  const AppBarTitle({
    Key key,
  }) : super(key: key);

  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 15),
//      height: 55,
//      width: 150,
      child: TyperAnimatedTextKit(
        isRepeatingAnimation: false,
        textAlign: TextAlign.start,
        speed: Duration(milliseconds: 100),
        alignment: Alignment.centerLeft,
        text: ['Hi, Nick Von'],
        textStyle: Theme.of(context).textTheme.headline6.copyWith(
            color: kLightBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 23),
        onFinished: () {
          setState(() {});
        },
      ),
//      child: Hero(
//        tag: 'Readster',
//        child: NeumorphicText(
//          'Readster',
//          style:
//              kNeumorphicStyle.copyWith(color: kLightBackgroundColor, depth: 2),
//          textStyle: NeumorphicTextStyle(
//            fontSize: 40,
//            fontFamily: GoogleFonts.satisfy().fontFamily,
//          ),
//        ),
//      ),
    );
  }
}
