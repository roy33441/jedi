import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      minWidth: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: Theme.of(context).highlightColor,
      textColor: Theme.of(context).textTheme.bodyText2!.color,
      child: Icon(Icons.nights_stay),
      shape: CircleBorder(),
    );
  }
}
