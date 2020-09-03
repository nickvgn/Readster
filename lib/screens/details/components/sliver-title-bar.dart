import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/details/components/add-or-remove-button.dart';
import 'package:untitled_goodreads_project/screens/details/components/ratings-card.dart';
import 'package:untitled_goodreads_project/screens/details/components/title-card.dart';

class SliverTitleBar extends StatefulWidget {
  const SliverTitleBar({
    Key key,
    @required this.book,
  }) : super(key: key);

  final Book book;

  @override
  _SliverTitleBarState createState() => _SliverTitleBarState();
}

class _SliverTitleBarState extends State<SliverTitleBar> {
  bool isChanged = false;
  FToast fToast;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      brightness: Brightness.dark,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      expandedHeight: 540,
      collapsedHeight: 310,
      toolbarHeight: 90,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: FutureBuilder<bool>(
              future: FirestoreController().checkIfAdded(widget.book.id),
              builder: (context, snapshot) {
                bool isAdded = snapshot.data;
                if (snapshot.hasData) {
                  if (!isAdded || isChanged == true) {
                    return AddOrRemoveButton(
                        book: widget.book,
                        icon: Icons.library_add,
                        title: 'Add to Library',
                        modalText: 'This book will be added to your library',
                        press: () {
                          Provider.of<FirestoreController>(context,
                                  listen: false)
                              .addBook(widget.book);
                          setState(() {
                            isChanged = false;
                          });
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            backgroundColor: kPrimaryColor,
                            msg: "Done",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                          );
                        });
                  }
                  if (isAdded || isChanged == false) {
                    return AddOrRemoveButton(
                        book: widget.book,
                        icon: Icons.remove,
                        title: 'Remove from library',
                        modalText: 'This book will removed from your library',
                        press: () {
                          Provider.of<FirestoreController>(context,
                                  listen: false)
                              .deleteBook(widget.book);
                          setState(() {
                            isChanged = true;
                          });
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            backgroundColor: kPrimaryColor,
                            msg: "Done",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                          );
                        });
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
        )
      ],
      leading: IconButton(
        icon: Icon(
          FontAwesomeIcons.angleLeft,
          color: kLightBackgroundColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      floating: true,
      pinned: true,
      leadingWidth: 80,
      title: Text(
        'Book',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 20, color: kLightBackgroundColor),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
          StretchMode.zoomBackground,
        ],
        centerTitle: true,
        title: Stack(
          children: [
            TitleCard(
              book: widget.book,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 5, top: 31),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: -20,
                    spacing: 10,
                    children: [
                      //BOOK COVER
                      Hero(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 170,
                            child: FadeInImage.memoryNetwork(
                                image: widget.book.imageUrl,
                                placeholder: kTransparentImage),
                          ),
                        ),
                        tag: 'bookCover${widget.book.id}',
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 30,
                          bottom: 6,
                        ),
                        margin: EdgeInsets.only(bottom: 30),
                        height: 110,
                        width: 180,
                        child: Column(
                          children: [
                            //BOOK TITLE
                            Flexible(
                              child: AutoSizeText(
                                widget.book.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 13),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                maxFontSize: 13,
                                minFontSize: 8,
                              ),
                            ),
                            // BOOK AUTHOR
                            AutoSizeText(
                              "by ${widget.book.author}",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white, fontSize: 10),
                              maxFontSize: 12,
                              minFontSize: 6,
                              maxLines: 1,
                            ),
                            FittedBox(
                              child: RatingsCard(book: widget.book),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
