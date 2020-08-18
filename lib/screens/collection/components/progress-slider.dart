import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled_goodreads_project/constants.dart';

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({
    Key key,
    @required this.isUpdate,
    @required this.sliderValue,
    this.onChanged,
    this.onChangedEnd,
  }) : super(key: key);

  final bool isUpdate;
  final double sliderValue;
  final Function onChanged;
  final Function onChangedEnd;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * .65,
      child: isUpdate == true
          ? NeumorphicSlider(
              style: SliderStyle(
                thumbBorder: NeumorphicBorder(
                  color: kSecondaryColor,
                  width: 16,
                ),
              ),
              thumb: NeumorphicIcon(
                FontAwesomeIcons.font,
              ),
              value: sliderValue,
              height: 5,
              onChanged: (value) => onChanged(value),
              onChangeEnd: (value) => onChangedEnd(value),
            )
          : NeumorphicProgress(
              duration: Duration(seconds: 2),
              height: 5,
              percent: sliderValue / 10,
            ),
    );
  }
}
