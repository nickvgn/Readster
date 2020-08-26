import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/home/components/header-title.dart';

class DescriptionCard extends StatelessWidget {
  final String description;

  const DescriptionCard({
    Key key,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: kNeumorphicStyle.copyWith(
        depth: -3,
        boxShape: NeumorphicBoxShape.rect(),
      ),
      margin: EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTitle(
            title: 'Description',
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: HtmlWidget(
              description,
              textStyle: TextStyle(
                fontSize: 14,
                color: kDarkTextColor,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
//      child: ShowMoreText(
//        description,
//        maxLength: 800,
//        style: TextStyle(fontSize: 16, color: kDarkTextColor),
//        showMoreStyle: TextStyle(
//            fontSize: 16,
//            fontWeight: FontWeight.bold,
//            color: kSecondaryColor,
//            backgroundColor: Colors.transparent),
//        shouldShowLessText: true,
//      ),
    );
  }
}
