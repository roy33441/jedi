import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/core/themes/app_theme.dart';
import 'package:jedi/logic/bloc/students_bloc/students_bloc.dart';
import 'package:jedi/logic/cubit/report_type/report_type_cubit.dart';
import 'package:jedi/logic/cubit/student_missing/student_missing_cubit.dart';
import 'package:jedi/presentation/screens/formation_screen/widgets/formation_body.dart';

class FormationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<StudentMissingCubit>().getMissingStudentsToday();
    context.read<ReportTypeCubit>().getReportTypes();

    return Scaffold(
      body: BlocBuilder<StudentsBloc, StudentsState>(
        buildWhen: (previous, current) => !(previous is StudentFetchSuccess &&
            current is StudentFetchSuccess),
        builder: (context, studentsState) {
          final missingStudentsState =
              context.watch<StudentMissingCubit>().state;

          if (studentsState is StudentFetchInProgress ||
              missingStudentsState is StudentMissingTodayFetchInProgress) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Theme.of(context).success),
              ),
            );
          } else {
            return FormationBody();
          }
        },
      ),
    );
  }
}
