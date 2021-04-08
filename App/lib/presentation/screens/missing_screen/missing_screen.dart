import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/logic/cubit/report_missing_students/report_missing_students_cubit.dart';
import 'package:jedi/presentation/screens/missing_screen/widgets/report_missing_student_failed_flushbar.dart';

import '../../../logic/bloc/students_bloc/students_bloc.dart';
import 'widgets/missing_body.dart';

class MissingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocListener<ReportMissingStudentsCubit, ReportMissingStudentsState>(
        listener: (context, state) {
          final currentState = state;
          if (currentState is ReportMissingStudentsFailure) {
            ReportMissingStudentFailedFlushbar(
              context: context,
              studentName: currentState.failedStudent.fullName,
            )..show(context);
          }
        },
        child: BlocBuilder<StudentsBloc, StudentsState>(
          buildWhen: (previous, current) => !(previous is StudentFetchSuccess &&
              current is StudentFetchSuccess),
          builder: (context, state) {
            if (state is StudentFetchInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            return MissingBody();
          },
        ),
      ),
    );
  }
}
