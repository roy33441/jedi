import 'package:flutter/material.dart';
import 'package:jedi/logic/bloc/students_bloc/students_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jedi/logic/entities/student.dart';
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

    return _buildMissingList(_controller, missingStudents).addRtlAndScroll(
      context: context,
      controller: _controller,
      mediaQuerySize: size,
    );
  }

  ListView _buildMissingList(
      ScrollController _controller, List<StudentEntity> missingStudents) {
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
            trailing: Text(
              'התמקצעות',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
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
