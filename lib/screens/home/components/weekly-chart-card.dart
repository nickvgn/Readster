import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/user.dart';
import 'package:untitled_goodreads_project/screens/home/components/date-of-today.dart';
import 'package:untitled_goodreads_project/screens/home/components/weekly-read-chart.dart';

class WeeklyChartCard extends StatelessWidget {
  const WeeklyChartCard({
    Key key,
    @required this.size,
    @required this.user,
    this.depthAnimation,
  }) : super(key: key);

  final Size size;
  final FirebaseUser user;
  final Animation depthAnimation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirestoreController.streamUserData(user?.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData && snapshot.data.dailyGoal != 0
              ? Neumorphic(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  style: kNeumorphicStyle.copyWith(
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(25),
                    ),
                    depth: depthAnimation.value,
                    shadowLightColor: Colors.white60,
                  ),
                  child: Column(
                    children: [
                      DateOfToday(),
                      SizedBox(height: 10),
                      Flexible(
                        child: WeeklyReadChart(
                          readCounts: snapshot.data.weeklyReadCount,
                          goal: snapshot.data.dailyGoal.toDouble(),
                        ),
                      ),
                    ],
                  ))
              : Container();
        });
  }
}
