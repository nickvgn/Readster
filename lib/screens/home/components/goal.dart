import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/user.dart';
import 'package:untitled_goodreads_project/screens/home/components/neumorphic-text-field.dart';

class Goal extends StatelessWidget {
  const Goal({
    Key key,
    this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirestoreController.streamUserData(user.uid),
        builder: (context, snapshot) {
          User userData = snapshot.data;
          return snapshot.hasData && user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Set a goal',
                      style: Theme.of(context).textTheme.headline6.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pages I want to read everyday:',
                      ),
                    ),
                    NeumorphicTextField(
                      hintText: userData.dailyGoal.toString(),
                      icon: MdiIcons.bookOpenPageVariant,
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Books I want to finished this year:',
                      ),
                    ),
                    NeumorphicTextField(
                      hintText: userData.yearlyGoal.toString(),
                      icon: MdiIcons.bookVariantMultiple,
                    ),
                    Spacer(),
                    buildConfirmationButton('Save', context, () {})
                  ],
                )
              : SpinkitWidget();
        });
  }
}
