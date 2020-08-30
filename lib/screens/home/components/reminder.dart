import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';

class Reminder extends StatefulWidget {
  const Reminder({
    Key key,
    @required this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  DateFormat time = DateFormat("hh:mm");
  DateTime dateTime = DateTime.now();
  String bookTitle = 'a book';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  showNotification(String bookTitle, DateTime dateTime) async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        '🐱‍👓 Hey! Over here.. Read this book: $bookTitle.',
        'This message was brought to you by Readster.',
        dateTime,
        platform);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10),
        Text(
          'Set a reminder',
          style: Theme.of(context).textTheme.headline6.copyWith(),
          textAlign: TextAlign.center,
        ),
        StreamBuilder<List<Book>>(
            stream: FirestoreController.streamBooksByStatus(
                widget.user.uid, READING),
            builder: (context, snapshot) {
              var readingBooks = snapshot.data;
              return snapshot.hasData
                  ? SizedBox(
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        itemCount: readingBooks.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Neumorphic(
                            style: kNeumorphicStyle.copyWith(
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            child: Image.network(readingBooks[index].imageUrl),
                          ),
                        ),
                        options: CarouselOptions(
                          onPageChanged: (val, reason) {
                            if (readingBooks != null) {
                              setState(() {
                                bookTitle = readingBooks[val].title;
                              });
                            }
                          },
                          height: 130,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayInterval: Duration(seconds: 10),
                          autoPlayCurve: Curves.easeInOutSine,
                          pauseAutoPlayOnManualNavigate: true,
                          initialPage: 0,
                          aspectRatio: 0.8,
//            viewportFraction: 0.95,
                          viewportFraction: 0.3,
                        ),
                      ),
                    )
                  : Container();
            }),
        SizedBox(
          height: 80,
          child: CupertinoDatePicker(
            minimumDate: DateTime.now(),
            maximumDate: DateTime.now().add(Duration(days: 1)),
            onDateTimeChanged: (DateTime datetime) {
              setState(() {
                dateTime = datetime;
              });
            },
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: 'Remind me to read',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            TextSpan(
              text: ' $bookTitle',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ' at',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            TextSpan(
              text: ' ${DateFormat().add_jm().format(dateTime)}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ]),
        ),
//                                SizedBox(height: 20),
//                                NeumorphicTextField(
//                                  hintText: 'Yearly books',
//                                  icon: MdiIcons.bookMultiple,
//                                ),
        buildConfirmationButton('Save', context, () {
          showNotification(bookTitle, dateTime);
          Navigator.pop(context);
        })
      ],
    );
  }
}
