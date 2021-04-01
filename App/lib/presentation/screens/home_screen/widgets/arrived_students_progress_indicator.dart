import 'package:flutter/material.dart';
import 'package:jedi/logic/bloc/students_bloc/students_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArrivedStudentsProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentsBloc>().state as StudentFetchSuccess;
    final size = MediaQuery.of(context).size;
    final ratio = state.arrivedStudentsCount / state.students.length;

    return Container(
      width: size.width * 0.22,
      height: size.width * 0.22,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
            begin: ratio > 0 ? ratio - (1 / state.students.length) : 0,
            end: ratio),
        duration: Duration(milliseconds: 900),
        builder: (context, value, _) {
          return CircularProgressIndicator(
            strokeWidth: 15,
            value: value,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).highlightColor,
            ),
            backgroundColor: Theme.of(context).textTheme.bodyText2!.color,
          );
        },
      ),
    );
  }
}
