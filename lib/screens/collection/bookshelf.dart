import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/book-3d.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';

class Bookshelf extends StatefulWidget {
  const Bookshelf({Key key, this.status}) : super(key: key);

  @override
  _BookshelfState createState() => _BookshelfState();

  final String status;
}

class _BookshelfState extends State<Bookshelf> {
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
    var size = MediaQuery.of(context).size;
    final controller = ScrollController();
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: StreamBuilder(
              stream: widget.status != ALL
                  ? FirestoreController.streamBooksByStatus(
                      user.uid, widget.status)
                  : FirestoreController.streamBooks(user.uid),
              builder: (context, snapshot) {
                var books = snapshot.data;
                return snapshot.hasData
                    ? Stack(
                        children: [
                          FadingEdgeScrollView.fromScrollView(
                            child: GridView.builder(
                              controller: controller,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: size.width > 480 ? 5 : 4,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 0,
                                childAspectRatio: .50,
                              ),
                              cacheExtent: 500,
                              itemCount: books.length,
                              itemBuilder: (context, index) => FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  height: 190,
                                  child: Book3D(book: books[index]),
                                ),
                              ),
                            ),
                          ),
//                              Align(
//                                alignment: Alignment.bottomRight,
//                                child: NeumorphicButton(
//                                  margin:
//                                      EdgeInsets.only(right: 15, bottom: 25),
//                                  style: kNeumorphicStyle.copyWith(
//                                    boxShape: NeumorphicBoxShape.roundRect(
//                                        BorderRadius.circular(25)),
//                                  ),
//                                  onPressed: () {
//                                    setState(() {
//                                      Provider.of<BookController>(context,
//                                              listen: false)
//                                          .updateReadStatusState();
//                                    });
//                                  },
//                                  child: SizedBox(
//                                    width: 100,
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                      children: [
//                                        Icon(
//                                          MdiIcons.filterVariant,
//                                          color: kSecondaryColor,
//                                          size: 30,
//                                        ),
//                                        SizedBox(width: 10),
//                                        Flexible(
//                                          child: Text(
//                                              Provider.of<BookController>(
//                                                      context)
//                                                  .readStatus),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ),
                        ],
                      )
                    : Container();
              })),
    );
  }
}
