import 'package:cached_network_image/cached_network_image.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'file:///C:/Users/MSI%20GP60-2PE/Projects/IdeaProjects/untitled_goodreads_project/lib/components/book-3d.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';
import 'package:untitled_goodreads_project/services/image-helper.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class Bookshelf extends StatefulWidget {
  @override
  _BookshelfState createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {
  bool isFadeIn = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        isFadeIn = true;
      });
    });
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
          child: isFadeIn
              ? StreamBuilder(
                  stream: Provider.of<BookController>(context).readStatus != ALL
                      ? FirestoreController.streamBooksByStatus(user.uid,
                          Provider.of<BookController>(context).readStatus)
                      : FirestoreController.streamBooks(user.uid),
                  builder: (context, snapshot) {
                    var books = snapshot.data;
                    return snapshot.hasData
                        ? Stack(
                            children: [
                              FadeIn(
                                duration: Duration(milliseconds: 400),
                                child: FadingEdgeScrollView.fromScrollView(
                                  child: GridView.builder(
                                    cacheExtent: 70,
                                    controller: controller,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.all(20),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 0,
                                      childAspectRatio: .50,
                                    ),
                                    itemCount: books.length,
                                    itemBuilder: (context, index) => Book3D(
                                      book: books[index],
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
                  })
              : Container()),
    );
  }
}
