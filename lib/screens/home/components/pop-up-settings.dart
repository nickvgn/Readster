import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:untitled_goodreads_project/components/blurred-modal.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/home/components/goal.dart';
import 'package:untitled_goodreads_project/screens/home/components/reminder.dart';
import 'package:untitled_goodreads_project/screens/login/login-screen.dart';
import 'package:untitled_goodreads_project/services/auth.dart';

class PopUpSettings extends StatelessWidget {
  const PopUpSettings({
    Key key,
    this.user,
    this.icon,
  }) : super(key: key);
  final FirebaseUser user;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final AuthService auth = AuthService();

    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: kLightBackgroundColor,
      child: icon,
      offset: Offset(0, 0),
      onSelected: (value) async {
        switch (value) {
          case 1:
            Navigator.of(context).push(
              buildBlurredModal(
                height: 500,
                width: 350,
                child: Reminder(user: user),
              ),
            );
            break;
          case 2:
            Navigator.of(context).push(
              buildBlurredModal(
                height: 400,
                width: size.width / 1.2,
                child: Goal(user: user),
              ),
            );
            break;
          case 3:
            await auth.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  child: LoginScreen(),
                  type: PageTransitionType.scale,
                ),
                (route) => false);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                MdiIcons.reminder,
                color: kPrimaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Set a reminder',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.solidStar,
                color: kPrimaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Set a goal',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(
                MdiIcons.logout,
                color: kPrimaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Log out',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
