import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled_goodreads_project/components/dog-ear-button.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/models/genre.dart';
import 'package:untitled_goodreads_project/screens/details/components/genre-box.dart';
import 'package:untitled_goodreads_project/services/networking.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MoreInfo extends StatefulWidget {
  const MoreInfo({
    Key key,
    @required this.book,
    this.goodreadsGenres,
  }) : super(key: key);

  final Book book;
  final List<Genre> goodreadsGenres;

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int width = 388;
    int height = 563;

    return SizedBox(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.book.pageCount}',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: ' pages\n',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    TextSpan(
                      text: 'published on ',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    TextSpan(
                      text: '${widget.book.pubishedDate}\n',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: 'ISBN ',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 12,
                          ),
                    ),
                    TextSpan(
                      text:
                          '${widget.book.isbn == '' ? 'not available' : widget.book.isbn}\n',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  widget.book.isGoodreads
                      ? DogEarButton(
                          title: 'Reviews',
                          icon: FontAwesomeIcons.goodreads,
                          press: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context2, __, ___) {
                                  return Scaffold(
                                    backgroundColor: Colors.black45,
                                    body: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 10,
                                        sigmaY: 10,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
//                                          SizedBox(
//                                            height: 600,
//                                            width: 400,
//                                          ),
                                            Container(
//                                            margin: EdgeInsets.symmetric(
//                                              horizontal:
//                                                  (size.width - width) / 1.335,
//                                              vertical:
//                                                  (size.height - height) / 3,
//                                            ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              height: 700,
                                              width: 380,
                                              child: SizedBox(
                                                child: ClipPath(
                                                  clipper: CustomRect2(),
                                                  child: WebView(
                                                    initialUrl: Uri.dataFromString(
                                                            NetworkHelper
                                                                .reviewHtml(
                                                                    widget.book
                                                                        .isbn,
                                                                    365,
                                                                    700),
                                                            mimeType:
                                                                'text/html')
                                                        .toString(),
                                                    javascriptMode:
                                                        JavascriptMode
                                                            .unrestricted,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
// Scaffold
                                },
                              ),
                            );
                          },
                        )
                      : Container(),
                  if (widget.book.isEbook != null)
                    widget.book.isEbook
                        ? DogEarButton(
                            title: 'Sample eBook',
                            icon: FontAwesomeIcons.google,
                            press: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  maintainState: true,
                                  opaque: false,
                                  pageBuilder: (BuildContext context, __, ___) {
                                    return Scaffold(
                                      backgroundColor: Colors.black45,
                                      body: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaY: 10, sigmaX: 10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: size.height / 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    (size.width - width) /
                                                        1.335,
                                                vertical:
                                                    (size.height - height) / 3,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              height: height.toDouble(),
                                              width: width.toDouble(),
                                              child: SizedBox(
                                                child: ClipPath(
                                                  clipper: CustomRect(),
                                                  child: WebViewPlus(
                                                    javascriptMode:
                                                        JavascriptMode
                                                            .unrestricted,
                                                    onWebViewCreated:
                                                        (controller) {
                                                      controller.loadString(
                                                        NetworkHelper
                                                            .previewHtml(
                                                                widget
                                                                    .book.isbn,
                                                                width,
                                                                height),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
// Scaffold
                                  },
                                ),
                              );
                            },
                          )
                        : SizedBox(),
                  SizedBox(height: 15)
                ],
              ),
            ],
          ),
          Expanded(
              child: widget.book.genres == null
                  ? widget.goodreadsGenres != null
                      ? GridView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.25,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: widget.goodreadsGenres.length,
                          itemBuilder: (context, index) => GenreBox(
                              genre: widget.goodreadsGenres[index].name
                                  .toString()
                                  .replaceAll('-', ' ')),
                        )
                      : Container()
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.25,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: widget.book.genres.length,
                      itemBuilder: (context, index) =>
                          GenreBox(genre: widget.book.genres[index]),
                    )),
        ],
      ),
    );
  }
}

class CustomRect extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 10;

    Path path = Path()
      ..addRRect(RRect.fromLTRBR(size.width * .027, size.height * .0175,
          size.width * .969, size.height * .960, Radius.circular(radius)))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) => false;
}

class CustomRect2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 10;

    Path path = Path()
      ..addRRect(RRect.fromLTRBR(0.0, size.height * .12, size.width * 1,
          size.height * 1, Radius.circular(radius)))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) => false;
}
