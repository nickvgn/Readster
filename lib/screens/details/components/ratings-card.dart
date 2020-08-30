import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:untitled_goodreads_project/models/book.dart';

class RatingsCard extends StatelessWidget {
  final Book book;

  const RatingsCard({
    Key key,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (book.rating != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: SmoothStarRating(
                  allowHalfRating: true,
                  starCount: 5,
                  rating: book.rating,
                  size: 20.0,
                  isReadOnly: true,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  color: Colors.amberAccent,
                  borderColor: Colors.amber,
                  spacing: 0.0,
                ),
              ),
              Text(
                '  ${book.rating.toString()}',
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '${book.ratingCount}',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            TextSpan(
              text: ' ratings',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 10,
                    color: Colors.white,
                  ),
            ),
            if (book.isGoodreads)
              TextSpan(
                text: '  .  ${book.reviewCount}',
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            if (book.isGoodreads)
              TextSpan(
                text: ' reviews',
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 10,
                      color: Colors.white,
                    ),
              )
          ]),
        ),
      ],
    );
  }
}
