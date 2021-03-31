import 'package:flutter/material.dart';
import 'package:jedi/logic/bloc/students_bloc/students_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        context.read<StudentsBloc>().add(StudentArrived(studentId: 1));
      },
      minWidth: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: Theme.of(context).highlightColor,
      textColor: Theme.of(context).textTheme.bodyText2!.color,
      child: Icon(Icons.nights_stay),
      shape: CircleBorder(),
    );
  }
}
