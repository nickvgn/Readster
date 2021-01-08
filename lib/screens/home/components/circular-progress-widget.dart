import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:untitled_goodreads_project/constants.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({
    Key key,
    this.goal,
    this.current,
  }) : super(key: key);

  final double goal, current;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        spinnerDuration: 500,
        size: size.width * 0.25,
        startAngle: 270,
        angleRange: 365,
        customWidths: CustomSliderWidths(
          progressBarWidth: 15,
          trackWidth: 15,
        ),
        customColors: CustomSliderColors(
            progressBarColors: [kPrimaryColor, kPrimaryColor],
            shadowColor: kLightBackgroundColor,
            trackColor: Colors.grey.withOpacity(.2),
            dotColor: Colors.transparent),
      ),
      min: 0,
      max: goal == 0 ? 0.5 : goal,
      initialValue: current > goal ? goal : current < 0 ? 0 : current,
      innerWidget: (double progress) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${current <= 0 ? 0 : current.toInt()}',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontSize: 21,
                        ),
                  ),
                  TextSpan(
                    text: '/${goal.toInt()}',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontSize: 11,
                        ),
                  ),
//                    TextSpan(
//                      text: ' %',
//                      style: Theme.of(context).textTheme.subtitle2.copyWith(
//                            fontSize: 20,
//                            color: kLightPrimaryColor,
//                          ),
//                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
