import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled_goodreads_project/components/bottom-nav-bar.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/collection/booklist.dart';
import 'package:untitled_goodreads_project/screens/collection/bookshelf.dart';

class CollectionScreen extends StatelessWidget {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          brightness: Brightness.light,
          title: Text(
            'Library',
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 20),
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
                      ),
                      child: Icon(
                        FontAwesomeIcons.angleLeft,
                        color: kSecondaryColor,
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
              ),
              child: Icon(
                FontAwesomeIcons.ellipsisV,
                color: kSecondaryColor,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 15)
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                labelColor: kSecondaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                  color: Theme.of(context).indicatorColor,
                  style: BorderStyle.solid,
                )),
                tabs: [
                  Tab(text: 'Recent'),
                  Tab(text: 'Bookshelf'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  BookList(),
                  Bookshelf(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
