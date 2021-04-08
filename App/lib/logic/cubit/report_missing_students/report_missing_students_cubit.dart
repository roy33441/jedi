import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jedi/data/repositories/missing_catagory_repository.dart';
import 'package:jedi/logic/cubit/student_missing/student_missing_cubit.dart';
import 'package:jedi/logic/entities/missing_reason.dart';
import 'package:jedi/logic/entities/student_missing.dart';
import 'package:rxdart/rxdart.dart';

import '../../bloc/students_bloc/students_bloc.dart';
import '../../entities/student.dart';

part 'report_missing_students_state.dart';

class ReportMissingStudentsCubit extends Cubit<ReportMissingStudentsState> {
  final MissingReasonRepository missingReasonRepository;
  StreamSubscription? _streamSub;

  ReportMissingStudentsCubit({
    required StudentsBloc studentsBloc,
    required StudentMissingCubit studentMissingCubit,
    required this.missingReasonRepository,
  }) : super(ReportMissingStudentsInProgress()) {
    _streamSub = Rx.combineLatest3<StudentsState, StudentMissingState,
        ReportMissingStudentsState, ReportMissingStudentsState>(
      studentsBloc.stream,
      studentMissingCubit.stream,
      stream,
      _mapStudentsAndMissingToState,
    ).listen((state) {
      emit(state);
    });

    studentMissingCubit.getMissingStudentsToday();
    getMissingReasons();
  }

  ReportMissingStudentsState _mapStudentsAndMissingToState(
      StudentsState studentState,
      StudentMissingState missingStudentState,
      ReportMissingStudentsState currentState) {
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
    return super.close();
  }
}
