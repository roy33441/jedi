import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../logic/bloc/students_bloc/students_bloc.dart';
import '../../../../logic/cubit/student_missing/student_missing_cubit.dart';
import '../../../../logic/entities/student.dart';
import '../extensions/rtl_scrollable_list_view.dart';

class MissingStudentsListView extends HookWidget {
  const MissingStudentsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ScrollController _controller = useScrollController();

    final missingStudents = context.select((StudentsBloc bloc) =>
        (bloc.state as StudentFetchSuccess).missingStudents);
    final studentMissingReasonState =
        context.watch<StudentMissingCubit>().state;

    if (studentMissingReasonState is StudentMissingTodayFetchSuccess) {
      return _buildMissingList(
        _controller,
        missingStudents,
        studentMissingReasonState,
      ).addRtlAndScroll(
        context: context,
        controller: _controller,
        mediaQuerySize: size,
      );
    } else {
      return _fetchInProgress(context);
    }
  }

  Widget _fetchInProgress(BuildContext context) {
    final indicatorSize = MediaQuery.of(context).size.height * 0.15;
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Center(
        child: SizedBox(
            height: indicatorSize,
            width: indicatorSize,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).success,
              ),
            )),
      ),
    );
  }

  ListView _buildMissingList(
    ScrollController _controller,
    List<StudentEntity> missingStudents,
    StudentMissingTodayFetchSuccess state,
  ) {
    return ListView.separated(
        controller: _controller,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            title: Text(
              missingStudents[index].fullName,
              style: TextStyle(color: Colors.black, fontSize: 18),
              // textAlign: TextAlign.center,
            ),
            leading: Icon(
              Icons.circle,
              color: Theme.of(context).errorColor,
            ),
            trailing: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                state
                    .getStudentMissingReason(
                        studentId: missingStudents[index].id)
                    .fold(
                      (_) => '',
                      (missingReason) => missingReason.text,
                    ),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            indent: 30,
            endIndent: 30,
            color: Colors.black,
          );
        },
        itemCount: missingStudents.length);
  }
}
