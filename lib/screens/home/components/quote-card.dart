import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/models/quote.dart';
import 'package:untitled_goodreads_project/services/image-helper.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({
    Key key,
    this.quote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Color>>(
      future: ImageHelper.getImagePaletteWithOpacity(
        NetworkImage(quote.imageUrl),
      ),
      builder: (context, snapshot) {
        var colors = snapshot.data;
        return Container(
          alignment: Alignment.center,
          child: Neumorphic(
            style: kNeumorphicStyle.copyWith(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(25),
              ),
              depth: 3,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(quote.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors:
                        snapshot.hasData ? colors : [Colors.white, Colors.grey],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          '“${quote.quote}”',
                          style: quote.font.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          maxFontSize: 23,
                          minFontSize: 12,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "\n— ${quote.author}",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
