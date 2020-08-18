import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/book-controller.dart';

class BottomSelectedIndicator extends StatelessWidget {
  const BottomSelectedIndicator({
    Key key,
    this.apiType,
  }) : super(key: key);

  final String apiType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 20,
      decoration: BoxDecoration(
        color: Provider.of<BookController>(context, listen: false).apiType ==
                apiType
            ? kSecondaryColor
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
