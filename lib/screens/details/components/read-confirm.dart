import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/blurred-modal.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';

PageRouteBuilder buildReadConfirmModal(BuildContext context, String subtitle,
    String readStatus, Book book, FirebaseUser user) {
  return buildBlurredModal(
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
            subtitle,
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
            buildConfirmationButton('Yes', context, () {
              Provider.of<FirestoreController>(context, listen: false)
                  .updateBookStatus(readStatus, book, user?.uid);
              if (readStatus == READING) {
                Provider.of<FirestoreController>(context, listen: false)
                    .resetPagesRead(book);
              }
              Navigator.pop(context);
              if (readStatus == READ) {
                Navigator.pop(context);
              }
            }),
            buildConfirmationButton('No', context, () {
              Navigator.pop(context, false);
            }),
          ],
        )
      ],
    ),
  );
}
