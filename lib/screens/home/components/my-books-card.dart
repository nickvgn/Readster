import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:untitled_goodreads_project/components/book-3d.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/models/book.dart';

class MyBooksCard extends StatelessWidget {
  const MyBooksCard({
    Key key,
    this.book,
    this.isFadeIn,
    this.animation,
  }) : super(key: key);

  final Book book;
  final bool isFadeIn;
  final Animation animation;

  String getTimeAgo() {
    var difference = DateTime.now().difference(book.lastRead);
    if (difference.inDays == 0 && difference.inHours == 0) {
      if (difference.inMinutes == 0) {
        return 'Just now';
      } else
        return difference.inMinutes > 1
            ? difference.inMinutes.toString() + ' minutes ago'
            : difference.inMinutes.toString() + ' minute ago';
    } else if (difference.inDays == 0 && difference.inHours != 0) {
      return difference.inHours > 1
          ? difference.inHours.toString() + ' hours ago'
          : difference.inHours.toString() + ' hour ago';
    } else if (difference.inDays != 0) {
      return difference.inDays > 1
          ? difference.inDays.toString() + ' days ago'
          : difference.inDays.toString() + ' day ago';
    } else
      return '';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Neumorphic(
          margin: EdgeInsets.only(top: 45, bottom: 8, left: 10, right: 10),
          style: kNeumorphicStyle.copyWith(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(25),
            ),
            depth: animation.value,
            shadowLightColor: Colors.white60,
          ),
          child: Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: kLightBackgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 90),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: (' ${book.pageCount - book.pageRead}')
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        fontSize: 24,
                                      ),
                                ),
                                TextSpan(
                                  text: ' pages left',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        RoundedProgressBar(
                          borderRadius: BorderRadius.circular(25),
                          style: RoundedProgressBarStyle(
                            colorBorder: Colors.transparent,
                            colorProgressDark: kPrimaryColor,
                            colorProgress: kPrimaryColor,
                            backgroundProgress: Colors.grey.withOpacity(.2),
                          ),
                          milliseconds: 2000,
                          height: 17,
                          percent: book.pageRead / book.pageCount * 100,
                        ),
                        Expanded(
                          child: Text(
                            '${book.lastRead != null ? '  Last read: ${getTimeAgo()} ' : ''}',
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: Colors.black26,
                                    ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isFadeIn)
          Positioned(
            bottom: 40,
            left: 25,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 195,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 5),
                  child: FadeIn(
                    duration: Duration(milliseconds: 500),
                    child: Book3D(book: book),
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 25,
          left: 35,
          child: Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 220,
                  child: Text(
                    book.title,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.black26,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
