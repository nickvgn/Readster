import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled_goodreads_project/services/text-helper.dart';

class Book {
  final String id,
      seriesId,
      title,
      seriesTitle,
      description,
      author,
      isbn,
      webReaderLink,
      imageUrl,
      pubishedDate,
      readStatus;
  final double rating;
  final int reviewCount, ratingCount, pageCount, pageRead;
  final bool isEbook, isGoodreads;
  final List<Book> similarBooks;
  final List<String> genres;
  final DateTime lastRead;

  Book({
    this.id = '',
    this.seriesId = '',
    this.title = '',
    this.seriesTitle = '',
    this.description,
    this.author = '',
    this.genres,
    this.isbn,
    this.rating = 0.0,
    this.imageUrl = '',
    this.pubishedDate = '',
    this.readStatus,
    this.reviewCount,
    this.ratingCount,
    this.pageCount,
    this.pageRead,
    this.webReaderLink,
    this.isEbook = false,
    this.isGoodreads = false,
    this.similarBooks,
    this.lastRead,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map book = doc.data;
    return Book(
      id: book['id'],
      title: book['title'],
      author: book['author'],
      imageUrl: book['imageUrl'],
      pageCount: book['pageCount'],
      pageRead: book['pageRead'],
      readStatus: book['readStatus'],
      isbn: book['isbn'],
      isGoodreads: book['isGoodreads'],
      lastRead: book['lastRead'] != null ? book['lastRead'].toDate() : null,
    );
  }

  factory Book.forSearch(Map<String, dynamic> book) {
    return Book(
      id: book['best_book']['id'] as String,
      title: TextHelper.parseHtmlStringAsText(
          book['best_book']['title'] as String),
      author: TextHelper.parseHtmlStringAsText(
          book['best_book']['author']['name'] as String),
      imageUrl:
          book['best_book']['image_url'].replaceAll('SX98', 'SX150') as String,
      isEbook: false,
    );
  }

  factory Book.seriesBooks(Map<String, dynamic> book) {
    return Book(
        id: book['work']['best_book']['id'],
        imageUrl:
            book['work']['best_book']['image_url'].replaceAll('SX98', 'SX150'));
  }

  factory Book.similarBooks(Map<String, dynamic> book) {
    return Book(
      id: book['id'],
      imageUrl: book['image_url'].replaceAll('SX98', 'SX150'),
    );
  }

  factory Book.forGoogleSearch(dynamic book) {
    String thumbnail = '';

    try {
      thumbnail = book['volumeInfo']['imageLinks']['thumbnail'];
    } catch (e) {
      thumbnail = '';
    }

    return Book(
      id: book['id'] as String,
      title: book['volumeInfo']['title'] as String,
      author: book['volumeInfo']['authors']
          .toString()
          .replaceAll(RegExp(r'[^\w\s]+'), ''),
      imageUrl: thumbnail,
      isEbook: book['saleInfo']['isEbook'],
    );
  }

  factory Book.forBook(dynamic book, String author) {
    String seriesId;
    String seriesTitle;

    try {
      seriesId = book['series_works']['series_work']['series']['id'];
      seriesTitle = book['series_works']['series_work']['series']['title'];
    } catch (e) {
      try {
        seriesId = book['series_works']['series_work'][0]['series']['id'];
        seriesTitle = book['series_works']['series_work'][0]['series']['title'];
      } catch (e) {
        seriesId = '';
        seriesTitle = '';
      }
    }

    return Book(
      isGoodreads: true,
      id: book['id'] as String,
      title: TextHelper.parseHtmlStringAsText(book['title']) ?? '',
      imageUrl: book['image_url'].replaceAll('SX98', 'SX475'),
      description: TextHelper.parseHtmlStringAsText(book['description']) ?? '',
      isbn: book['isbn'] ?? '',
      rating: double.parse(book['average_rating']) ?? 0.0,
      ratingCount: int.parse(book['work']['ratings_count']) ?? 0,
      reviewCount: int.parse(book['work']['text_reviews_count']) ?? 0,
      pageCount: int.parse(book['num_pages']) ?? 0,
      pubishedDate: book['publication_month'] != null
          ? '${book['publication_year']}-'
              '${book['publication_month'].toString().padLeft(2, "0")}-'
              '${book['publication_day'].toString().padLeft(2, "0")}'
          : book['publication_year'] ?? 'not available',
      seriesId: seriesId,
      seriesTitle: seriesTitle != ''
          ? TextHelper.parseHtmlStringAsText(
              seriesTitle.substring(6, seriesTitle.length - 2))
          : '',
      author: TextHelper.parseHtmlStringAsText(author),
    );
  }

  factory Book.forGoogleBook(dynamic book) {
    List<String> result;
    try {
      var list = [];
      var temp = book['volumeInfo']['categories'];
      for (var item in temp) {
        var arr = item.toString().split(' / ');
        list.addAll(arr);
      }
      result = LinkedHashSet<String>.from(list).toList();
    } catch (e) {
      print(e);
    }

    return Book(
      isGoodreads: false,
      id: book['id'],
      title: book['volumeInfo']['title'],
      imageUrl: book['volumeInfo']['imageLinks']['large'] ??
          book['volumeInfo']['imageLinks']['medium'] ??
          book['volumeInfo']['imageLinks']['thumbnail'],
      description: book['volumeInfo']['description'],
      genres: result,
      isbn: book['volumeInfo']['industryIdentifiers'][0]['identifier'],
      rating:
          double.tryParse(book['volumeInfo']['averageRating'].toString()) ?? 0,
      ratingCount:
          int.tryParse(book['volumeInfo']['ratingsCount'].toString()) ?? 0,
      reviewCount: 0,
      pageCount: int.tryParse(book['volumeInfo']['pageCount'].toString()) ?? 0,
      pubishedDate: book['volumeInfo']['publishedDate'].toString() ?? '',
      author: book['volumeInfo']['authors']
          .toString()
          .replaceAll(RegExp(r'[^\w\s]+'), ''),
      webReaderLink: book['accessInfo']['webReaderLink'],
      isEbook: book['saleInfo']['isEbook'],
    );
  }
}
//
//
//
//
//
//
//
//
//
//
//

List<Book> sampleBooks = [
  Book(
    title: 'The Institute',
    author: 'Stephen King',
    pageCount: 288,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1549241208l/43798285.jpg',
  ),
  Book(
    title: 'American Gods',
    author: 'Neil Gaiman ',
    pageCount: 299,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1490765932l/31816336._SY475_.jpg',
  ),
  Book(
    title:
        'Girl, Stop Apologizing: A Shame-Free Plan for Embracing and Achieving Your Goals',
    author: 'Rachel Hollis',
    pageCount: 269,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1550607364l/40591267._SY475_.jpg',
  ),
  Book(
    title: 'Meditations',
    author: 'Marcus Aurelius',
    pageCount: 269,
    imageUrl:
        'http://books.google.com/books/content?id=24a_o-VJvGsC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE70zmKurKkSNIHSmsfidz3suymylzkF9ntcn7LXlZZpVBpwb2-VlCUsRwpnaydeTQozKISDG-5PnlYcZ5-9LUKtR2opwvoW4jL9mtMgH-R2L-BvTJ5m2b1N4Ta093kPyv7C1QL3i&source=gbs_api',
  ),
  Book(
    title: '1984',
    author: 'George Orwell',
    pageCount: 167,
    imageUrl:
        'http://books.google.com/books/content?id=kotPYEqx7kMC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE70jvJFLIeTyAWe-mwvOrHCyLv9-sn9PGuCY1BGDZPNd0ACn4ncpNYsMSbu1XLDj7NDhYDoos9q9Vn1FwYRpDWkW0bb1b963Z-754Zq92tBKdHQ2M-8iKBFIKA3JaQb0gUPEDCQP&source=gbs_api',
  ),
  Book(
    title:
        'Will My Cat Eat My Eyeballs? Big Questions from Tiny Mortals About Death',
    author: 'Caitlin Doughty',
    pageCount: 265,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1554396038l/43785830.jpg',
  ),
  Book(
    title: 'Why We Sleep: Unlocking the Power of Sleep and Dreams',
    author: 'Matthew Walker',
    pageCount: 399,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1556604137l/34466963._SY475_.jpg',
  ),
  Book(
    title: 'Digital Minimalism: Choosing a Focused Life in a Noisy World',
    author: 'Cal Newport',
    pageCount: 259,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1549433350l/40672036._SY475_.jpg',
  ),
  Book(
    title: 'Fight Club',
    author: 'Chuck Palahniuk',
    pageCount: 335,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1558216416l/36236124._SY475_.jpg',
  ),
  Book(
    title: 'The Symposium',
    author: 'Plato',
    pageCount: 137,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1520522475l/81779.jpg',
  ),
  Book(
    title: 'American Psycho',
    author: 'Bret Easton Ellis',
    pageCount: 561,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1436934349l/28676._SY475_.jpg',
  ),
  Book(
    title: 'Man\'s Search for Meaning',
    author: 'Viktor E. Frankl',
    pageCount: 246,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1535419394l/4069._SY475_.jpg',
  ),
  Book(
    title: 'American Dirt',
    author: 'Jeanine Cummins',
    pageCount: 254,
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1559127861l/45046527._SY475_.jpg',
  ),
];
