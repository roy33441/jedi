import 'package:flutter/material.dart';

import '../../../../core/constants/strings.dart';
import '../../../widgets/statistics_container.dart';
import 'arrived_students_list.dart';
import 'missing_students_list_view.dart';

class FormationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
          Text(
            Strings.report_hint,
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),
          ),
          Expanded(child: ArrivedStudentsListView()),
        ],
      ),
    );
  }
}
