import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Quote {
  final String imageUrl;
  final String quote;
  final String author;
  final String bookTitle;
  final TextStyle font;

  Quote({this.font, this.imageUrl, this.quote, this.author, this.bookTitle});
}

List<Quote> quotes = [
  Quote(
      imageUrl:
          'https://images.unsplash.com/photo-1574244931790-ee19df716899?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80',
      quote:
          'Fairy tales are more than true: not because they tell us that dragons exist, but because they tell us that dragons can be beaten.',
      author: 'Neil Gaiman, Coraline',
      font: GoogleFonts.amiko()),
  Quote(
      imageUrl:
          'https://images.unsplash.com/photo-1596518695635-f3537ef1bd5d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      quote:
          'Good friends, good books, and a sleepy conscience: this is the ideal life.',
      author: 'Mark Twain',
      font: GoogleFonts.indieFlower()),
  Quote(
      imageUrl:
          'https://images.unsplash.com/photo-1592348344902-161228c40310?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      quote:
          'If you only read the books that everyone else is reading, you can only think what everyone else is thinking.',
      author: 'Haruki Murakami',
      font: GoogleFonts.spaceMono()),
];

Quote sampleQuote = Quote(
    imageUrl:
        'https://images.unsplash.com/photo-1496635594438-0cabe903998e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
    quote:
        'If you only read the books that everyone else is reading, you can only think what everyone else is thinking.',
    author: 'Haruki Murakami, Norwegian Wood');
