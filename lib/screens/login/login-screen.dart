import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:untitled_goodreads_project/components/animated-logo.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/screens/index/index.dart';
import 'package:untitled_goodreads_project/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  bool isTitleFadeIn = false;
  bool isSubtitleFadeIn = false;

  Future<void> checkIfUserExist() async {
    var doc = await FirestoreController.getUserDocument();
    if (doc == null) {
      FirestoreController().addUser();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isTitleFadeIn = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isSubtitleFadeIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            AnimatedLogo(
              text: [
                "Hi There,",
              ],
            ),
            SizedBox(height: 10),
            isTitleFadeIn
                ? AnimatedLogo(
                    text: [
                      "This is Readster",
                    ],
                  )
                : SizedBox(height: 42),
            SizedBox(height: 40),
            isSubtitleFadeIn
                ? FadeIn(
                    duration: Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 90,
                      width: 300,
                      child: Text(
                        'Your personal reading companion to help you along your journey',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white54, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SizedBox(height: 90),
//            SpinkitWidget(),
            SizedBox(height: 100),
            SizedBox(
              width: 220,
              child: NeumorphicButton(
                style: kNeumorphicStyle.copyWith(
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(25),
                    ),
                    shadowLightColor: Colors.white60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.google,
                      color: kSecondaryColor,
                    ),
                    SizedBox(width: 10),
                    Text('Login with Google'),
                  ],
                ),
                onPressed: () async {
                  var user = await auth.googleSignIn();
                  if (user != null) {
                    await checkIfUserExist();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: IndexScreen(),
                        duration: Duration(milliseconds: 2000),
                        type: PageTransitionType.fade,
                      ),
                    );
                  }
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
