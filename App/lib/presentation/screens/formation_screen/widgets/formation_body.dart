import 'package:flutter/material.dart';
import 'package:jedi/logic/entities/student.dart';
import 'package:jedi/presentation/widgets/statistics_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          StatisticsContainer(
            showIndicator: false,
            screenPortion: 0.18,
          ),
          Builder(builder: (context) {
            final missingStudents = context.watch<>()
            return ListView(
              children: ListTile.divideTiles(tiles: _missingStudentsTiles()),
            );
          },)
        ],
      ),
    );
  }

  List<ListTile> _missingStudentsTiles(List<StudentEntity> missingStudents) {
    return missingStudents
        .map(
          (student) => ListTile(
            title: Text(
              student.full_name,
              textAlign: TextAlign.center,
            ),
            leading: Icon(
              Icons.stop_circle,
              color: Theme.of(context).errorColor,
            ),
          ),
        )
        .toList();
  }
}
