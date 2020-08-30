import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/models/genre.dart';
import 'package:untitled_goodreads_project/services/text-helper.dart';

const apiKey = 'JmM6U8MTKLUf6QYSfvtBIA';
const goodReadsUrlShowBook = 'https://www.goodreads.com/book/show';
const goodReadsUrlShowBookIsbn = 'https://www.goodreads.com/book/isbn';
const goodReadsUrlSearch = 'https://www.goodreads.com/search';
const goodReadsUrlSeries = 'https://www.goodreads.com/series';
const googleBooksUrl = 'https://www.googleapis.com/books/v1/volumes';

// GOODREADS
Future<List<Book>> fetchBooks(http.Client client, String query) async {
  final url = '$goodReadsUrlSearch.xml?key=$apiKey&q=$query';
  final response = await client.get(url);

  final jsonString = TextHelper.getJsonFromXMLUrl(response.body);
  return compute(parseBooks, jsonString);
}

List<Book> parseBooks(String responseBody) {
  final parsed = jsonDecode(responseBody);
  final data = parsed['GoodreadsResponse']['search']['results']['work']
      .cast<Map<String, dynamic>>();

  return data.map<Book>((json) => Book.forSearch(json)).toList();
}
//
//
//
//
//
//

Future<Book> fetchBook(http.Client client, String bookId) async {
  final url = '$goodReadsUrlShowBook/$bookId.xml?key=$apiKey';
  final response = await client.get(url);

  final jsonString = TextHelper.getJsonFromXMLUrl(response.body);
  return compute(parseBook, jsonString);
}

Future<Book> fetchBookByIsbn(http.Client client, String isbn) async {
  final url = '$goodReadsUrlShowBookIsbn/$isbn?key=$apiKey';
  final response = await client.get(url);

  final jsonString = TextHelper.getJsonFromXMLUrl(response.body);
  return compute(parseBook, jsonString);
}

Book parseBook(String responseBody) {
  final parsed = jsonDecode(responseBody);
  var book = parsed['GoodreadsResponse']['book'];

  String author = BookController.getAuthors(book['authors']['author']);
  return Book.forBook(book, author);
}
//
//
//
//
//
//
//

Future<List<Genre>> fetchGenres(http.Client client, String bookId) async {
  final url = '$goodReadsUrlShowBook/$bookId.xml?key=$apiKey';
  final response = await client.get(url);
  final jsonString = TextHelper.getJsonFromXMLUrlAlt(response.body);

  return compute(parseGenres, jsonString);
}

List<Genre> parseGenres(String responseBody) {
  final parsed = jsonDecode(responseBody);
  var data = parsed['GoodreadsResponse']['book']['popular_shelves']['shelf']
      .cast<Map<String, dynamic>>();

  return data.map<Genre>((json) => Genre.forGenre(json)).toList();
}
//
//
//
//
//
//

Future<List<Book>> fetchSimilarBooks(http.Client client, String isbn) async {
  final url = '$goodReadsUrlShowBookIsbn/$isbn?key=$apiKey';
  final response = await client.get(url);

  final jsonString = TextHelper.getJsonFromXMLUrl(response.body);
  return compute(parseSimilarBooks, jsonString);
}

List<Book> parseSimilarBooks(String responseBody) {
  final parsed = jsonDecode(responseBody);
  final data = parsed['GoodreadsResponse']['book']['similar_books']['book']
      .cast<Map<String, dynamic>>();

  return data.map<Book>((json) => Book.similarBooks(json)).toList();
}
//
//
//
//
//
//

//fetch all books from a series given series Id
Future<List<Book>> fetchBooksInSeries(
    http.Client client, String seriesId) async {
  final url = '$goodReadsUrlSeries/$seriesId?format=xml&key=$apiKey';
  final response = await client.get(url);

  final jsonString = TextHelper.getJsonFromXMLUrl(response.body);
  return compute(parseBooksInSeries, jsonString);
}

List<Book> parseBooksInSeries(String responseBody) {
  final parsed = jsonDecode(responseBody);
  final data =
      parsed['GoodreadsResponse']['series']['series_works']['series_work'];
  return data.map<Book>((json) => Book.seriesBooks(json)).toList();
}
//
//
//
//
//
//

//GOOGLEBOOKS

Future<List<Book>> fetchGoogleBooks(http.Client client, String query) async {
  final url = '$googleBooksUrl?q=$query';
  final response = await client.get(url);

  return compute(parseGoogleBooks, response.body);
}

List<Book> parseGoogleBooks(String responseBody) {
  final parsed = jsonDecode(responseBody);
  final data = parsed['items'].cast<Map<String, dynamic>>();

  return data.map<Book>((json) => Book.forGoogleSearch(json)).toList();
}

Future<Book> fetchGoogleBook(http.Client client, String bookId) async {
  final url = '$googleBooksUrl/$bookId';
  final response = await client.get(url);

  return compute(parseGoogleBook, response.body);
}

Book parseGoogleBook(String responseBody) {
  return Book.forGoogleBook(jsonDecode(responseBody));
}

//BOOK CONTROLLER CLASS

class BookController with ChangeNotifier {
  String query = '';
  String bookId = '50';
  String apiType = GOODREADS;
  bool isLoading = false;
  String readStatus = TOREAD;
  String bookView = LIST;
  double sliderValue = 0.5;
  String currentScreen = HOME;
  int index = 0;
  List<String> statuses = [ALL, TOREAD, READING, READ];
  List<String> views = [LIST, SHELF];

  static String getAuthors(dynamic authors) {
    List<String> names = [];
    String authorNames = '';
    try {
      authorNames = authors['name'];
    } catch (e) {
      print(e);
      for (var author in authors) {
        names.add(author['name']);
      }
      authorNames = "${names[0]} and ${names[1]}";
    }
    return authorNames;
  }

  void updateQuery(String newQuery) {
    query = newQuery;
    notifyListeners();
  }

  void updateBookId(String newId) {
    bookId = newId;
    notifyListeners();
  }

  void updateApiType(String api) {
    apiType = api;
    notifyListeners();
  }

  void updateLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void updateBookView() {
    bookView = views[index];
    index == 1 ? index = 0 : index++;
    notifyListeners();
  }

  void updateSliderValueState(double value) {
    sliderValue = value;
    notifyListeners();
  }

  void updateScreenState(String screenName) {
    currentScreen = screenName;
    notifyListeners();
  }
}
