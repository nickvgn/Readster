import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:untitled_goodreads_project/components/spinkit-widget.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';

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
                          leading: Neumorphic(
                            style: kNeumorphicStyle.copyWith(
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(2),
                              ),
                              depth: 2,
                            ),
                            child: FadeInImage.memoryNetwork(
                              image: books[index].imageUrl,
                              placeholder: kTransparentImage,
                            ),
                          ),
                          title: Text('${books[index].title}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle2),
                          subtitle: Text('${books[index].author}',
                              style: Theme.of(context).textTheme.caption),
                          trailing: books[index].isEbook
                              ? Neumorphic(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  style: kNeumorphicStyle.copyWith(
                                    color: kPrimaryColor,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(15),
                                    ),
                                    depth: 2,
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
