import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:untitled_goodreads_project/components/book-3d.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/services/image-helper.dart';

class MyBooksCard extends StatelessWidget {
  const MyBooksCard({
    Key key,
    this.book,
  }) : super(key: key);

  final Book book;

  String getTimeAgo() {
    var difference = DateTime.now().difference(book.lastRead);
    return difference.inDays == 0 &&
            difference.inMinutes == 0 &&
            difference.inHours != 0
        ? difference.inHours.toString() + ' hour(s) ago'
        : difference.inHours == 0 &&
                difference.inDays == 0 &&
                difference.inMinutes != 0
            ? difference.inMinutes.toString() + ' minute(s) ago'
            : difference.inDays.toString() + ' day(s) ago';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isUpdate = false;

    return FutureBuilder<List<Color>>(
      future: ImageHelper.getImagePalette(
        NetworkImage(book.imageUrl),
      ),
      builder: (context, snapshot) {
        var colors = snapshot.data;
        return Neumorphic(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          style: kNeumorphicStyle.copyWith(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(25),
            ),
            depth: 3,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kLightPrimaryColor,
//                  gradient: LinearGradient(
//                    colors:
//                        snapshot.hasData ? colors : [Colors.white, Colors.grey],
//                  ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Book3D(book: book),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          book.title,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
//                                      color: Colors.white,
                              ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${book.lastRead != null ? 'Last read: ${getTimeAgo()} ' : ''}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.black45,
                            ),
                      ),
//                      SizedBox(height: 15),
                      Flexible(
                        child: isUpdate == true
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: RoundedProgressBar(
                                  borderRadius: BorderRadius.circular(25),
                                  style: RoundedProgressBarStyle(
                                    colorBorder: Colors.transparent,
                                    colorProgressDark: kSecondaryColor,
                                    colorProgress: snapshot.hasData
                                        ? colors[0]
                                        : kSecondaryColor,
                                    backgroundProgress:
                                        Colors.grey.withOpacity(.2),
                                  ),
                                  milliseconds: 2000,
                                  height: 20,
                                  percent: book.pageRead / book.pageCount * 100,
                                ),
                              ),
                      ),
//                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: (book.pageCount - book.pageRead).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontSize: 22,
                                  ),
                            ),
                            TextSpan(
                              text: ' pages left',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
