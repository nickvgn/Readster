import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';

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
          suffixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
//            onPressed: () {
//              _controller.clear();
//              FocusScope.of(context).unfocus();
//            },
//          ),
          hintText: hintText,
          hintStyle: TextStyle(color: kDarkTextColor),
        ),
      ),
    );
  }
}
