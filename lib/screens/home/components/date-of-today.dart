import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled_goodreads_project/constants.dart';

class DateOfToday extends StatelessWidget {
  const DateOfToday({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${DateFormat('EEEE,').format(
              DateTime.now(),
            )}',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24),
          ),
          TextSpan(
            text: '${DateFormat(' MMMM dd').format(
              DateTime.now(),
            )}',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
