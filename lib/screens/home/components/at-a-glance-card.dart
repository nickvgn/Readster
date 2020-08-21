import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled_goodreads_project/components/dog-ear-button.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/home/components/date-of-today.dart';
import 'package:untitled_goodreads_project/screens/home/components/last-read.dart';

class AtAGlanceCard extends StatelessWidget {
  const AtAGlanceCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .93,
      alignment: Alignment.center,
      child: Neumorphic(
        margin: EdgeInsets.symmetric(vertical: 12),
        style: kNeumorphicStyle.copyWith(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(25),
          ),
          depth: 3,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.tealAccent[400],
                kPrimaryColor,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateOfToday(),
                Spacer(),
                Divider(
                  height: 1,
                  thickness: 3,
                  color: Colors.white12,
                ),
                Spacer(),
                Row(
                  children: [
                    ReadingStats(
                      title: "Daily Goal",
                      measure: '/50',
                      value: 26,
                    ),
                    SizedBox(width: 20),
                    ReadingStats(
                      title: "Finished",
                      measure: ' books',
                      value: 420,
                    ),
                    SizedBox(width: 20),
                    ReadingStats(
                      title: "Current Streak",
                      measure: ' days',
                      value: 60,
                    ),
                  ],
                ),
                Spacer(),
                Divider(
                  height: 1,
                  thickness: 3,
                  color: Colors.white12,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: LastRead(),
                    ),
//                DogEarButton(
//                  icon: FontAwesomeIcons.bookOpen,
//                  press: () {},
//                ),
                    SizedBox(
                      width: 60,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReadingStats extends StatelessWidget {
  const ReadingStats({
    Key key,
    this.title,
    this.measure,
    this.value,
  }) : super(key: key);

  final String title, measure;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title\n',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.white,
                  ),
            ),
            TextSpan(
              text: value.toString(),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            TextSpan(
              text: measure,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
