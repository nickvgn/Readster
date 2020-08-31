import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:untitled_goodreads_project/components/bottom-nav-bar.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/screens/collection/collection-screen.dart';
import 'package:untitled_goodreads_project/screens/home/components/app-bar-title.dart';
import 'package:untitled_goodreads_project/screens/home/home-screen.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _selectedItemPosition = 0;

  final _screens = [
    HomeScreen(),
    CollectionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screens[_selectedItemPosition],
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            bottom: 1,
            left: 15,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: BottomNavBar(),
            ),
          ),
          SnakeNavigationBar(
            elevation: 0,
            style: SnakeBarStyle.floating,
            snakeShape: SnakeShape.circle,
            snakeColor: kPrimaryColor,
            backgroundColor: kLightBackgroundColor,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 230),
            currentIndex: _selectedItemPosition,
            onPositionChanged: (index) {
              setState(() {
                _selectedItemPosition = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FlareActor(
                    "assets/icons/home-4.flr",
                    alignment: Alignment.center,
                    color: kSecondaryColor,
//                    isPaused: isPaused,
                    fit: BoxFit.fitHeight,
                    animation: "Untitled",
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    MdiIcons.bookshelf,
                    size: 35,
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
