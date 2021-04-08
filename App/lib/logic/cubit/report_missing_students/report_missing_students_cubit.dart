import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/missing_catagory_repository.dart';
import '../../bloc/students_bloc/students_bloc.dart';
import '../../entities/missing_reason.dart';
import '../../entities/student.dart';
import '../../entities/student_missing.dart';
import '../student_missing/student_missing_cubit.dart';

part 'report_missing_students_state.dart';

class ReportMissingStudentsCubit extends Cubit<ReportMissingStudentsState> {
  final MissingReasonRepository missingReasonRepository;
  StreamSubscription? _streamSub;
  StreamSubscription? _streamSubStudentsMissing;
  StreamSubscription? _streamSubStudents;
  final StudentsBloc studentsBloc;
  final StudentMissingCubit studentMissingCubit;

  ReportMissingStudentsCubit({
    required this.studentsBloc,
    required this.studentMissingCubit,
    required this.missingReasonRepository,
  }) : super(ReportMissingStudentsInProgress()) {
    studentMissingCubit.getMissingStudentsToday();
    getMissingReasons();
    _streamSubStudents = studentsBloc.stream.listen((event) {});
    _streamSubStudentsMissing = studentMissingCubit.stream.listen((event) {});
    _streamSub = stream.listen((event) {});
  }

  ReportMissingStudentsState _mapStudentsAndMissingToState(
    StudentsState studentState,
    ReportMissingStudentsState currentState,
    StudentMissingState missingStudentState,
  ) {
    if (studentState is StudentFetchSuccess &&
        missingStudentState is StudentMissingTodayFetchSuccess &&
        currentState is ReportMissingStudentsFetchReasonsSuccuess) {
      return ReportMissingStudentsSuccess(
        missingStudents: studentState.missingStudents,
        missingReason: currentState.missingReason,
        studentsMissingWithReason: missingStudentState.missingStudents,
        missingReasons: currentState.missingReasons,
      );
    }
    return currentState;
  }

  Future<void> getMissingReasons() async {
    emit(ReportMissingStudentsInProgress());
    final missingReasons = await missingReasonRepository.getMissingReasons();
    emit(ReportMissingStudentsFetchReasonsSuccuess(
      missingReason: missingReasons.length > 0
          ? missingReasons[0]
          : MissingReasonEntity(id: 666, text: 'רועיקי וגוסיר'),
      missingReasons: missingReasons,
    ));
  }

  void changeReason(String missingReason) {
    final currentState = state;
    if (currentState is ReportMissingStudentsSuccess) {
      emit(ReportMissingStudentsSuccess(
        missingStudents: currentState.missingStudents,
        missingReason: currentState.missingReasons
            .firstWhere((reason) => reason.text == missingReason),
        studentsMissingWithReason: currentState.studentsMissingWithReason,
        missingReasons: currentState.missingReasons,
      ));
    } else if (currentState is ReportMissingStudentsFetchReasonsSuccuess) {
      emit(ReportMissingStudentsFetchReasonsSuccuess(
        missingReason: currentState.missingReasons
            .firstWhere((reason) => reason.text == missingReason),
        missingReasons: currentState.missingReasons,
      ));
    }
  }

  @override
  Future<void> close() {
    _streamSub?.cancel();
    _streamSubStudents?.cancel();
    _streamSubStudentsMissing?.cancel();
    return super.close();
  }
}
