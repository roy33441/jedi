import 'package:flutter/material.dart';
import 'package:jedi/logic/cubit/report_missing_students/report_missing_students_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/logic/entities/student.dart';
import 'package:jedi/presentation/screens/missing_screen/widgets/students_chips.dart';

import 'missing_catagory.dart';

class MissingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reportMissingStudentsCubit =
        context.watch<ReportMissingStudentsCubit>().state;

    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          MissingCatagory(),
          Container(
            height: screenSize.height * 0.3,
            child: StudentsChips(
              backgroundColor: Theme.of(context).textTheme.bodyText2!.color!,
              missingStudents:
                  reportMissingStudentsCubit.missingStudentsByEntity,
              onPress: (StudentEntity student) {},
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Divider(
            color: Colors.black87,
            thickness: 2.0,
          ),
          Expanded(
            child: StudentsChips(
              backgroundColor: Theme.of(context).highlightColor,
              missingStudents:
                  reportMissingStudentsCubit.missingStudentsWithoutReason,
              onPress: (StudentEntity student) {
                context
                    .read<ReportMissingStudentsCubit>()
                    .reportMissingStudent(student);
              },
            ),
          )
        ],
      ),
    );
  }
}
