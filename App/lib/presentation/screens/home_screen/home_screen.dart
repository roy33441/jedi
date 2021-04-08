import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_theme.dart';
import '../../../logic/bloc/students_bloc/students_bloc.dart';
import 'widgets/home_body.dart';
import 'widgets/student_arrived_flushbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StudentsBloc, StudentsState>(
        listener: (context, state) {
          if (state is StudentArrivedSuccess) {
            StudentArrivedFlushBar(studentName: state.arrivedStudent.fullName)
              ..show(context);
          }
        },
        buildWhen: (previous, current) => !(previous is StudentFetchSuccess &&
            current is StudentFetchSuccess),
        builder: (context, state) {
          if (state is StudentFetchInProgress) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Theme.of(context).success),
              ),
            );
          }
          return HomeBody();
        },
      ),
    );
  }
}
