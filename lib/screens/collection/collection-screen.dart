import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/bottom-nav-bar.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/screens/collection/booklist.dart';
import 'package:untitled_goodreads_project/screens/collection/bookshelf.dart';
import 'package:untitled_goodreads_project/screens/home/home-screen.dart';

class CollectionScreen extends StatefulWidget {
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          AppBar(
            leading: Container(),
            brightness: Brightness.light,
            title: Text(
              'Library',
              style:
                  Theme.of(context).textTheme.headline5.copyWith(fontSize: 20),
            ),
            centerTitle: true,
            flexibleSpace: SafeArea(
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 80,
                      child: NeumorphicButton(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle(),
                          depth: 0,
                        ),
                        child: Icon(
                          FontAwesomeIcons.angleLeft,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            toolbarHeight: 90,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              NeumorphicButton(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 0,
                ),
                child: Icon(
                  MdiIcons.filterVariant,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Provider.of<BookController>(context, listen: false)
                      .updateReadStatusState();
                  Fluttertoast.showToast(
                    backgroundColor: kPrimaryColor,
                    msg: Provider.of<BookController>(context, listen: false)
                        .readStatus,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                  );
                },
              ),
              SizedBox(width: 15)
            ],
          ),
          SizedBox(
            height: 50,
            child: TabBar(
              labelColor: kPrimaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                color: Colors.transparent,
              )),
              tabs: [
                Tab(text: 'Recent'),
                Tab(text: 'Bookshelf'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  BookList(),
                  Bookshelf(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
