import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../bloc/students_bloc/students_bloc.dart';
import '../../entities/student.dart';

part 'manual_report_state.dart';

class ManualReportCubit extends Cubit<ManualReportState> {
  StreamSubscription? _studentsBlocSubscription;

  ManualReportCubit(StudentsBloc studentsBloc)
      : super(ManualReportStudentActionInProgress()) {
    _studentsBlocSubscription = studentsBloc.stream.listen(_emitStudentsState);

    _emitStudentsState(studentsBloc.state);
  }

  void _emitStudentsState(state) {
    if (state is StudentFetchSuccess) {
      emit(ManualReportStudentsFetchSuccess(
          missingStudents: state.missingStudents));
    }
  }

  void unselectStudent() {
    final currentState = state;
    if (currentState is ManualReportStudentPicked) {
      emit(ManualReportStudentsFetchSuccess(
          missingStudents: List.of(currentState.missingStudents)));
    }
  }

  void pickStudent(StudentEntity pickedStudent) {
    final currentState = state;

    if (currentState is ManualReportStudentsFetchSuccess) {
      emit(ManualReportStudentPicked(
        student: pickedStudent,
        missingStudents: List.of(currentState.missingStudents),
      ));
    }
  }

  @override
  Future<void> close() {
    _studentsBlocSubscription?.cancel();
    return super.close();
  }
}
