import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jedi/presentation/screens/missing_screen/widgets/missing_catagory.dart';


class MissingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [MissingCatagory()],
      ),
    );
  }
}
