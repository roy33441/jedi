import 'package:flutter/material.dart';
import 'package:jedi/core/themes/app_theme.dart';

class CheckBoxWithTitle extends StatelessWidget {
  const CheckBoxWithTitle({
    Key? key,
    required this.value,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final String title;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      highlightColor: Colors.black54,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            activeColor: Theme.of(context).success,
            value: value,
            onChanged: onChanged,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      onTap: () => onChanged!(!value),
    );
  }
}
