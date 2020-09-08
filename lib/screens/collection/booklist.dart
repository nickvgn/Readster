import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/screens/collection/components/collection-book.dart';

final db = Firestore.instance;

class BookList extends StatelessWidget {
  const BookList({Key key, this.status}) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
        body: user != null
            ? StreamBuilder(
                stream: status != ALL
                    ? FirestoreController.streamBooksByStatus(user.uid, status)
                    : FirestoreController.streamBooks(user.uid),
                builder: (context, snapshot) {
                  var books = snapshot.data;
                  return snapshot.hasData
                      ? FadingEdgeScrollView.fromScrollView(
                          child: ListView.builder(
                            controller: controller,
                            physics: BouncingScrollPhysics(),
                            itemCount: books.length,
                            itemBuilder: (context, index) => CollectionBook(
                              book: books[index],
                            ),
                          ),
                        )
                      : Container();
                },
              )
            : SpinkitWidget());
  }
}
