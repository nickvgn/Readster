import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/blurred-modal.dart';
import 'package:untitled_goodreads_project/components/bottom-nav-bar.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/controller/weekday-controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/models/quote.dart';
import 'package:untitled_goodreads_project/models/user.dart';
import 'package:untitled_goodreads_project/screens/collection/collection-screen.dart';
import 'package:untitled_goodreads_project/screens/home/components/app-bar-title.dart';
import 'package:untitled_goodreads_project/screens/home/components/at-a-glance-card.dart';
import 'package:untitled_goodreads_project/screens/home/components/circular-progress-widget.dart';
import 'package:untitled_goodreads_project/screens/home/components/my-books-card.dart';
import 'package:untitled_goodreads_project/screens/home/components/quote-card.dart';
import 'package:untitled_goodreads_project/screens/home/components/weekly-read-chart.dart';
import 'package:untitled_goodreads_project/screens/login/login-screen.dart';
import 'package:untitled_goodreads_project/services/auth.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService auth = AuthService();
  bool isFadeIn = false;

  @override
  void initState() {
    super.initState();

    FirestoreController().setReadCountList();

    Future.delayed(const Duration(milliseconds: 20), () {
      setState(() {
        isFadeIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            height: size.height * .52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryColor],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBarTitle(),
                    Spacer(),
                    NeumorphicButton(
                      style: kNeumorphicStyle.copyWith(
                          depth: 0, color: Colors.transparent),
                      child: NeumorphicIcon(
                        MdiIcons.accountEdit,
                        style: kNeumorphicStyle.copyWith(depth: 3),
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          buildBlurredModal(
                            height: size.height / 3,
                            width: size.width / 1.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Set a goal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(),
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                NeumorphicTextField(
                                  hintText: 'Daily pages',
                                  icon: MdiIcons.bookOpen,
                                ),
                                SizedBox(height: 20),
                                NeumorphicTextField(
                                  hintText: 'Yearly books',
                                  icon: MdiIcons.bookMultiple,
                                ),
                                Spacer(),
                                buildConfirmationButton('Save', context, () {})
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    NeumorphicButton(
                      style: kNeumorphicStyle.copyWith(
                          depth: 0, color: Colors.transparent),
                      child: NeumorphicIcon(
                        FontAwesomeIcons.signOutAlt,
                        style: kNeumorphicStyle.copyWith(depth: 3),
                        size: 30,
                      ),
                      onPressed: () async {
                        await auth.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.scale,
                            ),
                            (route) => false);
                      },
                    ),
                    SizedBox(width: 5),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 52,
                          decoration: BoxDecoration(
                            color: kLightBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Neumorphic(
                            style: kNeumorphicStyle.copyWith(
                              depth: 1,
                              shape: NeumorphicShape.convex,
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            child: user != null && isFadeIn
                                ? CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: CachedNetworkImage(
                                      imageUrl: user.photoUrl,
                                      imageBuilder: (context, __) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          user.photoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      fadeInDuration:
                                          Duration(milliseconds: 100),
                                      placeholderFadeInDuration:
                                          Duration(microseconds: 1),
                                      placeholder: (context, _) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/user_placeholder.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    radius: 23,
                                  )
                                : Container()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (isFadeIn)
                Expanded(
                  child: FadeIn(
                    duration: Duration(milliseconds: 100),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: size.width * .95,
                            child: Neumorphic(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 20),
                              style: kNeumorphicStyle.copyWith(
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(25),
                                ),
                                depth: 3,
                              ),
                              child: StreamBuilder<User>(
                                  stream: FirestoreController.streamUserData(
                                      user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError)
                                      print(snapshot.error);
                                    return snapshot.hasData
                                        ? WeeklyReadChart(
                                            readCounts:
                                                snapshot.data.weeklyReadCount,
                                            goal: snapshot.data.dailyGoal
                                                .toDouble(),
                                          )
                                        : Container();
                                  }),
                            ),
                          ),
                        ),
                        user != null
                            ? Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 13),
                                  child: StreamBuilder<User>(
                                      stream:
                                          FirestoreController.streamUserData(
                                              user.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError)
                                          print(snapshot.error);
                                        var userData = snapshot.data;
                                        return snapshot.hasData
                                            ? GridView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
//                                mainAxisAlignment: MainAxisAlignment.center,
                                                padding: EdgeInsets.only(
                                                    top: 25,
                                                    bottom: 5,
                                                    left: 20,
                                                    right: 20),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1,
                                                  crossAxisSpacing: 10,
                                                ),
                                                children: [
                                                  buildProgressCard(
                                                      context,
                                                      'Today',
                                                      'pages to read',
                                                      userData.dailyGoal,
                                                      userData.weeklyReadCount[
                                                          DateTime.now()
                                                                  .weekday -
                                                              1]),
                                                  buildProgressCard(
                                                      context,
                                                      '2020',
                                                      'books to finish',
                                                      userData.yearlyGoal,
                                                      userData.finishedBooks),
                                                ],
                                              )
                                            : Container();
                                      }),
                                ),
                              )
                            : Container(),
                        user != null
                            ? Expanded(
                                child: FadeIn(
                                  duration: Duration(milliseconds: 2000),
                                  child: StreamBuilder<List<Book>>(
                                      stream: FirestoreController
                                          .streamBooksByStatus(
                                              user.uid, READING),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError)
                                          print(snapshot.error);
                                        var books = snapshot.data;
                                        return snapshot.hasData
                                            ? buildCarousel(
                                                autoPlay: true,
                                                items: books.length == 0
                                                    ? quotes
                                                    : books,
                                                itemBuilder: books.length != 0
                                                    ? (context, index) =>
                                                        MyBooksCard(
                                                          book: books[index],
                                                        )
                                                    : (context, index) =>
                                                        QuoteCard(
                                                          quote: quotes[index],
                                                        ))
                                            : Container();
                                      }),
                                ),
                              )
                            : SpinkitWidget()
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProgressCard(BuildContext context, String title, String subtitle,
      int goal, int current) {
    return Neumorphic(
      padding: EdgeInsets.all(20),
      style: kNeumorphicStyle.copyWith(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(25),
        ),
        depth: 3,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontSize: 26),
              ),
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontSize: 15, color: Colors.black26),
              ),
              SizedBox(height: 2),
              Expanded(
                child: CircularProgressWidget(
                    goal: goal.toDouble(), current: current.toDouble()),
              ),
            ],
          ),
