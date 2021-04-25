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
    required int courseId,
  }) : super(ReportMissingStudentsState()) {
    studentMissingCubit.getMissingStudentsToday(courseId);
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
        currentState.missingReasons.length > 0) {
      return currentState.copyWith(
        missingStudents: studentState.missingStudents,
        studentsMissingWithReason: missingStudentState.missingStudents,
        status: ReportMissingStudentsStatus.succuess,
      );
    }
    return currentState;
  }

  Future<void> getMissingReasons() async {
    emit(state.copyWith(status: ReportMissingStudentsStatus.loading));
    final missingReasons = await missingReasonRepository.getMissingReasons();
    emit(state.copyWith(
        missingReason: missingReasons.length > 0
            ? missingReasons[0]
            : MissingReasonEntity(id: 666, text: 'רועיקי וגוסיר'),
        missingReasons: missingReasons,
        status: ReportMissingStudentsStatus.loading));
  }

  void changeReason(String missingReason) {
    final currentState = state;
    emit(currentState.copyWith(
      missingReason: currentState.missingReasons
          .firstWhere((reason) => reason.text == missingReason),
    ));
  }

  void reportMissingStudent(StudentEntity student) async {
    final currentState = state;
    if (currentState.status == ReportMissingStudentsStatus.succuess) {
      studentMissingCubit.addMissingStudent(
        StudentMissingEntity(
          studentId: student.id,
          reason: currentState.missingReason!,
          missingOn: DateTime.now(),
        ),
      );

      final reoprtStudentMissingResult =
          await studentMissingRepository.reportStudentMissingReasonToday(
        student.id,
        currentState.missingReason!,
      );

      if (reoprtStudentMissingResult.isLeft()) {
        studentMissingCubit.removeMissingStudent(student.id);
        emit(currentState.copyWith(
          failedStudent: student,
          status: ReportMissingStudentsStatus.failure,
        ));
      }
    }
  }

  void removeMissingStudent(StudentEntity student) async {
    final currentState = state;
    if (currentState.status == ReportMissingStudentsStatus.succuess) {
      final missingStudent = currentState.studentsMissingWithReason.firstWhere(
          (studentMissing) => studentMissing.studentId == student.id);

      studentMissingCubit.removeMissingStudent(student.id);

      final reoprtStudentMissingResult =
          await studentMissingRepository.removeStudentMissingReasonToday(
        student.id,
      );

      if (reoprtStudentMissingResult.isLeft()) {
        studentMissingCubit.addMissingStudent(missingStudent);
        emit(currentState.copyWith(
          failedStudent: student,
          status: ReportMissingStudentsStatus.failure,
        ));
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
