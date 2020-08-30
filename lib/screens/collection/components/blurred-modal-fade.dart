import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

PageRouteBuilder buildBlurredModalFade(
    {Size size, Widget child, double height = 360, double width = 340}) {
  return PageRouteBuilder(
      barrierDismissible: true,
      reverseTransitionDuration: Duration(milliseconds: 100),
      transitionDuration: Duration(milliseconds: 1000),
      opaque: false,
      pageBuilder: (BuildContext context, __, ___) {
        return Scaffold(
          backgroundColor: Colors.black45,
          body: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: FadeIn(
                duration: Duration(milliseconds: 1000),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: child,
                  ),
                ),
              )),
        );
      });
}
