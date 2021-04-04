part of 'manual_report_cubit.dart';

abstract class ManualReportState extends Equatable {
  const ManualReportState();

  @override
  List<Object> get props => [];
}

class ManualReportStudentsFetchSuccess extends ManualReportState {
  final List<StudentEntity> missingStudents;
  final String filterPattern;

  ManualReportStudentsFetchSuccess(
      {required this.missingStudents, required this.filterPattern});

  List<StudentEntity> get filteredMissingStudents =>
      List<StudentEntity>.of(missingStudents)
          .where((student) => student.fullName.contains(filterPattern))
          .toList();

  ManualReportStudentsFetchSuccess copyWith({
    List<StudentEntity>? missingStudents,
    String? filterPattern,
  }) {
    return ManualReportStudentsFetchSuccess(
      missingStudents: missingStudents ?? this.missingStudents,
      filterPattern: filterPattern ?? this.filterPattern,
    );
  }

  @override
  List<Object> get props => [missingStudents, filterPattern];
}

class ManualReportStudentPicked extends ManualReportStudentsFetchSuccess {
  final StudentEntity student;

  ManualReportStudentPicked({
    required this.student,
    required String filterPattern,
    required List<StudentEntity> missingStudents,
  }) : super(missingStudents: missingStudents, filterPattern: filterPattern);

  @override
  List<Object> get props => [student, missingStudents, filterPattern];
}

class ManualReportStudentActionInProgress extends ManualReportState {}

class ManualReportStudentUpdateSuccess extends ManualReportState {}
