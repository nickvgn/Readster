import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/collection/collection-screen.dart';
import 'package:untitled_goodreads_project/screens/home/components/corner-nav-item.dart';
import 'package:untitled_goodreads_project/screens/search/search-screen.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    Key key,
  }) : super(key: key);

  _showModalBottomSheet(context, apiType) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          var size = MediaQuery.of(context).size;

          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: size.height * .75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: kLightBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SearchScreen(apiType: apiType),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CornerNavItem(
          icon: Icon(
            FontAwesomeIcons.user,
            size: 30,
            color: kPrimaryColor,
          ),
          isLeft: true,
          press: () {},
        ),
        Container(
          height: 60,
          width: size.width * .5,
//          margin: EdgeInsets.symmetric(horizontal: 20),
          child: NeumorphicButton(
            style: kNeumorphicStyle.copyWith(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Collection',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: CollectionScreen(),
                ),
              );
            },
          ),
        ),
        CornerNavItem(
          icon: Icon(
            Icons.search,
            size: 35,
            color: kPrimaryColor,
          ),
          isLeft: false,
          press: () => _showModalBottomSheet(context, GOODREADS),
        ),
      ],
    );
  }
}
