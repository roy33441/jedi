part of 'student_report_cubit.dart';

abstract class StudentReportState extends Equatable {
  const StudentReportState();

  @override
  List<Object> get props => [];
}

class StudentReportInitial extends StudentReportState {}

class StudentReportTodayFetchInProgress extends StudentReportState {}

class StudentReportTodayFetchSuccess extends StudentReportState {
  final List<StudentReportEntity> studentReports;
  final int studentId;

  StudentReportTodayFetchSuccess({
    required this.studentReports,
    required this.studentId,
  });

  @override
  List<Object> get props => [studentReports];

  bool doesHaveReportFromType(int reportTypeId) =>
      studentReports.indexWhere(
          (studentReport) => studentReport.reportType.id == reportTypeId) !=
      -1;
}

class StudentReportSaveInProgress extends StudentReportState {}

class StudentReportSaveSuccess extends StudentReportState {}
