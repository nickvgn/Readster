import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 150,
      child: Hero(
        tag: 'Readster',
        child: NeumorphicText(
          'Readster',
          style:
              kNeumorphicStyle.copyWith(color: kLightBackgroundColor, depth: 2),
          textStyle: NeumorphicTextStyle(
            fontSize: 40,
            fontFamily: GoogleFonts.satisfy().fontFamily,
          ),
        ),
      ),
    );
  }
}
