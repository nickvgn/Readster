import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';

class AppBarTitle extends StatefulWidget {
  const AppBarTitle({
    Key key,
  }) : super(key: key);

  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var userName = user?.displayName ?? 'Stranger';

    return user != null
        ? Container(
            padding: EdgeInsets.only(left: 15),
            child: TyperAnimatedTextKit(
              isRepeatingAnimation: false,
              textAlign: TextAlign.start,
              speed: Duration(milliseconds: 70),
              text: ['Hi, $userName'],
              textStyle: Theme.of(context).textTheme.headline6.copyWith(
                  color: kLightBackgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )
        : Container();
  }
}
