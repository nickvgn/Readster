import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class SearchList extends StatelessWidget {
  final List<Book> books;

  const SearchList({Key key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return !Provider.of<BookController>(context).isLoading
        ? Expanded(
            child: Column(
              children: [
                Expanded(
                  child: FadingEdgeScrollView.fromScrollView(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: controller,
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Provider.of<BookController>(context, listen: false)
                                .updateBookId(books[index].id);
                            Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOutSine,
                                  type: PageTransitionType.scale,
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 100),
                                  child: DetailsScreen(),
                                ));
                          },
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 35),
                          leading: CachedNetworkImage(
                            imageUrl: books[index].imageUrl,
                            imageBuilder: (context, _) => Hero(
                              tag: 'bookCover$index',
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(1, 4)),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(books[index].imageUrl),
                                ),
                              ),
                            ),
                            fadeInDuration: Duration(milliseconds: 100),
                            placeholderFadeInDuration:
                                Duration(microseconds: 1),
                            placeholder: (context, _) => Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(1, 4)),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  'assets/images/book_cover_placeholder.jpg',
                                  width: 37,
                                ),
                              ),
                            ),
                          ),
                          title: Text('${books[index].title}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle2),
                          subtitle: Text('${books[index].author}',
                              style: Theme.of(context).textTheme.caption),
                          trailing: books[index].isEbook
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 22,
                                  width: 54,
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'eBook',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(
                                  height: 22,
                                  width: 54,
                                ),
                        );
//                    : Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Expanded(child: Center(child: SpinkitWidget()));
  }
}
