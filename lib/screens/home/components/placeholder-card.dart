import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

class PlaceholderCard extends StatelessWidget {
  const PlaceholderCard({
    Key key,
    this.child,
    this.depthAnimation,
    this.matrix,
  }) : super(key: key);

  final Widget child;
  final Animation depthAnimation;
  final Matrix4 matrix;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: matrix,
      child: Neumorphic(
        style: kNeumorphicStyle.copyWith(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(25),
          ),
          shadowLightColor: Colors.white70,
          depth: depthAnimation.value,
        ),
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kLightBackgroundColor,
            ),
            child: Center(child: child)),
      ),
    );
  }
}
