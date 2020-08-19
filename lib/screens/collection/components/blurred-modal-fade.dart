import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/collection/components/progress-modal-content.dart';

PageRouteBuilder buildBlurredModalFade(
    {Size size, Widget child, double height = 360, double width = 340}) {
  var sliderValue = 0.5;
  return PageRouteBuilder(
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 2000),
      opaque: false,
      pageBuilder: (BuildContext context, __, ___) {
        return StatefulBuilder(builder: (context, StateSetter setModalState) {
          return FadeIn(
              duration: Duration(milliseconds: 2000),
              child: Scaffold(
                backgroundColor: Colors.black45,
                body: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: FadeIn(
                      duration: Duration(milliseconds: 3500),
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
              ));
        });
      });
}