//          Align(
//            alignment: Alignment.bottomRight,
//            child: Padding(
//              padding: const EdgeInsets.only(bottom: 10),
//              child: NeumorphicIcon(
//                MdiIcons.leadPencil,
//                style: kNeumorphicStyle.copyWith(color: kSecondaryColor),
//                size: 25,
//              ),
//            ),
//          )
        ],
      ),
    );
  }

  Widget buildCarousel(
      {List<dynamic> items,
      Function itemBuilder,
      bool autoPlay,
      Function onPageChanged,
      Function color}) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: items.length,
        itemBuilder: itemBuilder,
        options: CarouselOptions(
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayInterval: Duration(seconds: 10),
          autoPlayCurve: Curves.easeInOutSine,
          autoPlay: autoPlay,
          pauseAutoPlayOnManualNavigate: true,
          initialPage: 0,
          aspectRatio: 0.9,
//            viewportFraction: 0.95,
          viewportFraction: 0.87,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}

class NeumorphicTextField extends StatelessWidget {
  const NeumorphicTextField({
    Key key,
    this.icon,
    this.hintText,
  }) : super(key: key);

  final IconData icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();

    return Neumorphic(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      style: kNeumorphicStyle.copyWith(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(25),
        ),
        depth: -5,
        shape: NeumorphicShape.concave,
      ),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            onPressed: () {
              _controller.clear();
              FocusScope.of(context).unfocus();
            },
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: kDarkTextColor),
        ),
      ),
    );
  }
}
