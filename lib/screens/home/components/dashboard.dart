import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/home/components/circular-progress-widget.dart';
import 'package:untitled_goodreads_project/services/auth.dart';

final AuthService auth = AuthService();

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 45),
            child: FutureBuilder<String>(
              future: auth.getUserName,
              builder: (context, snapshot) => RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Hello \n',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 19,
                              color: kLightPrimaryColor,
                            )),
                    TextSpan(
                        text: snapshot.hasData ? snapshot.data : 'stranger',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 17,
                              color: kLightPrimaryColor,
                              fontWeight: FontWeight.bold,
                            )),
                    TextSpan(
                        text: '\n\n\nYou\'ve read\n',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 19,
                              color: kLightPrimaryColor,
                            )),
                    TextSpan(
                        text: '42',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 35,
                              color: kLightPrimaryColor,
                              fontWeight: FontWeight.bold,
                            )),
                    TextSpan(
                        text: ' pages\n',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 19,
                              color: kLightPrimaryColor,
                            )),
                    TextSpan(
                      text: 'today',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 19,
                            color: kLightPrimaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, top: 20, bottom: 8),
          child: SizedBox(
            height: 215,
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'and that is',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 19,
                        color: kLightPrimaryColor,
                      ),
                ),
                SizedBox(height: 5),
                Neumorphic(
                  margin: EdgeInsets.all(10),
                  style: kNeumorphicStyle.copyWith(
                    depth: 1,
                    color: Colors.transparent,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: CircularProgressWidget(),
                ),
                Text(
                  'percent of your daily goal of',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 19,
                        color: kLightPrimaryColor,
                      ),
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '100',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 25,
                                      color: kLightPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          TextSpan(
                            text: ' pages',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 19,
                                      color: kLightPrimaryColor,
                                    ),
                          )
                        ],
                      ),
                    ),
                    NeumorphicButton(
                      padding: EdgeInsets.only(top: 3, left: 10),
                      style: kNeumorphicStyle.copyWith(
                        depth: 0,
                        color: Colors.transparent,
                      ),
                      child: NeumorphicIcon(
                        MdiIcons.leadPencil,
                        size: 30,
                        style: kNeumorphicStyle.copyWith(
                            color: kLightPrimaryColor, depth: 3),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 30)
      ],
    );
  }
}
