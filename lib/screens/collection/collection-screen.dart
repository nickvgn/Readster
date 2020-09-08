import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/screens/collection/booklist.dart';
import 'package:untitled_goodreads_project/screens/collection/bookshelf.dart';
import 'package:untitled_goodreads_project/screens/collection/components/book-search.dart';

class CollectionScreen extends StatefulWidget {
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                      child: IconButton(
                        splashColor: kPrimaryColor,
                        color: kPrimaryColor,
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(
                            MdiIcons.bookSearch,
                          ),
                        ),
                        onPressed: () => showSearch(
                          context: context,
                          delegate: BookSearch(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            toolbarHeight: 90,
            elevation: 0,
            backgroundColor: kLightBackgroundColor,
            actions: [
              IconButton(
                splashColor: kPrimaryColor,
                color: kPrimaryColor,
                icon: Icon(
                  Provider.of<BookController>(context).bookView == SHELF
                      ? MdiIcons.viewList
                      : MdiIcons.viewGrid,
                ),
                onPressed: () {
                  Provider.of<BookController>(context, listen: false)
                      .updateBookView();
                },
              ),
              SizedBox(width: 14)
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
                Tab(text: 'Reading'),
                Tab(text: 'Read Later'),
                Tab(text: 'Read'),
              ],
            ),
          ),
          Expanded(
            child: Consumer<BookController>(builder: (_, bookController, __) {
              return TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  bookController.bookView == LIST
                      ? BookList(status: READING)
                      : Bookshelf(status: READING),
                  bookController.bookView == LIST
                      ? BookList(status: TOREAD)
                      : Bookshelf(status: TOREAD),
                  bookController.bookView == LIST
                      ? BookList(status: READ)
                      : Bookshelf(status: READ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
