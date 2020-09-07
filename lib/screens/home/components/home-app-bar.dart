import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/home/components/app-bar-title.dart';
import 'package:untitled_goodreads_project/screens/home/components/pop-up-settings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key key,
    @required this.user,
    @required this.fadeController,
  }) : super(key: key);

  final FirebaseUser user;
  final FadeInController fadeController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 110,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kLightBackgroundColor,
                  shape: BoxShape.circle,
                ),
              ),
              Neumorphic(
                style: kNeumorphicStyle.copyWith(
                  depth: 1,
                  shape: NeumorphicShape.convex,
                  border:
                      NeumorphicBorder(color: kLightBackgroundColor, width: 3),
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: user != null
                    ? CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: CachedNetworkImage(
                          imageUrl: user?.photoUrl,
                          imageBuilder: (context, __) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              user?.photoUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          fadeInDuration: Duration(milliseconds: 100),
                          placeholderFadeInDuration: Duration(microseconds: 1),
                          placeholder: (context, _) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/user_placeholder.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        radius: 21,
                      )
                    : Container(),
              ),
            ],
          ),
          SizedBox(
            width: size.width * .6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: AppBarTitle(),
                ),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: FadeIn(
                      controller: fadeController,
                      duration: Duration(milliseconds: 800),
                      child: Text(
                        'What are we reading today?',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: kLightBackgroundColor, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          PopUpSettings(
            user: user,
            icon: Icon(
              MdiIcons.cog,
              color: kLightBackgroundColor,
              size: 46,
            ),
          )
        ],
      ),
    );
  }
}
