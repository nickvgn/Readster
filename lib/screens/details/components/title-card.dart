import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/services/clip-shadow-path.dart';
import 'package:untitled_goodreads_project/services/image-helper.dart';
import 'package:kenburns/kenburns.dart';

class TitleCard extends StatelessWidget {
  final Book book;

  const TitleCard({
    Key key,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context2) {
    return FutureBuilder<List<Color>>(
      future: ImageHelper.getImagePalette(
        NetworkImage(book.imageUrl),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        var colors = snapshot.data;
        return snapshot.hasData
            ? Container(
                padding: EdgeInsets.only(bottom: 15),
                child: ClipShadowPath(
                  clipper: OvalBottomBorderClipper(),
                  shadow: Shadow(
                    blurRadius: 10,
                    color: Colors.black26,
                    offset: Offset(3, 3),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: KenBurns(
                            maxScale: 2,
                            child: Image.network(
                              book.imageUrl,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: snapshot.hasData
                                ? [
                                    colors[0].withOpacity(.8),
                                    colors[1].withOpacity(.9),
                                  ]
                                : [
                                    Colors.grey[200].withOpacity(.8),
                                    Colors.grey[700].withOpacity(.9)
                                  ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))
            : Container();
      },
    );
  }
}
