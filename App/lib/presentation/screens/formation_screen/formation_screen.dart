import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jedi/logic/bloc/students_bloc/students_bloc.dart';
import 'package:jedi/presentation/screens/formation_screen/widgets/formation_body.dart';

class FormationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StudentsBloc, StudentsState>(
        buildWhen: (previous, current) => !(previous is StudentFetchSuccess &&
            current is StudentFetchSuccess),
        builder: (context, state) {
          if (state is StudentFetchInProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return FormationBody();
        },
      ),
    );
  }
}
