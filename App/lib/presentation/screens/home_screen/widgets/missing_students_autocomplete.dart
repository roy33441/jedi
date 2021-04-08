import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jedi/logic/bloc/students_bloc/students_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/logic/cubit/manual_report/manual_report_cubit.dart';
import 'package:jedi/logic/entities/student.dart';
import '../../../../core/themes/app_theme.dart';

class MissingStudentsAutocomplete extends HookWidget {
  const MissingStudentsAutocomplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final manualReportState = context.watch<ManualReportCubit>().state;
    final TextEditingController controller = useTextEditingController();

    if (manualReportState is ManualReportStudentPicked) {
      controller.text = manualReportState.student.fullName;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: TypeAheadField<StudentEntity>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
              decoration: new InputDecoration(
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'בחרו חניך',
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: 10,
                  )),
            ),
            itemBuilder: (BuildContext context, StudentEntity student) {
              return _autocompleteTile(context, student.fullName, true);
            },
            noItemsFoundBuilder: (context) {
              return _autocompleteTile(
                  context, 'אין חניך בקורס עם השם הזה', false);
            },
            onSuggestionSelected: (StudentEntity suggestion) {
              context.read<ManualReportCubit>().pickStudent(suggestion);
            },
            suggestionsCallback: (String pattern) {
              if (manualReportState is ManualReportStudentPicked) {
                context.read<ManualReportCubit>().unselectStudent();
              }

              if (manualReportState is ManualReportStudentsFetchSuccess) {
                return manualReportState.filteredMissingStudents(pattern);
              }

              return [];
            },
          ),
        ),
        if (manualReportState is ManualReportStudentPicked)
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.03),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Theme.of(context).success,
              onPressed: () {
                if (manualReportState is ManualReportStudentPicked) {
                  context.read<StudentsBloc>().add(
                        StudentArrived(
                          cardId: manualReportState.student.certificateNumber,
                          courseId: 1,
                        ),
                      );

                  Navigator.of(context).pop();
                }
              },
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'החניך נמצא',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          )
      ],
    );
  }

  Widget _autocompleteTile(BuildContext context, String title, bool showIcon) {
    return Column(
      children: [
        ListTile(
          leading: showIcon
              ? Icon(
                  Icons.circle,
                  color: Theme.of(context).errorColor,
                )
              : null,
          minVerticalPadding: 0,
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Divider(
            thickness: 1,
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}
