import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/models/genre.dart';
import 'package:untitled_goodreads_project/screens/details/components/book-suggestions-list.dart';
import 'package:untitled_goodreads_project/screens/details/components/description-card.dart';
import 'package:untitled_goodreads_project/screens/details/components/more-info.dart';
import 'package:untitled_goodreads_project/screens/details/components/sliver-title-bar.dart';
import 'package:untitled_goodreads_project/services/text-helper.dart';

class DetailsScreen extends StatefulWidget {
  final String isbn;

  const DetailsScreen({Key key, this.isbn}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFadeIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bookId = Provider.of<BookController>(context).bookId;
    final controller = ScrollController();
    List<Genre> genreList = [];

    return Scaffold(
      body: FutureBuilder<Book>(
        future: widget.isbn == null
            ? TextHelper.isGoodreads(bookId)
                ? fetchBook(http.Client(), bookId)
                : fetchGoogleBook(http.Client(), bookId)
            : fetchBookByIsbn(http.Client(), widget.isbn),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var book = snapshot.data;
          return snapshot.hasData
              ? FadeIn(
                  duration: Duration(milliseconds: 1000),
                  child: CustomScrollView(
                    controller: controller,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverTitleBar(book: book),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            FutureBuilder(
                                future: fetchGenres(http.Client(), book.id),
                                builder: (context, snapshot) {
                                  final isNumeric = RegExp(r'[0-9]');
                                  if (snapshot.data != null) {
                                    for (var genre in snapshot.data) {
                                      if (!(genre.name.contains('read') ||
                                          genre.name.contains('fav') ||
                                          genre.name.contains('ya') ||
                                          genre.name.contains('book') ||
                                          genre.name.contains('own') ||
                                          genre.name.contains('to') ||
                                          genre.name.contains('kindle') ||
                                          genre.name.contains('have') ||
                                          genre.name.contains('finish') ||
                                          genre.name.contains('star') ||
                                          genre.name.contains('default') ||
                                          genre.name.contains('library') ||
                                          genre.name.contains('series') ||
                                          genre.name.contains('children-s') ||
                                          genre.name.contains('children') ||
                                          genre.name.contains('tbr') ||
                                          genre.name.contains('shelf') ||
                                          genre.name.contains('borrow') ||
                                          genre.name.contains('novel') ||
                                          genre.name.contains('audible') ||
                                          genre.name.contains('list') ||
                                          genre.name.contains('review') ||
                                          genre.name.contains('recommend') ||
                                          genre.name.contains('audio') ||
                                          genre.name.contains('nonfiction') ||
                                          genre.name.contains('memoirs') ||
                                          isNumeric.hasMatch(genre.name))) {
                                        genreList.add(genre);
                                      }
                                    }
                                  }
                                  return MoreInfo(
                                    book: book,
                                    goodreadsGenres: genreList,
                                  );
                                }),
                            SizedBox(height: 10),
                            DescriptionCard(
                              description: book.description,
                            ),
                            if (book.isbn != '')
                              BookSuggestionList(
                                title: 'You might like these too',
                                book: book,
                                books:
                                    fetchSimilarBooks(http.Client(), book.isbn),
                              ),
                            if (book.seriesId != '' && book.isGoodreads == true)
                              BookSuggestionList(
                                title: book.seriesTitle,
                                book: book,
                                books: fetchBooksInSeries(
                                    http.Client(), book.seriesId),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : SpinkitWidget();
        },
      ),
    );
  }
}
