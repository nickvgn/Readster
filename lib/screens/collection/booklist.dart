import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/screens/collection/components/collection-book.dart';

final db = Firestore.instance;

class BookList extends StatefulWidget {
  const BookList({Key key, this.status}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();

  final String status;
}

class _BookListState extends State<BookList> {
  bool isFadeIn = false;

  @override
  void initState() {
    super.initState();

//    Future.delayed(const Duration(milliseconds: 450), () {
//      setState(() {
//        isFadeIn = true;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
        body: user != null
            ? StreamBuilder(
                stream: widget.status != ALL
                    ? FirestoreController.streamBooksByStatus(
                        user.uid, widget.status)
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
