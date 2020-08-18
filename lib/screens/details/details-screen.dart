import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/screens/details/components/book-suggestions-list.dart';
import 'package:untitled_goodreads_project/screens/details/components/description-card.dart';
import 'package:untitled_goodreads_project/screens/details/components/more-info.dart';
import 'package:untitled_goodreads_project/screens/details/components/sliver-title-bar.dart';
import 'package:http/http.dart' as http;
import 'package:untitled_goodreads_project/services/text-helper.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFadeIn = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isFadeIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var bookId = Provider.of<BookController>(context).bookId;
    final controller = ScrollController();

    return Scaffold(
      body: FutureBuilder<Book>(
        future: TextHelper.isGoodreads(bookId)
            ? fetchBook(http.Client(), bookId)
            : fetchGoogleBook(http.Client(), bookId),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var book = snapshot.data;
          return snapshot.hasData && isFadeIn
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
                              builder: (context, snapshot) => MoreInfo(
                                book: book,
                                goodreadsGenres:
                                    snapshot.hasData ? snapshot.data : null,
                              ),
                            ),
                            DescriptionCard(
                              description: book.description,
                            ),
                            if (book.isbn != '')
                              BookSuggestionList(
                                title: 'You might like these too',
                                book: book,
                                books:
                                    fetchBooksByIsbn(http.Client(), book.isbn),
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
