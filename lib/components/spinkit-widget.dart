import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class SpinkitWidget extends StatelessWidget {
  const SpinkitWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index.isOdd ? kPrimaryColor : kSecondaryColor,
          ),
        );
      },
      size: 100.0,
    );
  }
}
