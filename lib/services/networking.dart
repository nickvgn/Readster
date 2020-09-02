import 'package:url_launcher/url_launcher.dart';

class NetworkHelper {
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String previewHtml(String isbn, width, height) {
    return """<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>Google Books Embedded Viewer API Example</title>
    <script type="text/javascript" src="https://www.google.com/books/jsapi.js"></script>
    <script type="text/javascript">
    google.books.load();

    function initialize() {
    var viewer = new google.books.DefaultViewer(document.getElementById('viewerCanvas'));
    viewer.load('ISBN:$isbn');
    }

    google.books.setOnLoadCallback(initialize);
    </script>
    </head>
    <body>
    <div id="viewerCanvas" style="width: ${(width * .91).toInt()}px; height: ${height}px"></div>
    </body>
    </html>""";
  }

  static String reviewHtml(String isbn, width, height) {
    return """   <style>
  #goodreads-widget {
    font-family: georgia, serif;
    padding: 18px 0;
    width:300px;
  }
  #goodreads-widget h1 {
    font-weight:normal;
    font-size: 10px;
    border-bottom: 1px solid #BBB596;
    margin-bottom: 0;
  }
  #goodreads-widget a {
    text-decoration: none;
    color:#660;
  }
  iframe{
    background-color: #fff;
    color:#660;
    font-size: 11px;
  }
  #goodreads-widget a:hover { text-decoration: underline; }
  #goodreads-widget a:active {
    color:#660;
  }
  #gr_footer {
    width: 100%;
    border-top: 1px solid #BBB596;
    text-align: right;
  }
  #goodreads-widget .gr_branding{
    color: #382110;
    font-size: 11px;
    text-decoration: none;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  }
</style>
  <iframe id="the_iframe" src="https://www.goodreads.com/api/reviews_widget_iframe?did=DEVELOPER_ID&format=html&header_text=Goodreads+reviews+for+The+Adventures+of+Huckleberry+Finn&isbn=$isbn&links=660&review_back=fff&stars=000&text=000" width="$width" height="$height" frameborder="0"></iframe>
</div>

    """;
  }
}

String testImage1 =
    'https://images.pornpics.com/1280/201803/29/1395196/1395196_043_5fbd.jpg';
String testImage2 =
    'http://www.sffworld.com/wp-content/uploads/2014/06/mr-mercedes.jpg';
String testImage3 =
    'https://fionajaydemedia.com/wp-content/uploads/2015/07/willowOfChangeFinal-FJM_Mid_Res_1000x15001.jpg';

String url2 =
    r"""<script type="text/javascript" src="//books.google.com/books/previewlib.js"></script>
<script type="text/javascript">
GBS_insertEmbeddedViewer('ISBN:0738531367',600,500);
</script>""";
