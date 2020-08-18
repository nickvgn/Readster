import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled_goodreads_project/constants.dart';

class ReadStatusButton extends StatelessWidget {
  const ReadStatusButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        elevation: 20,
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white,
          onTap: () {},
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/book2.png"),
              ),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    kSecondaryColor.withOpacity(0.9),
                    Colors.black.withOpacity(0.2)
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  'Preview',
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
