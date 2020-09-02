import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
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
    final isNumeric = RegExp(r'[0-9]');
    return StreamBuilder<User>(
        stream: FirestoreController.streamUserData(user.uid),
        builder: (context, snapshot) {
          User userData = snapshot.data;
          String pages = userData?.dailyGoal.toString();
          String books = userData?.yearlyGoal.toString();
          return user != null
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
                      hintText: pages ?? '0',
                      icon: MdiIcons.bookOpenPageVariant,
                      onChanged: (text) => pages = text,
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
                      hintText: books ?? '0',
                      icon: MdiIcons.bookVariantMultiple,
                      onChanged: (text) => books = text,
                    ),
                    Spacer(),
                    buildConfirmationButton('Save', context, () {
                      if (!(isNumeric.hasMatch(pages) &&
                          isNumeric.hasMatch(books))) {
                        Fluttertoast.showToast(
                          backgroundColor: kPrimaryColor,
                          msg: "Erm.. that's not a number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                        );
                      } else {
                        Provider.of<FirestoreController>(context, listen: false)
                            .updateGoal(
                          int.tryParse(pages),
                          int.tryParse(books),
                        );
                        Navigator.pop(context);
                      }
                    })
                  ],
                )
              : SpinkitWidget();
        });
  }
}
