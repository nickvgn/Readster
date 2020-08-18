import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/screens/search/components/bottom-selector-%20indicator.dart';

class APISelectorTab extends StatelessWidget {
  const APISelectorTab({
    Key key,
    this.icon,
    this.title,
    this.apiType,
    this.color,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String apiType;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: kNeumorphicStyle.copyWith(
        boxShape: NeumorphicBoxShape.roundRect(
          apiType == GOODREADS
              ? BorderRadius.only(
                  topRight: Radius.circular(25),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(25),
                ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: apiType == GOODREADS
                ? MainAxisAlignment.center
                : MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.button.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
//          SizedBox(height: 3),
//          BottomSelectedIndicator(apiType: apiType),
            ],
          ),
        ],
      ),
    );
  }
}
