import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/header-title.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';

class BookSuggestionList extends StatelessWidget {
  const BookSuggestionList({
    Key key,
    @required this.book,
    this.books,
    this.title,
  }) : super(key: key);

  final String title;
  final Book book;
  final Future<List<Book>> books;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: books,
      builder: (context, snapshot) {
        var similarBooks = snapshot.data;
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Neumorphic(
                style: kNeumorphicStyle.copyWith(
                  depth: -3,
                  boxShape: NeumorphicBoxShape.rect(),
                ),
                margin: EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: SizedBox(
                  height: 180,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: HeaderTitle(title: title),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context2, index) => Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black26,
                                  offset: Offset(7, 7),
                                )
                              ],
                            ),
                            child: NeumorphicButton(
                              style: kNeumorphicStyle.copyWith(
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Provider.of<BookController>(context,
                                        listen: false)
                                    .updateBookId(similarBooks[index].id);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: DetailsScreen(),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              },
                              child:
                                  Image.network(similarBooks[index].imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
