import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jedi/data/repositories/student_missing_repository.dart';

import '../../../data/repositories/missing_catagory_repository.dart';
import '../../bloc/students_bloc/students_bloc.dart';
import '../../entities/missing_reason.dart';
import '../../entities/student.dart';
import '../../entities/student_missing.dart';
import '../student_missing/student_missing_cubit.dart';

part 'report_missing_students_state.dart';

class ReportMissingStudentsCubit extends Cubit<ReportMissingStudentsState> {
  final MissingReasonRepository missingReasonRepository;
  final StudentMissingRepository studentMissingRepository;
  StreamSubscription? _streamSub;
  StreamSubscription? _streamSubStudentsMissing;
  StreamSubscription? _streamSubStudents;
  final StudentsBloc studentsBloc;
  final StudentMissingCubit studentMissingCubit;

  ReportMissingStudentsCubit({
    required this.studentsBloc,
    required this.studentMissingCubit,
    required this.missingReasonRepository,
    required this.studentMissingRepository,
  }) : super(ReportMissingStudentsInProgress()) {
    studentMissingCubit.getMissingStudentsToday();
    getMissingReasons();
    listenStreams();
  }

  void listenStreams() {
    _streamSubStudents = studentsBloc.stream.listen((studentsState) {
      emit(_mapStudentsAndMissingToState(
          studentsState, state, studentMissingCubit.state));
    });
    _streamSubStudentsMissing =
        studentMissingCubit.stream.listen((studentsMissingState) {
      emit(_mapStudentsAndMissingToState(
          studentsBloc.state, state, studentsMissingState));
    });
    _streamSub = stream.listen((state) {
      emit(_mapStudentsAndMissingToState(
          studentsBloc.state, state, studentMissingCubit.state));
    });
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

  void reportMissingStudent(StudentEntity student) async {
    final currentState = state;
    if (currentState is ReportMissingStudentsSuccess) {
      emit(ReportMissingStudentsSuccess(
        missingStudents: currentState.missingStudents,
        missingReason: currentState.missingReason,
        studentsMissingWithReason: [...currentState.studentsMissingWithReason]
          ..add(
            StudentMissingEntity(
              studentId: student.id,
              reason: currentState.missingReason,
              missingOn: DateTime.now(),
            ),
          ),
        missingReasons: currentState.missingReasons,
      ));

      final reoprtStudentMissingResult =
          await studentMissingRepository.reportStudentMissingReasonToday(
        student.id,
        currentState.missingReason,
      );

      if (reoprtStudentMissingResult.isLeft()) {
        emit(ReportMissingStudentsFailure(
            prevState: currentState.copyWith(
              missingStudents: [...currentState.missingStudents]
                ..remove(student),
            ),
            failedStudent: student));
      }
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
