import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jedi/data/models/student.dart';

import 'package:jedi/data/repositories/student_report_repository.dart';
import 'package:jedi/logic/entities/student_report.dart';

part 'student_report_state.dart';

class StudentReportCubit extends Cubit<StudentReportState> {
  final StudentReportRepository repository;

  StudentReportCubit({required this.repository})
      : super(StudentReportInitial());

  Future<void> getStudentReportsToday(int studentId) async {
    emit(StudentReportTodayFetchInProgress());
    final studentReports = await repository.getStudentReportsToday(studentId);
    emit(StudentReportTodayFetchSuccess(
        studentReports: studentReports, studentId: studentId));
  }

  Future<void> saveStudentReports() async {
    final currentState = state;

    if (currentState is StudentReportTodayFetchSuccess) {
      emit(StudentReportSaveInProgress());
      await repository.saveStudentReportsByDate(
          currentState.studentId, List.of(currentState.studentReports));
      emit(StudentReportSaveSuccess());
    } else {
      // TODO: handle exception
      throw Exception();
    }
  }

  void addReportToStudent(StudentReportEntity newStudentReport) {
    final currentState = state;

    if (currentState is StudentReportTodayFetchSuccess) {
      final newStudentReports = List.of(currentState.studentReports)
        ..add(newStudentReport);

      emit(StudentReportTodayFetchSuccess(
        studentReports: newStudentReports,
        studentId: currentState.studentId,
      ));
    } else {
      // TODO: handle exception
      throw Exception();
    }
  }

  void removeReportToStudent(int reportTypeId) {
    final currentState = state;

    if (currentState is StudentReportTodayFetchSuccess) {
      emit(
        StudentReportTodayFetchSuccess(
          studentReports: List.of(currentState.studentReports)
              .where((studentReport) =>
                  studentReport.reportType.reportTypeId != reportTypeId)
              .toList(),
          studentId: currentState.studentId,
        ),
      );
    } else {
      // TODO: handle exception
      throw Exception();
    }
  }
}
