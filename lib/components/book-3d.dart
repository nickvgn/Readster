import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/collection/components/blurred-modal-fade.dart';
import 'package:untitled_goodreads_project/screens/collection/components/progress-modal-content.dart';
import 'package:untitled_goodreads_project/screens/details/components/read-confirm.dart';
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

class _Book3DState extends State<Book3D> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  AnimationController animationController2;
  Animation animation;
  Animation animation2;
  Animation animation3;
  Animation animation4;
  Animation curvedAnimation;
  var sliderValue = 0.5;

  @override
  void initState() {
    super.initState();

    sliderValue =
        ((widget.book.pageRead / widget.book.pageCount) * 10).toDouble();

    animationController = AnimationController(
      duration: Duration(milliseconds: 700),
      lowerBound: 0,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    animation2 = Tween<double>(begin: -0.69, end: pi / 2).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 1, curve: Curves.easeInOutExpo)));
    animation3 = Tween<double>(begin: 10, end: 0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.75, curve: Curves.easeInOutExpo)));
    animation4 = Tween<double>(begin: 5, end: 0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.75, curve: Curves.easeInOutExpo)));
    curvedAnimation = CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 1, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return FlipView(
      animationController: curvedAnimation,
      back: FittedBox(
        child: SizedBox(
          height: 135,
          width: 85,
          child: Neumorphic(
            style: kNeumorphicStyle.copyWith(
                shadowLightColor: Colors.transparent,
                color: widget.book.spineColor,
                boxShape: NeumorphicBoxShape.rect()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  onPressed: () {
                    animationController.reverse();
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
                  },
                  style: kNeumorphicStyle.copyWith(
                      color: Colors.transparent, depth: 0),
                  child: NeumorphicIcon(
                    MdiIcons.bookInformationVariant,
                    style: kNeumorphicStyle.copyWith(
                      shadowLightColor: Colors.white60,
                      color: widget.book.spineColor.computeLuminance() > .3
                          ? Colors.black87
                          : kLightBackgroundColor,
                    ),
                  ),
                ),
                if (widget.book.readStatus == READING)
                  NeumorphicButton(
                    onPressed: () async {
                      animationController.reverse();
                      dynamic received = await Navigator.of(context).push(
                        buildBlurredModalFade(
                          child: ProgressModalContent(
                            book: widget.book,
                            sliderValue: sliderValue,
                          ),
                        ),
                      );
                      if (received != null)
                        received != READ
                            ? setState(() {
                                sliderValue = received;
                              })
                            : setState(() {});
                    },
                    style: kNeumorphicStyle.copyWith(
                        color: Colors.transparent, depth: 0),
                    child: NeumorphicIcon(
                      MdiIcons.pencilCircleOutline,
                      style: kNeumorphicStyle.copyWith(
                        shadowLightColor: Colors.white60,
                        color: widget.book.spineColor.computeLuminance() > .3
                            ? Colors.black87
                            : kLightBackgroundColor,
                      ),
                    ),
                  ),
                if (widget.book.readStatus == READ ||
                    widget.book.readStatus == TOREAD)
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        buildReadConfirmModal(
                            context,
                            'This book will be added to your \'Reading\' collection.',
                            READING,
                            widget.book,
                            user),
                      );
                      animationController.reverse();
                    },
                    style: kNeumorphicStyle.copyWith(
                        color: Colors.transparent, depth: 0),
                    child: NeumorphicIcon(
                      MdiIcons.bookOpenPageVariant,
                      style: kNeumorphicStyle.copyWith(
                        shadowLightColor: Colors.white60,
                        color: widget.book.spineColor.computeLuminance() > .3
                            ? Colors.black87
                            : kLightBackgroundColor,
                      ),
                    ),
                  ),
                NeumorphicButton(
                  onPressed: () => animationController.reverse(),
                  style: kNeumorphicStyle.copyWith(
                      color: Colors.transparent, depth: 0),
                  child: NeumorphicIcon(
                    MdiIcons.flipToBack,
                    style: kNeumorphicStyle.copyWith(
                      shadowLightColor: Colors.white60,
                      color: widget.book.spineColor.computeLuminance() > .3
                          ? Colors.black87
                          : kLightBackgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      front: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          margin: EdgeInsets.only(bottom: 11.8),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.003)
              ..rotateX(-0.06)
              ..rotateY(animation2?.value ?? -0.69),
            alignment: FractionalOffset.topCenter,
            child: NeumorphicButton(
              onPressed: () async => animationController.forward(),
              padding: EdgeInsets.zero,
              style: kNeumorphicStyle.copyWith(
                shadowLightColor: Colors.transparent,
                boxShape: NeumorphicBoxShape.beveled(
                  BorderRadius.only(
                    bottomLeft: Radius.elliptical(11, animation4.value),
                    topLeft: Radius.elliptical(11, animation4.value - 3),
                  ),
                ),
                depth: 7,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.book.spineColor,
                ),
                child: Row(
                  children: [
                    SizedBox(width: animation3.value),
                    FadeInImage.memoryNetwork(
                      image: widget.book.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
