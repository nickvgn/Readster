import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:untitled_goodreads_project/components/confirmation-button.dart';
import 'package:untitled_goodreads_project/screens/home/components/neumorphic-text-field.dart';

class Goal extends StatelessWidget {
  const Goal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 10),
        Text(
          'Set a goal',
          style: Theme.of(context).textTheme.headline6.copyWith(),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        NeumorphicTextField(
          hintText: 'Daily pages',
          icon: MdiIcons.bookOpen,
        ),
        SizedBox(height: 20),
        NeumorphicTextField(
          hintText: 'Yearly books',
          icon: MdiIcons.bookMultiple,
        ),
        Spacer(),
        buildConfirmationButton('Save', context, () {})
      ],
    );
  }
}
