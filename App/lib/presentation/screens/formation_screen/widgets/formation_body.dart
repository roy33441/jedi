import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jedi/presentation/screens/formation_screen/widgets/arrived_students_list.dart';

import '../../../widgets/statistics_container.dart';
import 'missing_students_list_view.dart';

class FormationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          StatisticsContainer(
            showIndicator: false,
            screenPortion: 0.18,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          MissingStudentsListView(),
          Divider(
            color: Colors.black,
            thickness: 1.5,
          ),
          ArrivedStudentsListView(),
        ],
      ),
    );
  }
}
