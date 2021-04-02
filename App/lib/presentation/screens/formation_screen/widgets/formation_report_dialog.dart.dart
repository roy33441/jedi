import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/core/constants/strings.dart';
import 'package:jedi/core/themes/app_theme.dart';
import 'package:jedi/logic/cubit/report_type/report_type_cubit.dart';
import 'package:jedi/logic/cubit/student_report/student_report_cubit.dart';
import 'package:jedi/logic/entities/report_type.dart';
import 'package:jedi/logic/entities/student.dart';
import 'package:jedi/logic/entities/student_report.dart';

class FormationReportDialog extends StatelessWidget {
  final StudentEntity student;
  const FormationReportDialog({Key? key, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportTypesState = context.watch<ReportTypeCubit>().state;
    final studentReportState = context.watch<StudentReportCubit>().state;

    if (studentReportState is StudentReportSaveSuccess) {
      Navigator.of(context).pop();
    }

    if (reportTypesState is ReportTypeFetchSuccess &&
        studentReportState is StudentReportTodayFetchSuccess) {
      return _fetchReportTypesSuccess(
        context,
        reportTypesState,
        studentReportState,
      );
    } else {
      return _fetchReportTypesInProgress(context);
    }
  }

  Widget _fetchReportTypesInProgress(BuildContext context) {
    final circularProgressIndicatorSize =
        MediaQuery.of(context).size.height * 0.1;

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
        height: circularProgressIndicatorSize,
        child: Center(
          child: SizedBox(
            height: circularProgressIndicatorSize,
            width: circularProgressIndicatorSize,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).success),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fetchReportTypesSuccess(
    BuildContext context,
    ReportTypeFetchSuccess reportTypeState,
    StudentReportTodayFetchSuccess studentReportState,
  ) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Text(
          student.fullName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: _buildFormationReportTypesCheckboxes(
                context,
                reportTypeState,
                studentReportState,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    Strings.saveReport,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                onPressed: () {
                  context.read<StudentReportCubit>().saveStudentReports();
                },
                color: Theme.of(context).success,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormationReportTypesCheckboxes(
    BuildContext context,
    ReportTypeFetchSuccess reportTypeState,
    StudentReportTodayFetchSuccess studentReportState,
  ) {
    final studentReportCubit = context.read<StudentReportCubit>();

    return reportTypeState.reportTypes
        .map((type) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  activeColor: Theme.of(context).success,
                  value: studentReportState
                      .doesHaveReportFromType(type.reportTypeId),
                  onChanged: (value) {
                    if (value == false) {
                      studentReportCubit
                          .removeReportToStudent(type.reportTypeId);
                    } else {
                      studentReportCubit.addReportToStudent(
                        StudentReportEntity(
                          studentId: studentReportState.studentId,
                          reportType: type,
                          dateReported: DateTime.now(),
                        ),
                      );
                    }
                  },
                ),
                Text(
                  type.name,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ))
        .toList();
  }
}
