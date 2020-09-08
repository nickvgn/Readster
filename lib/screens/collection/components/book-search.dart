import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/collection/components/collection-book.dart';

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
        splashColor: kPrimaryColor,
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
      splashColor: kPrimaryColor,
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
                        itemCount: 1,
                        itemBuilder: (context, index) => CollectionBook(
                          book: results[0],
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

              final results = snapshot?.data
                  ?.where((book) => (book.title + book.author)
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  ?.toList();
              return snapshot.hasData
                  ? FadingEdgeScrollView.fromScrollView(
                      child: ListView.builder(
                        controller: controller,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        physics: BouncingScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, index) => ShowResOnTap(
                          results: results,
                          index: index,
                          setQuery: () {
                            query = results[index].title;
                          },
                        ),
                      ),
                    )
                  : Container();
            },
          )
        : Container();
  }
}

class ShowResOnTap extends StatefulWidget {
  const ShowResOnTap({
    Key key,
    @required this.results,
    this.index,
    this.query,
    this.setQuery,
  }) : super(key: key);

  final List<Book> results;
  final int index;
  final String query;
  final Function setQuery;

  @override
  _ShowResOnTapState createState() => _ShowResOnTapState();
}

class _ShowResOnTapState extends State<ShowResOnTap> {
  bool showRes = false;

  @override
  Widget build(BuildContext context) {
    return !showRes
        ? ListTile(
            visualDensity: VisualDensity(
              vertical: VisualDensity.maximumDensity,
            ),
            title: Text(widget.results[widget.index].title),
            leading: Neumorphic(
              padding: EdgeInsets.zero,
              style: kNeumorphicStyle.copyWith(
                  depth: 1,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(3))),
              child: FadeInImage.memoryNetwork(
                image: widget.results[widget.index].imageUrl,
                placeholder: kTransparentImage,
              ),
            ),
            subtitle: Text(widget.results[widget.index].author),
            trailing: Icon(
                widget.results[widget.index].readStatus == READING
                    ? MdiIcons.bookOpenPageVariant
                    : widget.results[widget.index].readStatus == READ
                        ? MdiIcons.read
                        : MdiIcons.book,
                color: kSecondaryColor),
            contentPadding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
            onTap: () {
              setState(() {
                showRes = true;
              });
              widget.setQuery();
            },
          )
        : CollectionBook(
            book: widget.results[widget.index],
          );
  }
}
