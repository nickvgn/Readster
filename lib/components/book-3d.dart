import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';

class Book3D extends StatefulWidget {
  const Book3D({
    Key key,
    @required this.book,
  }) : super(key: key);

  final Book book;

  @override
  _Book3DState createState() => _Book3DState();
}

class _Book3DState extends State<Book3D> with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController animationController2;
  Animation animation;
  Animation animation2;
  Animation animation3;
  Animation animation4;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });

    animation2 = Tween<double>(begin: -0.69, end: pi / 3).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 1, curve: Curves.easeInOutExpo)));
    animation3 = Tween<double>(begin: 10, end: 0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.75, curve: Curves.easeInOutExpo)));
    animation4 = Tween<double>(begin: 5, end: 0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.75, curve: Curves.easeInOutExpo)));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        margin: EdgeInsets.only(bottom: 11.8),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.003)
            ..rotateX(-0.06)
            ..rotateY(animation2?.value ?? -0.69),
//                    ..rotateZ(0.01),
          alignment: FractionalOffset.topCenter,
          child: NeumorphicButton(
            onPressed: () async {
              animationController.forward();
              animationController.addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  Provider.of<BookController>(context, listen: false)
                      .updateBookId(widget.book.id);
                  Navigator.push(
                      context,
                      PageTransition(
                        curve: Curves.bounceInOut,
                        type: PageTransitionType.scale,
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 100),
                        child: DetailsScreen(),
                      ));
                }
              });
//                animationController.addListener(() {
//                  if (animationController.status == animation.isCompleted) {
//
//                  }
//                });
            },
//                    onPressed: () {
//                      onPressed();
//                      Provider.of<BookController>(context, listen: false)
//                          .updateBookId(book.id);
//                      Navigator.push(
//                          context,
//                          PageTransition(
//                            curve: Curves.easeInOutSine,
//                            type: PageTransitionType.scale,
//                            alignment: Alignment.center,
//                            duration: Duration(milliseconds: 100),
//                            child: DetailsScreen(),
//                          ));
//                    },
            padding: EdgeInsets.zero,
            style: kNeumorphicStyle.copyWith(
              shadowLightColor: Colors.transparent,
              boxShape: NeumorphicBoxShape.beveled(
                BorderRadius.only(
                  bottomLeft: Radius.elliptical(11, animation4.value),
                  topLeft: Radius.elliptical(11, animation4.value),
                ),
              ),
              depth: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
//                        boxShadow: [
//                          BoxShadow(
//                            color: color,
//                            spreadRadius: 1,
//                            offset: Offset(-20, -2),
//                          )
//                        ],
                color: widget.book.spineColor,
              ),
              child: Row(
                children: [
                  SizedBox(width: animation3.value),
                  FadeInImage.memoryNetwork(
                    image: widget.book.imageUrl,
                    fit: BoxFit.fill,
                    placeholder: kTransparentImage,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
