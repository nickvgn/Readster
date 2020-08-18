import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/controller/weekday-controller.dart';
import 'package:untitled_goodreads_project/screens/home/home-screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:untitled_goodreads_project/screens/login/login-screen.dart';
import 'package:untitled_goodreads_project/screens/splash/splash-screen.dart';
import 'package:untitled_goodreads_project/services/auth.dart';

FirebaseAnalytics analytics;
FirebasePerformance performance;

void main() {
  analytics = FirebaseAnalytics();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirestoreController>(
          create: (context) => FirestoreController(),
        ),
        ChangeNotifierProvider<WeekdayController>(
          create: (context) => WeekdayController(),
        ),
        ChangeNotifierProvider<BookController>(
          create: (context) => BookController(),
        ),
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
      ],
      child: NeumorphicApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Readster',
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          baseColor: kLightPrimaryColor,
          accentColor: kSecondaryColor,
          lightSource: LightSource.topLeft,
          depth: 5,
          textTheme: GoogleFonts.quicksandTextTheme(),
          appBarTheme: NeumorphicAppBarThemeData(
            color: Colors.transparent,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
