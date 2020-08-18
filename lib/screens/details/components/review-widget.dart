import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/models/book.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class ReviewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final String isbn = Provider.of<Book>(context).isbn;
    final String reviewWidget =
    """ <iframe id="the_iframe" src="https://www.goodreads.com/api/reviews_widget_iframe?did=70269&format=html&isbn=$isbn&links=660&min_rating=&num_reviews=5&review_back=ffffff&stars=000000&stylesheet=&text=000" width="400" height="1310" frameborder="0"></iframe>""";
//    return Container(
//      height: 1300,
//      width: 310,
//      child: WebView(
//        initialUrl: Uri.dataFromString(reviewWidget,
//            mimeType: 'text/html')
//            .toString(),
////                      Uri.file("/assets/gr%20widget.html", windows: false).toString(),
//        javascriptMode: JavascriptMode.unrestricted,
//      ),
//    );
  }
}