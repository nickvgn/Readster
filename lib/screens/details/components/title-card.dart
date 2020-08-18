import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/services/clip-shadow-path.dart';
import 'package:untitled_goodreads_project/services/image-helper.dart';

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
        var colors = snapshot.data;

        return Container(
          child: ClipShadowPath(
            clipper: WaveClipperOne(),
            shadow: Shadow(
              blurRadius: 10,
              color: Colors.black26,
              offset: Offset(3, 3),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: snapshot.hasData
                      ? colors
                      : [Colors.grey[200], Colors.grey[700]],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
