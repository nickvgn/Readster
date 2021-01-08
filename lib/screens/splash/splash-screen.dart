import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/index/index.dart';
import 'package:untitled_goodreads_project/screens/login/login-screen.dart';
import 'package:untitled_goodreads_project/services/auth.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AuthService auth = AuthService();

  AnimationController controller;
//  AnimationController controller2;
//  Animation animation;
  Animation colorAnimation;
  Animation depthAnimation;

  @override
  void initState() {
    super.initState();
    onDoneLoading();

    controller = AnimationController(
      duration: Duration(milliseconds: 800),
      lowerBound: 0,
      vsync: this,
    );

//    controller2 = AnimationController(
//      duration: Duration(milliseconds: 600),
//      lowerBound: 0,
//      vsync: this,
//    );

//    animation =
//        CurvedAnimation(parent: controller, curve: Curves.easeInOutSine);
    colorAnimation =
        ColorTween(begin: kLightBackgroundColor, end: kPrimaryColor).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.75, 1, curve: Curves.easeInOutCirc)));
    depthAnimation = Tween<double>(begin: 0, end: 15).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo));

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
//    controller2.dispose();
    super.dispose();
  }

//  Future<Timer> loadData() async {
//    return new Timer(Duration(seconds: 10), onDoneLoading);
//  }

  Future<FirebaseUser> getUser() async {
    var user = auth.getUser;
    return user;
  }

  onDoneLoading() async {
    auth.getUser.then(
      (user) {
        if (user != null) {
          Timer(
            Duration(seconds: 4),
            () => Navigator.pushReplacement(
              context,
              PageTransition(
//                duration: Duration(seconds: 2),
                type: PageTransitionType.fade,
                child: IndexScreen(),
              ),
            ),
          );
        } else {
          Timer(
            Duration(seconds: 5),
            () => Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: LoginScreen(),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Neumorphic(
        style: NeumorphicStyle(
          color: kLightBackgroundColor,
        ),
        child: Center(
          child: Hero(
            tag: 'Readster',
            child: NeumorphicText(
              'Readster',
              style: kNeumorphicStyle.copyWith(
                  intensity: 1,
                  depth: depthAnimation.value,
                  color: colorAnimation.value),
              textStyle: NeumorphicTextStyle(
                fontSize: 75,
                fontFamily: GoogleFonts.chewy().fontFamily,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
