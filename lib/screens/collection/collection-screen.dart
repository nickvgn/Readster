import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/collection/booklist.dart';
import 'package:untitled_goodreads_project/screens/collection/bookshelf.dart';
import 'package:untitled_goodreads_project/screens/collection/components/collection-book.dart';

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
                      child: NeumorphicButton(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle(),
                          depth: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(
                            MdiIcons.bookSearch,
                            color: kPrimaryColor,
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
            backgroundColor: Colors.transparent,
            actions: [
              NeumorphicButton(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 0,
                ),
                child: Icon(
                  Provider.of<BookController>(context).bookView == SHELF
                      ? MdiIcons.viewList
                      : MdiIcons.viewGrid,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Provider.of<BookController>(context, listen: false)
                      .updateBookView();
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
                Tab(text: 'Reading'),
                Tab(text: 'Read Later'),
                Tab(text: 'Read'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
          ),
        ],
      ),
    );
  }
}

class BookSearch extends SearchDelegate<List<Book>> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          primaryColor: kLightBackgroundColor,
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(FontAwesomeIcons.undo),
        iconSize: 20,
        color: kPrimaryColor,
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.angleLeft),
      color: kPrimaryColor,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    final controller = ScrollController();

    return user != null
        ? StreamBuilder<List<Book>>(
            stream: FirestoreController.streamBooks(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              final results = snapshot.data
                  .where((book) =>
                      book.title.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              return snapshot.hasData
                  ? FadingEdgeScrollView.fromScrollView(
                      child: ListView.builder(
                        controller: controller,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        physics: BouncingScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, index) => CollectionBook(
                          book: results[index],
                        ),
                      ),
                    )
                  : Container();
            },
          )
        : Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final controller = ScrollController();
    var user = Provider.of<FirebaseUser>(context);

    return user != null
        ? StreamBuilder<List<Book>>(
            stream: FirestoreController.streamBooks(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              final results = snapshot.data
                  .where((book) => (book.title + book.author)
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
              return snapshot.hasData
                  ? FadingEdgeScrollView.fromScrollView(
                      child: ListView.builder(
                        controller: controller,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        physics: BouncingScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, index) => CollectionBook(
                          book: results[index],
                        ),
                      ),
                    )
                  : Container();
            },
          )
        : Container();
  }
}
