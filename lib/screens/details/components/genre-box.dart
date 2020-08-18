import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

class GenreBox extends StatelessWidget {
  const GenreBox({
    Key key,
    this.genre,
  }) : super(key: key);

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      padding: EdgeInsets.all(6),
      style: kNeumorphicStyle.copyWith(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(25),
        ),
        depth: 1,
        color: kSecondaryColor,
      ),
      child: Center(
        child: AutoSizeText(
          genre,
          style: Theme.of(context).textTheme.button.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          maxLines: 2,
          maxFontSize: 12,
          minFontSize: 8,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
