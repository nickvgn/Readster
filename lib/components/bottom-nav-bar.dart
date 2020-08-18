import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/screens/collection/collection-screen.dart';
import 'package:untitled_goodreads_project/screens/home/home-screen.dart';
import 'package:untitled_goodreads_project/screens/search/search-screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
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
                  color: kLightPrimaryColor,
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NeumorphicButton(
                child: NeumorphicIcon(
                  MdiIcons.homeVariant,
                  size: 35,
                  style: kNeumorphicStyle.copyWith(
                    color: Provider.of<BookController>(context).currentScreen ==
                            HOME
                        ? kSecondaryColor
                        : Colors.grey,
                    depth: Provider.of<BookController>(context).currentScreen ==
                            HOME
                        ? 3
                        : 1,
                  ),
                ),
                style: kNeumorphicStyle.copyWith(
                  depth: 0,
                ),
                onPressed: () {
                  Provider.of<BookController>(context, listen: false)
                      .updateScreenState(HOME);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: HomeScreen(),
                    ),
                  );
                },
              ),
              SizedBox(width: 120),
              NeumorphicButton(
                child: NeumorphicIcon(
                  MdiIcons.bookshelf,
                  size: 35,
                  style: kNeumorphicStyle.copyWith(
                    color: Provider.of<BookController>(context).currentScreen ==
                            LIBRARY
                        ? kSecondaryColor
                        : Colors.grey,
                    depth: Provider.of<BookController>(context).currentScreen ==
                            LIBRARY
                        ? 3
                        : 1,
                  ),
                ),
                style: kNeumorphicStyle.copyWith(
                  depth: 0,
                ),
                onPressed: () {
                  Provider.of<BookController>(context, listen: false)
                      .updateScreenState(LIBRARY);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: CollectionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          right: 170,
          bottom: 20,
          child: NeumorphicButton(
            padding: EdgeInsets.all(25),
            style: kNeumorphicStyle.copyWith(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: Icon(
              MdiIcons.bookSearch,
              color: kSecondaryColor,
              size: 35,
            ),
            onPressed: () => _showModalBottomSheet(context, GOODREADS),
          ),
        ),
      ],
    );
  }
}
