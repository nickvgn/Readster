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
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width * .47,
                child: Neumorphic(
                  style: kNeumorphicStyle.copyWith(
                    color: Colors.transparent,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(35),
                    ),
                  ),
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
                          height: 70,
                          width: 70,
                          child: NeumorphicButton(
                            style: kNeumorphicStyle.copyWith(
                              boxShape: NeumorphicBoxShape.circle(),
                              depth: 0,
                              color: Colors.transparent,
                            ),
                            padding: EdgeInsets.all(5),
                            child: FlareActor(
                              "assets/icons/search-4.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              color: kLightBackgroundColor,
                            ),
                            onPressed: () => _showModalBottomSheet(
                                context,
                                Provider.of<BookController>(context,
                                        listen: false)
                                    .apiType),
                          ),
                        ),
                        NeumorphicButton(
                          style: kNeumorphicStyle.copyWith(
                            boxShape: NeumorphicBoxShape.circle(),
                            depth: 0,
                            color: Colors.transparent,
                          ),
                          child: Icon(
                            MdiIcons.barcodeScan,
                            color: kLightBackgroundColor,
                            size: 30,
                          ),
                          onPressed: () {
                            scanBarcodeNormal(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
