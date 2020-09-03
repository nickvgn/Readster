import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/search-box.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/search/components/api-selector-tab.dart';
import 'package:untitled_goodreads_project/screens/search/components/search-list.dart';

class SearchScreen extends StatefulWidget {
  final String apiType;

  const SearchScreen({Key key, this.apiType}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    int _selected =
        Provider.of<BookController>(context).apiType == GOODREADS ? 1 : 0;
    String query = '';
    var size = MediaQuery.of(context).size;

    return Consumer<BookController>(builder: (_, bookController, __) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width * .09,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.3),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          SearchBox(
            onChanged: (text) => query = text,
            function: () {
              bookController.updateQuery(query);
            },
          ),
          bookController.query != ''
              ? FutureBuilder<List<Book>>(
                  future: bookController.apiType == GOODREADS
                      ? fetchBooks(http.Client(), bookController.query)
                      : fetchGoogleBooks(http.Client(), bookController.query),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done
                        ? SearchList(books: snapshot.data)
                        : Expanded(child: Center(child: SpinkitWidget()));
                  },
                )
              : Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: FlareActor(
                        "assets/icons/search-4.flr",
                        alignment: Alignment.center,
                        color: kSecondaryColor,
//                    isPaused: isPaused,
                        fit: BoxFit.fitHeight,
                        animation: "tabbar_search",
                      ),
                    ),
                  ),
                ),
          NeumorphicToggle(
            thumb: Container(),
            height: 60,
            width: double.infinity,
            children: [
              ToggleElement(
                foreground: APISelectorTab(
                  title: 'oogle Books',
                  icon: FontAwesomeIcons.google,
                  apiType: GOOGLEBOOKS,
                  color: kPrimaryColor,
                ),
                background: APISelectorTab(
                  title: 'oogle Books',
                  icon: FontAwesomeIcons.google,
                  apiType: GOOGLEBOOKS,
                  color: Colors.grey[700],
                ),
              ),
              ToggleElement(
                foreground: APISelectorTab(
                  title: 'oodreads',
                  icon: FontAwesomeIcons.goodreadsG,
                  apiType: GOODREADS,
                  color: kPrimaryColor,
                ),
                background: APISelectorTab(
                  title: 'oodreads',
                  icon: FontAwesomeIcons.goodreadsG,
                  apiType: GOODREADS,
                  color: Colors.grey[700],
                ),
              )
            ],
            style: NeumorphicToggleStyle(),
            onChanged: (int val) {
              _selected = val;
              val == 0
                  ? Provider.of<BookController>(context, listen: false)
                      .updateApiType(GOOGLEBOOKS)
                  : Provider.of<BookController>(context, listen: false)
                      .updateApiType(GOODREADS);
            },
            selectedIndex: _selected,
          )
        ],
      );
    });
  }
}
