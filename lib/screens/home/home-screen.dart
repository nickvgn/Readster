import 'package:carousel_slider/carousel_slider.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/home/components/home-app-bar.dart';
import 'package:untitled_goodreads_project/screens/home/components/my-books-card.dart';
import 'package:untitled_goodreads_project/screens/home/components/progress-grid-view.dart';
import 'package:untitled_goodreads_project/screens/home/components/weekly-chart-card.dart';
import 'package:untitled_goodreads_project/services/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final AuthService auth = AuthService();
  bool isFadeIn = false;
  var fadeController = FadeInController();
  AnimationController controller;

  Animation depthAnimation;
  Animation scaleAnimation1;
  Animation scaleAnimation2;
  Animation scaleAnimation3;
  Animation scaleAnimation4;

  @override
  void initState() {
    super.initState();

    FirestoreController().setReadCountList();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isFadeIn = true;
      });
      fadeController.fadeIn();
    });

    controller = AnimationController(
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      vsync: this,
    );

    depthAnimation = Tween<double>(begin: -1, end: 1.5).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo));
    scaleAnimation1 = Tween<double>(begin: 0.9, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut));
    scaleAnimation2 = Tween<double>(begin: 0.9, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut));
    scaleAnimation3 = Tween<double>(begin: 0.9, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad));
    scaleAnimation4 = Tween<double>(begin: 0.9, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));

    var user = Provider.of<FirebaseUser>(context);
    var size = MediaQuery.of(context).size;

    Matrix4 myMatrix = Matrix4Transform()
        .scaleBy(
            x: scaleAnimation1.value,
            y: scaleAnimation2.value,
            origin: Offset(200, 100))
        .matrix4;
    Matrix4 myMatrix2 = Matrix4Transform()
        .scaleBy(
            x: scaleAnimation1.value,
            y: scaleAnimation4.value,
            origin: Offset(100, 100))
        .matrix4;
    Matrix4 myMatrix3 = Matrix4Transform()
        .scaleBy(
            x: scaleAnimation3.value,
            y: scaleAnimation2.value,
            origin: Offset(100, 100))
        .matrix4;

    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            height: size.height * .52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kSecondaryColor],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              HomeAppBar(
                user: user,
                fadeController: fadeController,
              ),
              Expanded(
                child: FadingEdgeScrollView.fromScrollView(
                  child: ListView(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      user != null
                          ? StreamBuilder<List<Book>>(
                              stream: FirestoreController.streamBooksByStatus(
                                  user.uid, READING),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) print(snapshot.error);
                                var books = snapshot.data;
                                return snapshot.hasData &&
                                        snapshot.data.length != 0
                                    ? buildCarousel(
                                        autoPlay: true,
                                        items: books,
                                        itemBuilder: (context, index) =>
                                            Transform(
                                              transform: myMatrix,
                                              child: MyBooksCard(
                                                book: books[index],
                                                isFadeIn: isFadeIn,
                                                animation: depthAnimation,
                                              ),
                                            ))
                                    : FadeIn(
                                        child: Transform(
                                          transform: myMatrix,
                                          child: Neumorphic(
                                            margin: EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 20,
                                                right: 20),
                                            style: kNeumorphicStyle.copyWith(
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(25),
                                              ),
                                              depth: depthAnimation.value,
                                              shadowLightColor: Colors.white60,
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(30),
                                              decoration: BoxDecoration(
                                                color: kLightBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: SizedBox(
                                                height: 110,
                                                child: Center(
                                                  child: Text(
                                                    'Hmm.. Looks empty. Why don\'t you read a book?',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                          color: Colors.black26,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                              })
                          : SpinkitWidget(),
                      user != null
                          ? ProgressGridView(
                              user: user,
                              matrix2: myMatrix2,
                              matrix3: myMatrix3,
                              animation: depthAnimation,
                            )
                          : Container(),
                      Transform(
                        transform: myMatrix,
                        child: AspectRatio(
                          aspectRatio: 1.7,
                          child: WeeklyChartCard(
                            size: size,
                            user: user,
                            depthAnimation: depthAnimation,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .02),
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

  Widget buildCarousel({
    List<dynamic> items,
    Function itemBuilder,
    bool autoPlay,
    Function onPageChanged,
  }) {
    return SizedBox(
      height: 205,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: items.length,
        itemBuilder: itemBuilder,
        options: CarouselOptions(
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          autoPlayInterval: Duration(seconds: 10),
          autoPlayCurve: Curves.easeInOutSine,
          autoPlay: autoPlay,
          pauseAutoPlayOnManualNavigate: true,
          initialPage: 0,
          viewportFraction: 0.95,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}
