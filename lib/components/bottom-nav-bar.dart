import 'dart:async';
import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';
import 'package:untitled_goodreads_project/screens/search/search-screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool isPaused = false;
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal(context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      if (barcodeScanRes != '-1') {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.scale,
            child: DetailsScreen(
              isbn: barcodeScanRes,
            )));
      } else {
        return;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return;
  }

  _showModalBottomSheet(context, apiType) {
    showMaterialModalBottomSheet(
        useRootNavigator: true,
        enableDrag: true,
        context: context,
        builder: (BuildContext context, _) {
          var size = MediaQuery.of(context).size;

          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: size.height * .6,
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: Neumorphic(
//                  padding: EdgeInsets.symmetric(horizontal: 20),
                  style: kNeumorphicStyle.copyWith(
                      color: Colors.transparent,
//                    border: NeumorphicBorder(color: kSecondaryColor, width: 2),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(35))),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, kSecondaryColor],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 70,
                          child: NeumorphicButton(
                            style: kNeumorphicStyle.copyWith(
                              boxShape: NeumorphicBoxShape.circle(),
                              depth: 0,
                              color: Colors.transparent,
                            ),
                            padding: EdgeInsets.all(5),
                            child: FlareActor("assets/icons/search-4.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                color: kLightBackgroundColor,
                                animation: "tabbar_search"),
//                        Icon(
//                          MdiIcons.bookSearch,
//                          color: kLightPrimaryColor,
//                          size: 35,
//                        ),
                            onPressed: () => _showModalBottomSheet(
                                context,
                                Provider.of<BookController>(context,
                                        listen: false)
                                    .apiType),
                          ),
                        ),
                        NeumorphicButton(
//                      padding: EdgeInsets.all(25),
                          style: kNeumorphicStyle.copyWith(
                            boxShape: NeumorphicBoxShape.circle(),
                            depth: 0,
                            color: Colors.transparent,
                          ),
                          child: Icon(
                            MdiIcons.barcodeScan,
                            color: kLightBackgroundColor,
                            size: 35,
                          ),
                          onPressed: () {
                            scanBarcodeNormal(context);
                          },
                        ),
//                    SizedBox(
//                      height: 70,
//                      width: 200,
//                      child: SearchBox(),
//                    ),
                      ],
                    ),
                  ),
                ),
              ),
//              SizedBox(
//                height: 80,
//                width: 200,
//                child: SnakeNavigationBar(
//                  style: SnakeBarStyle.pinned,
//                  snakeShape: SnakeShape.circle,
//                  snakeColor: kSecondaryColor,
//                  backgroundColor: kLightPrimaryColor,
//                  showUnselectedLabels: false,
//                  showSelectedLabels: false,
//                  padding: EdgeInsets.all(25),
////                shape: BottomB,
////                padding: padding,
//                  currentIndex: _selectedItemPosition,
//                  onPositionChanged: (index) =>
//                      setState(() => _selectedItemPosition = index),
//                  items: [
//                    BottomNavigationBarItem(
//                        icon: Icon(
//                          MdiIcons.bookshelf,
//                          size: 35,
//                        ),
//                        title: Text('calendar')),
//                    BottomNavigationBarItem(
//                        icon: FlareActor("assets/icons/home-4.flr",
//                            alignment: Alignment.center,
//                            isPaused: isPaused,
//                            fit: BoxFit.contain,
////                            color: kLi,
//                            animation: "Untitled"),
//                        title: Text('tickets')),
//                  ],
//                ),
//              ),
//              Flexible(
//                child: NeumorphicButton(
//                  child: FlareActor("assets/icons/home-4.flr",
//                      alignment: Alignment.center,
//                      isPaused: isPaused,
//                      fit: BoxFit.contain,
//                      color: kSecondaryColor,
//                      animation: "Untitled"),
////                NeumorphicIcon(
////                  MdiIcons.homeVariant,
////                  size: 35,
////                  style: kNeumorphicStyle.copyWith(
////                    color: Provider.of<BookController>(context).currentScreen ==
////                            HOME
////                        ? kSecondaryColor
////                        : Colors.grey,
////                    depth: Provider.of<BookController>(context).currentScreen ==
////                            HOME
////                        ? 3
////                        : 1,
////                  ),
////                ),
//                  style: kNeumorphicStyle.copyWith(
//                    depth: 0,
//                    color: Colors.transparent,
//                  ),
//                  onPressed: () {
//                    Provider.of<BookController>(context, listen: false)
//                        .updateScreenState(HOME);
//                    setState(() {
//                      isPaused = false;
//                    });
//                    Navigator.push(
//                      context,
//                      PageTransition(
//                        type: PageTransitionType.fade,
//                        child: HomeScreen(),
//                      ),
//                    );
//                  },
//                ),
//              ),
////              SizedBox(width: 120),
//              NeumorphicButton(
//                child: NeumorphicIcon(
//                  MdiIcons.bookshelf,
//                  size: 35,
//                  style: kNeumorphicStyle.copyWith(
//                    color: Provider.of<BookController>(context).currentScreen ==
//                            LIBRARY
//                        ? kSecondaryColor
//                        : Colors.grey,
//                    depth: Provider.of<BookController>(context).currentScreen ==
//                            LIBRARY
//                        ? 3
//                        : 1,
//                  ),
//                ),
//                style: kNeumorphicStyle.copyWith(
//                  depth: 0,
//                  color: Colors.transparent,
//                ),
//                onPressed: () {
//                  Provider.of<BookController>(context, listen: false)
//                      .updateScreenState(LIBRARY);
//                  setState(() {
//                    isPaused = true;
//                  });
//                  Navigator.push(
//                    context,
//                    PageTransition(
//                      type: PageTransitionType.fade,
//                      child: CollectionScreen(),
//                    ),
//                  );
//                },
//              ),
            ],
          ),
        ),
//        Positioned(
//          right: 220,
//          bottom: 20,
//          child: NeumorphicButton(
//              padding: EdgeInsets.all(25),
//              style: kNeumorphicStyle.copyWith(
//                boxShape: NeumorphicBoxShape.circle(),
//              ),
//              child: Icon(
//                MdiIcons.barcodeScan,
//                color: kSecondaryColor,
//                size: 35,
//              ),
//              onPressed: () {
//                scanBarcodeNormal(context);
//              }
//
////            => _showModalBottomSheet(context, GOODREADS),
//              ),
//        ),
//        Positioned(
//          right: 120,
//          bottom: 20,
//          child: NeumorphicButton(
//            padding: EdgeInsets.all(25),
//            style: kNeumorphicStyle.copyWith(
//              boxShape: NeumorphicBoxShape.circle(),
//            ),
//            child: Icon(
//              MdiIcons.bookSearch,
//              color: kSecondaryColor,
//              size: 35,
//            ),
//            onPressed: () => _showModalBottomSheet(context, GOODREADS),
//          ),
//        ),
      ],
    );
  }
}
