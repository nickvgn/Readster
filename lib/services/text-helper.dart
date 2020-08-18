import 'package:html/parser.dart';
import 'package:xml2json/xml2json.dart';

class TextHelper {
  static String parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).outerHtml;

    return parsedString;
  }

  static String parseHtmlStringAsText(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString.replaceAll(r'\', '');
  }

  static String getJsonFromXMLUrl(String responseBody) {
    final Xml2Json xml2Json = Xml2Json();

    xml2Json.parse(responseBody);

    final jsonString = xml2Json.toParker();
    return jsonString;
  }

  static String getJsonFromXMLUrlAlt(String responseBody) {
    final Xml2Json xml2Json = Xml2Json();

    xml2Json.parse(responseBody);

    final jsonString = xml2Json.toGData();

    return jsonString;
  }

  static bool isGoodreads(String bookId) {
    return bookId.contains(new RegExp(r'[A-Z]')) ? false : true;
  }
}
