import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:untitled_goodreads_project/components/animated-logo.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/index/index.dart';
import 'package:untitled_goodreads_project/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

//  @override
//  void initState() {
//    super.initState();
//
//    auth.getUser.then(
//      (user) {
//        if (user != null) {
//          Navigator.pushReplacement(
//            context,
//            PageTransition(
//              type: PageTransitionType.scale,
//              child: HomeScreen(),
//            ),
//          );
//        }
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//            Text('Just one click away..',
//                style: Theme.of(context).textTheme.headline5),
            AnimatedLogo(
              text: [
                "Wake up, Neo. . .",
                "The Matrix has you. . .",
                "Press the white button.",
              ],
            ),
//            SpinkitWidget(),
            SizedBox(height: 100),
            SizedBox(
              width: 220,
              child: NeumorphicButton(
                style: kNeumorphicStyle.copyWith(
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.google,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text('Login with Google'),
                  ],
                ),
                onPressed: () async {
                  var user = await auth.googleSignIn();
                  if (user != null) {
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
          ],
        ),
      ),
    );
  }
}
