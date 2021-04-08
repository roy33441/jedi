part of 'manual_report_cubit.dart';

abstract class ManualReportState extends Equatable {
  const ManualReportState();

  @override
  List<Object> get props => [];
}

class ManualReportStudentsFetchSuccess extends ManualReportState {
  final List<StudentEntity> missingStudents;

  ManualReportStudentsFetchSuccess({required this.missingStudents});

  List<StudentEntity> filteredMissingStudents(String filterPattern) =>
      List<StudentEntity>.of(missingStudents)
          .where((student) => student.fullName.contains(filterPattern))
          .toList();

  @override
  List<Object> get props => [missingStudents];
}

class ManualReportStudentPicked extends ManualReportStudentsFetchSuccess {
  final StudentEntity student;

  ManualReportStudentPicked({
    required this.student,
    required List<StudentEntity> missingStudents,
  }) : super(missingStudents: missingStudents);

  @override
  List<Object> get props => [student, missingStudents];
}

class ManualReportStudentActionInProgress extends ManualReportState {}

class ManualReportStudentUpdateSuccess extends ManualReportState {}
