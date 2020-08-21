import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'animated-logo.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: kPrimaryColor,
      ),
      onPressed: () {},
    ),
    flexibleSpace: Positioned(
      top: 40,
      left: 203,
      child: AnimatedLogo(),
    ),
    title: Text(
      'better           ',
      style: Theme.of(context).textTheme.headline6.copyWith(
          color: kPrimaryColor, fontWeight: FontWeight.w300, fontSize: 25),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.message,
          color: kPrimaryColor,
        ),
        onPressed: () {},
      )
    ],
  );
}
