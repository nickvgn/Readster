import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/collection/components/blurred-modal-fade.dart';
import 'package:untitled_goodreads_project/screens/collection/components/progress-modal-content.dart';
import 'package:untitled_goodreads_project/screens/collection/components/read-status-radio.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';

class CollectionBook extends StatefulWidget {
  const CollectionBook({
    Key key,
    this.book,
  }) : super(key: key);

  final Book book;

  @override
  _CollectionBookState createState() => _CollectionBookState();
}

class _CollectionBookState extends State<CollectionBook> {
  bool isUpdate = false;
  var sliderValue = 0.5;
  String readStatus;

  @override
  void initState() {
    super.initState();
    sliderValue =
        ((widget.book.pageRead / widget.book.pageCount) * 10).toDouble();
    readStatus = widget.book.readStatus;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: 200,
      child: Neumorphic(
        margin: EdgeInsets.only(bottom: 20, top: 10),
        padding: EdgeInsets.all(15),
        style: kNeumorphicStyle.copyWith(depth: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 150,
                  child: NeumorphicButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Provider.of<BookController>(context, listen: false)
                          .updateBookId(widget.book.id);
                      Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.easeInOutSine,
                          type: PageTransitionType.scale,
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 100),
                          child: DetailsScreen(),
                        ),
                      );
                    },
                    style: kNeumorphicStyle,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: 'cover${widget.book.id}',
                        child: CachedNetworkImage(
                          imageUrl: widget.book.imageUrl,
                          placeholder: (context, __) => Image.asset(
                              'assets/images/book_cover_placeholder.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 25),
            Expanded(
              child: Container(
                width: size.width * .80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * .5,
                              child: AutoSizeText(
                                widget.book.title,
                                style: TextStyle(fontSize: 15),
                                maxLines: 2,
                                minFontSize: 8,
                                maxFontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: size.width * .5,
                              child: AutoSizeText(
                                widget.book.author,
                                style: TextStyle(
                                    fontSize: 13, color: kTextLightColor),
                                maxLines: 2,
                                minFontSize: 8,
                                maxFontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        if (readStatus == READ)
                          Neumorphic(
                            padding: EdgeInsets.all(6),
                            style: kNeumorphicStyle.copyWith(
                              depth: 0,
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            child: NeumorphicIcon(
                              FontAwesomeIcons.check,
                              style: kNeumorphicStyle.copyWith(
                                  color: kPrimaryColor),
                            ),
                          ),
                        if (readStatus == READING)
                          NeumorphicButton(
                            padding: EdgeInsets.all(6),
                            style: kNeumorphicStyle.copyWith(
                              depth: 0,
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            child: NeumorphicIcon(
                              FontAwesomeIcons.pen,
                              style: kNeumorphicStyle.copyWith(
                                  color: kPrimaryColor),
                            ),
                            onPressed: () async {
                              dynamic received =
                                  await Navigator.of(context).push(
                                buildBlurredModalFade(
                                  child: ProgressModalContent(
                                    book: widget.book,
                                    sliderValue: sliderValue,
                                  ),
                                ),
                              );
                              if (received != null)
                                setState(() {
                                  sliderValue = received;
                                });
                            },
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (readStatus == READING)
                      SizedBox(
                        width: size.width * .55,
                        child: Hero(
                          tag: 'slider${widget.book.id}',
                          child: NeumorphicProgress(
                            style: ProgressStyle(
                              accent: kPrimaryColor,
                              depth: 1,
                            ),
                            duration: Duration(seconds: 2),
                            height: 20,
                            percent: sliderValue / 10,
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
                    if (readStatus == TOREAD)
                      NeumorphicButton(
                        style: kNeumorphicStyle.copyWith(
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(25))),
                        child: Text(
                          'Start Reading',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        onPressed: () {
                          Provider.of<FirestoreController>(context,
                                  listen: false)
                              .updateBookStatus(READING, widget.book);
                          setState(() {
                            readStatus = READING;
                          });
                        },
                      ),
//                    ReadStatusRadio(
//                      readStatus: readStatus,
//                      onChanged: (value) {
//                        setState(() {
//                          readStatus = value;
//                          Provider.of<FirestoreController>(context,
//                                  listen: false)
//                              .updateBookStatus(value, widget.book);
//                        });
//                      },
//                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
