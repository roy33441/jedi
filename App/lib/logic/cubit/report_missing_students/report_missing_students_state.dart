part of 'report_missing_students_cubit.dart';

abstract class ReportMissingStudentsState extends Equatable {
  const ReportMissingStudentsState();

  @override
  List<Object> get props => [];
}

class ReportMissingStudentsInProgress extends ReportMissingStudentsState {}

class ReportMissingStudentsFetchReasonsSuccuess
    extends ReportMissingStudentsState {
  final MissingReasonEntity missingReason;
  final List<MissingReasonEntity> missingReasons;

  ReportMissingStudentsFetchReasonsSuccuess({
    required this.missingReason,
    required this.missingReasons,
  });

  @override
  List<Object> get props => [missingReason, missingReasons];
}

class ReportMissingStudentsSuccess
    extends ReportMissingStudentsFetchReasonsSuccuess {
  final List<StudentEntity> missingStudents;
  final List<StudentMissingEntity> studentsMissingWithReason;

  ReportMissingStudentsSuccess({
    required this.missingStudents,
    required MissingReasonEntity missingReason,
    required this.studentsMissingWithReason,
    required List<MissingReasonEntity> missingReasons,
  }) : super(missingReason: missingReason, missingReasons: missingReasons);

  @override
  List<Object> get props => [
        missingReason,
        missingReasons,
        missingStudents,
        studentsMissingWithReason
      ];

  List<StudentEntity> get missingStudentsByEntity =>
      [...studentsMissingWithReason]
          .where((student) => student.reason == this.missingReason)
          .map((missingStudent) => missingStudents
              .firstWhere((student) => missingStudent.studentId == student.id))
          .toList();

  ReportMissingStudentsSuccess copyWith({
    List<StudentEntity>? missingStudents,
    MissingReasonEntity? missingReason,
    List<StudentMissingEntity>? studentsMissingWithReason,
    List<MissingReasonEntity>? missingReasons,
  }) {
    return ReportMissingStudentsSuccess(
      missingStudents: missingStudents ?? this.missingStudents,
      missingReason: missingReason ?? this.missingReason,
      studentsMissingWithReason:
          studentsMissingWithReason ?? this.studentsMissingWithReason,
      missingReasons: missingReasons ?? this.missingReasons,
    );
  }
}

class ReportMissingStudentsFailure extends ReportMissingStudentsSuccess {
  final StudentEntity failedStudent;
  ReportMissingStudentsFailure({
    required ReportMissingStudentsSuccess prevState,
    required this.failedStudent,
  }) : super(
          missingReason: prevState.missingReason,
          missingReasons: prevState.missingReasons,
          missingStudents: prevState.missingStudents,
          studentsMissingWithReason: prevState.studentsMissingWithReason,
        );

  @override
  List<Object> get props => [
        missingReason,
        missingReasons,
        missingStudents,
        studentsMissingWithReason,
        failedStudent
      ];
}
