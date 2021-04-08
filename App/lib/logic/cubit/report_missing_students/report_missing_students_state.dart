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
}
