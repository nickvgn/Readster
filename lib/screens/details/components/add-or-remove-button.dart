import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
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
    var size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 5),
        child: MaterialButton(
            color: kLightBackgroundColor,
            padding: EdgeInsets.all(10),
//            style: kNeumorphicStyle.copyWith(
//              boxShape: NeumorphicBoxShape.circle(),
//            ),
            shape: CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: kPrimaryColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                buildBlurredModal(
                  height: size.height / 3.5,
                  width: size.width / 1.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        modalText,
                        style: Theme.of(context).textTheme.headline6.copyWith(),
                        textAlign: TextAlign.center,
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
            }),
      ),
    );
  }
}
