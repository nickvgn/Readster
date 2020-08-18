import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class SpinkitWidget extends StatelessWidget {
  const SpinkitWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: kSecondaryColor,
      size: 100.0,
    );
  }
}
