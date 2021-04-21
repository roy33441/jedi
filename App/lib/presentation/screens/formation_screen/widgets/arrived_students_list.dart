import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../logic/bloc/students_bloc/students_bloc.dart';
import '../../../../logic/cubit/student_report/student_report_cubit.dart';
import '../../../../logic/entities/student.dart';
import '../extensions/rtl_scrollable_list_view.dart';
import 'formation_report_dialog.dart.dart';

class ArrivedStudentsListView extends HookWidget {
  const ArrivedStudentsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final ScrollController _controller = useScrollController();
    final arrivedStudents = context.select((StudentsBloc bloc) =>
        (bloc.state as StudentFetchSuccess).arrivedStudents);

    return _buildArrivedList(_controller, arrivedStudents).addRtlAndScroll(
      context: context,
      controller: _controller,
      mediaQuerySize: size,
      height: 0.35,
    );
  }

  ListView _buildArrivedList(
      ScrollController _controller, List<StudentEntity> arrivedStudents) {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => _showFormationReportDialog(
            context,
            arrivedStudents[index],
          ),
          horizontalTitleGap: -double.infinity,
          dense: true,
          title: Center(
            child: Text(
              arrivedStudents[index].fullName,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          leading: Icon(
            Icons.circle,
            color: Theme.of(context).success,
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
      itemCount: arrivedStudents.length,
    );
  }

  Future<void> _showFormationReportDialog(
      BuildContext context, StudentEntity clickedStudent) {
    context
        .read<StudentReportCubit>()
        .getStudentReportsToday(clickedStudent.id);

    return showDialog(
      context: context,
      builder: (_) => FormationReportDialog(
        student: clickedStudent,
      ),
    );
  }
}
