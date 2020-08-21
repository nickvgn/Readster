import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/details/components/add-or-remove-button.dart';
import 'package:untitled_goodreads_project/screens/details/components/ratings-card.dart';
import 'package:untitled_goodreads_project/screens/details/components/title-card.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      collapsedHeight: 320,
      toolbarHeight: 90,
      bottom: PreferredSize(
          child: FutureBuilder<bool>(
              future: FirestoreController().checkIfAdded(widget.book.id),
              builder: (context, snapshot) {
                bool isAdded = snapshot.data;
                if (snapshot.hasData) {
                  if (!isAdded || isChanged == true) {
                    return AddOrRemoveButton(
                        book: widget.book,
                        icon: MdiIcons.bookPlus,
                        title: 'Add to Library',
                        modalText:
                            'Just press "Yes" and it will be in your library before you can finish reading th..',
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
                            msg: "..is sentence",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                          );
                        });
                  }
                  if (isAdded || isChanged == false) {
                    return AddOrRemoveButton(
                        book: widget.book,
                        icon: MdiIcons.bookMinus,
                        title: 'Remove from library',
                        modalText:
                            'Just press "Yes" and it will disappear from your library like magic.',
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
                            msg: "Poof!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                          );
                        });
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              })),
      leading: Padding(
        padding: const EdgeInsets.all(15),
        child: NeumorphicButton(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            depth: 3,
          ),
          child: Icon(
            FontAwesomeIcons.angleLeft,
            color: kPrimaryColor,
          ),
          onPressed: () {},
        ),
      ),
      floating: true,
      pinned: true,
      leadingWidth: 100,
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
                  margin: EdgeInsets.only(top: 100),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 0, top: 31),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: -5,
                    spacing: 30,
                    children: [
                      //BOOK COVER
                      FadeIn(
                        duration: Duration(milliseconds: 5000),
                        child: Hero(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 170,
                              child: CachedNetworkImage(
                                imageUrl: widget.book.imageUrl,
                                placeholder: (context, __) => Image.asset(
                                    'assets/images/book_cover_placeholder.jpg'),
                              ),
                            ),
                          ),
                          tag: 'bookCover${widget.book.id}',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 22,
                        ),
                        margin: EdgeInsets.only(bottom: 30),
                        height: 100,
                        width: 180,
                        child: Column(
                          children: [
                            //BOOK TITLE
                            AutoSizeText(
                              widget.book.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              maxFontSize: 13,
                              minFontSize: 8,
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
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
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
