import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:untitled_goodreads_project/constants.dart';

class WeeklyReadChart extends StatelessWidget {
  final List<dynamic> readCounts;
  final double goal;

  const WeeklyReadChart({Key key, this.readCounts, this.goal})
      : super(key: key);

  final int mon = 0;
  final int tue = 1;
  final int wed = 2;
  final int thu = 3;
  final int fri = 4;
  final int sat = 5;
  final int sun = 6;

  bool checkIfToday(x) {
    return DateTime.now().weekday == (x + 1) ? true : false;
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 20,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: checkIfToday(x) ? kPrimaryColor : Colors.grey,
//        isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: goal,
            color: Colors.grey.withOpacity(.2),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Duration animDuration = const Duration(milliseconds: 250);

    int touchedIndex;

    BarChartData mainBarData() {
      List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
            switch (i) {
              case 0:
                return makeGroupData(0, readCounts[0].toDouble(),
                    isTouched: i == touchedIndex);
              case 1:
                return makeGroupData(1, readCounts[1].toDouble(),
                    isTouched: i == touchedIndex);
              case 2:
                return makeGroupData(2, readCounts[2].toDouble(),
                    isTouched: i == touchedIndex);
              case 3:
                return makeGroupData(3, readCounts[3].toDouble(),
                    isTouched: i == touchedIndex);
              case 4:
                return makeGroupData(4, readCounts[4].toDouble(),
                    isTouched: i == touchedIndex);
              case 5:
                return makeGroupData(5, readCounts[5].toDouble(),
                    isTouched: i == touchedIndex);
              case 6:
                return makeGroupData(6, readCounts[6].toDouble(),
                    isTouched: i == touchedIndex);
              default:
                return null;
            }
          });

      return BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
              tooltipRoundedRadius: 25,
              tooltipBgColor: kPrimaryColor.withOpacity(.7),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay;
                switch (group.x.toInt()) {
                  case 0:
                    weekDay = 'Mon';
                    break;
                  case 1:
                    weekDay = 'Tue';
                    break;
                  case 2:
                    weekDay = 'Wed';
                    break;
                  case 3:
                    weekDay = 'Thu';
                    break;
                  case 4:
                    weekDay = 'Fri';
                    break;
                  case 5:
                    weekDay = 'Sat';
                    break;
                  case 6:
                    weekDay = 'Sun';
                    break;
                }
                return BarTooltipItem(
                    weekDay + ' ' + (rod.y - 1).toInt().toString(),
                    Theme.of(context).textTheme.bodyText1.copyWith(
                        color: kLightBackgroundColor,
                        fontWeight: FontWeight.bold));
              }),
//        touchCallback: (barTouchResponse) {
//          setState(() {
//            if (barTouchResponse.spot != null &&
//                barTouchResponse.touchInput is! FlPanEnd &&
//                barTouchResponse.touchInput is! FlLongPressEnd) {
//              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
//            } else {
//              touchedIndex = -1;
//            }
//          }
//          );
//        },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black26,
                  fontWeight: FontWeight.w900,
                ),
            margin: 16,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'M';
                case 1:
                  return 'T';
                case 2:
                  return 'W';
                case 3:
                  return 'T';
                case 4:
                  return 'F';
                case 5:
                  return 'S';
                case 6:
                  return 'S';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingGroups(),
      );
    }

    return BarChart(
      mainBarData(),
      swapAnimationDuration: animDuration,
    );
  }
}
