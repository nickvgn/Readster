import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/user.dart';
import 'package:untitled_goodreads_project/screens/home/components/circular-progress-widget.dart';
import 'package:untitled_goodreads_project/screens/home/components/placeholder-card.dart';

class ProgressGridView extends StatelessWidget {
  const ProgressGridView({
    Key key,
    @required this.user,
    this.matrix2,
    this.matrix3,
    this.animation,
  }) : super(key: key);

  final FirebaseUser user;
  final Matrix4 matrix2;
  final Matrix4 matrix3;
  final Animation animation;

  Widget buildProgressCard(BuildContext context, String title, String subtitle,
      int goal, int current) {
    return Transform(
      transform: title == 'Today' ? matrix2 : matrix3,
      child: Neumorphic(
        padding: EdgeInsets.all(20),
        style: kNeumorphicStyle.copyWith(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(25),
            ),
            depth: animation.value,
            shadowLightColor: Colors.white60),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: 24),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: 15, color: Colors.black26),
                ),
                SizedBox(height: 2),
                Expanded(
                  child: CircularProgressWidget(
                      goal: goal.toDouble(), current: current.toDouble()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder<User>(
          stream: FirestoreController.streamUserData(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            var userData = snapshot.data;
            return snapshot.hasData && userData.dailyGoal != 0
                ? GridView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                        top: 5, bottom: 45, left: 20, right: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                    ),
                    children: [
                      buildProgressCard(
                          context,
                          'Today',
                          'pages to read',
                          userData.dailyGoal,
                          userData.weeklyReadCount[DateTime.now().weekday - 1]),
                      buildProgressCard(context, '2020', 'books to finish',
                          userData.yearlyGoal, userData.finishedBooks),
                    ],
                  )
                : Container();
          }),
    );
  }
}
