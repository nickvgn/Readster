import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/components/blurred-modal.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/models/book.dart';

class AddOrRemoveButton extends StatelessWidget {
  const AddOrRemoveButton({
    Key key,
    this.icon,
    this.title,
    this.book,
    this.modalText,
    this.press,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Book book;
  final String modalText;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          icon,
          color: kLightBackgroundColor,
        ),
        onPressed: () {
          Navigator.of(context).push(
            buildBlurredModal(
              height: 300,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure?',
                    style: Theme.of(context).textTheme.headline5.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      modalText,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildConfirmationButton('Yes', context, press),
                      buildConfirmationButton('No', context, press),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
