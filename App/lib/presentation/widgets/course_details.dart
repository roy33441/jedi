import 'package:flutter/material.dart';
import 'package:jedi/core/constants/strings.dart';
import 'package:jedi/logic/bloc/students_bloc/students_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'one_student_statistic.dart';

class CourseDetails extends StatelessWidget {
  final String courseName;

  const CourseDetails({
    Key? key,
    required this.courseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            courseName,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontSize: 32, fontWeight: FontWeight.w900, shadows: [
              Shadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: Colors.black26,
              )
            ]),
          ),
        ),
        Row(
          children: [
            Builder(
              builder: (context) {
                return OneStudentStatistic(
                  value: context.select((StudentsBloc bloc) {
                    final currentState = bloc.state as StudentFetchSuccess;
                    return currentState.missingStudents;
                  }),
                  title: Strings.missings,
                );
              },
            ),
            Builder(
              builder: (context) {
                return OneStudentStatistic(
                  value: context.select((StudentsBloc bloc) {
                    final currentState = bloc.state as StudentFetchSuccess;
                    return currentState.arrivedStudents;
                  }),
                  title: Strings.here,
                );
              },
            ),
            Builder(
              builder: (context) {
                return OneStudentStatistic(
                  value: context.select((StudentsBloc bloc) {
                    final currentState = bloc.state as StudentFetchSuccess;
                    return currentState.students.length;
                  }),
                  title: Strings.total,
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
