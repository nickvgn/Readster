import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:intl/intl.dart';

class LastRead extends StatelessWidget {
  const LastRead({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              height: size.height * .062,
              child: Image.network(
                  'https://pictures.abebooks.com/isbn/9780718189532-us.jpg'),
            ),
          ),
          Flexible(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Only Human ',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: 'by Sylvain Neuvel',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.white),
                    ),
                  ]),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: size.width * .57,
                  child: RoundedProgressBar(
                      style: RoundedProgressBarStyle(
                        colorProgress: Colors.white,
                        colorProgressDark: Color(0xffc0392b),
                        backgroundProgress: Colors.grey[700].withOpacity(.2),
                        borderWidth: 0,
                        widthShadow: 0,
                      ),
                      height: 5,
                      milliseconds: 1000,
                      percent: 43,
                      borderRadius: BorderRadius.circular(25)),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Last Read: ${DateFormat('kk:mm').format(
                        DateTime.now(),
                      )}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      'Progress: 30%',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
