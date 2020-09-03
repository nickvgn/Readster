import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
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
  String imageUrl = '';
  String day = 'today';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) async {}

  showNotification(String bookTitle, DateTime dateTime) async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        autoCancel: true,
        styleInformation: BigTextStyleInformation(
            'This is the book: 📖 $bookTitle. \nHope you have an amazing time. 😊'));
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.schedule(
        0, 'Let\'s read!', '', dateTime, platform);
  }

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: 'Remind me to read',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextSpan(
              text: ' $bookTitle',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.bold, color: kSecondaryColor),
            ),
            TextSpan(
              text: ' at',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextSpan(
              text: ' ${DateFormat().add_jm().format(dateTime)}',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
            ),
            TextSpan(
              text: ' $day.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ]),
        ),
        Spacer(),
        if (widget.user != null)
          StreamBuilder<List<Book>>(
              stream: FirestoreController.streamBooksByStatus(
                  widget.user.uid, READING),
              builder: (context, snapshot) {
                var readingBooks = snapshot.data;
                return snapshot.hasData
                    ? CarouselSlider.builder(
                        itemCount: readingBooks.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 300,
                          child: Neumorphic(
                            style: kNeumorphicStyle.copyWith(
                              depth: 3,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(5),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            child: FadeInImage.memoryNetwork(
                              image: readingBooks[index].imageUrl,
                              placeholder: kTransparentImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          onPageChanged: (val, reason) {
                            if (readingBooks != null) {
                              setState(() {
                                bookTitle = readingBooks[val].title;
                                imageUrl = readingBooks[val].imageUrl;
                              });
                            }
                          },
                          height: 180,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayInterval: Duration(seconds: 10),
                          autoPlayCurve: Curves.easeInOutSine,
                          pauseAutoPlayOnManualNavigate: true,
                          initialPage: 0,
                          viewportFraction: 0.35,
                        ),
                      )
                    : Container();
              }),
        Spacer(),
        SizedBox(
          height: 70,
          child: CupertinoDatePicker(
            minimumDate: DateTime.now(),
            maximumDate: DateTime.now().add(Duration(days: 1)),
            onDateTimeChanged: (DateTime datetime) {
              setState(() {
                dateTime = datetime;
                dateTime.day == DateTime.now().day
                    ? day = 'today'
                    : day = 'tomorrow';
              });
            },
          ),
        ),
        SizedBox(height: 30),
        buildConfirmationButton('Save', context, () {
          if (bookTitle == 'a book') {
            Fluttertoast.showToast(
              backgroundColor: kPrimaryColor,
              msg: "Select a book by sliding the carousel.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
            );
          } else {
            showNotification(bookTitle, dateTime);
            Fluttertoast.showToast(
              backgroundColor: kPrimaryColor,
              msg: "Success",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
            );
            Navigator.pop(context);
          }
        }),
        SizedBox(height: 10)
      ],
    );
  }
}
