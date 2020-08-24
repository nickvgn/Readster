import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';
import 'package:untitled_goodreads_project/screens/details/details-screen.dart';
import 'package:untitled_goodreads_project/services/image-helper.dart';

class Book3D extends StatelessWidget {
  const Book3D({
    Key key,
    @required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
      initialData: kLightBackgroundColor,
      future: ImageHelper.getImagePaletteDominantColor(
        NetworkImage(book.imageUrl),
      ),
      builder: (context, snapshot) {
        var color = snapshot.data;
        return snapshot.hasData
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.only(bottom: 11.8),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateX(-0.06)
                    ..rotateY(-0.69),
//                    ..rotateZ(0.01),
                  alignment: FractionalOffset.topCenter,
                  child: NeumorphicButton(
                    onPressed: () {
                      Provider.of<BookController>(context, listen: false)
                          .updateBookId(book.id);
                      Navigator.push(
                          context,
                          PageTransition(
                            curve: Curves.easeInOutSine,
                            type: PageTransitionType.scale,
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 100),
                            child: DetailsScreen(),
                          ));
                    },
                    padding: EdgeInsets.zero,
                    style: kNeumorphicStyle.copyWith(
                      shadowLightColor: Colors.transparent,
                      boxShape: NeumorphicBoxShape.beveled(
                        BorderRadius.only(
                          bottomLeft: Radius.elliptical(11, 5),
                          topLeft: Radius.elliptical(11, 2),
                        ),
                      ),
                      depth: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
//                        boxShadow: [
//                          BoxShadow(
//                            color: color,
//                            spreadRadius: 1,
//                            offset: Offset(-20, -2),
//                          ),
//                        ],
                        color: color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CachedNetworkImage(
                          imageUrl: book.imageUrl,
                          fit: BoxFit.fill,
                          placeholder: (context, __) => Container(
                            color: kLightBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
