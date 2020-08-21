import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:untitled_goodreads_project/components/book-3d.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/constants.dart';
import 'package:untitled_goodreads_project/controller/firestore-controller.dart';
import 'package:untitled_goodreads_project/models/book.dart';

class ProgressModalContent extends StatefulWidget {
  const ProgressModalContent({
    Key key,
    @required this.sliderValue,
    this.book,
  }) : super(key: key);

  final double sliderValue;
  final Book book;

  @override
  _ProgressModalContentState createState() => _ProgressModalContentState();
}

class _ProgressModalContentState extends State<ProgressModalContent> {
  var sliderVal = 0.5;

  @override
  void initState() {
    super.initState();
    sliderVal = widget.sliderValue;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                height: 210,
                child: Hero(
                  tag: 'cover${widget.book.id}',
                  child: Book3D(
                    book: widget.book,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: ((sliderVal / 10) * widget.book.pageCount)
                          .toInt()
                          .toString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: kSecondaryColor,
                            fontSize: 30,
                          )),
                  TextSpan(
                      text: ' pages\n',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 20,
                          )),
                  TextSpan(
                      text: (sliderVal * 10).toInt().toString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: kSecondaryColor,
                            fontSize: 30,
                          )),
                  TextSpan(
                      text: ' percent',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 20,
                          )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
            width: size.width * .65,
            child: Hero(
              tag: 'slider${widget.book.id}',
              child: NeumorphicSlider(
                style: SliderStyle(
                    accent: kSecondaryColor,
                    thumbBorder: NeumorphicBorder(
                      color: kSecondaryColor,
                      width: 16,
                    ),
                    depth: 5),
                value: sliderVal,
                height: 15,
                onChanged: (value) {
                  setState(() {
                    sliderVal = value;
                  });
                },
              ),
            )),
        SizedBox(height: 20),
        buildConfirmationButton('Save', context, () {
          Provider.of<FirestoreController>(context, listen: false)
              .updateFinishedPages(
                  ((sliderVal / 10) * widget.book.pageCount).toInt(),
                  widget.book);
          Navigator.pop(context, sliderVal);
        }),
      ],
    );
  }
}
