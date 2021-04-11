part of 'report_missing_students_cubit.dart';

enum ReportMissingStudentsStatus { initial, loading, succuess, failure }

class ReportMissingStudentsState extends Equatable {
  final StudentEntity? failedStudent;
  final MissingReasonEntity? missingReason;
  final List<MissingReasonEntity>? missingReasons;
  final List<StudentEntity> missingStudents;
  final List<StudentMissingEntity> studentsMissingWithReason;
  final ReportMissingStudentsStatus status;

  ReportMissingStudentsState({
    this.failedStudent,
    this.missingReason,
    this.missingReasons,
    this.missingStudents = const <StudentEntity>[],
    this.studentsMissingWithReason = const <StudentMissingEntity>[],
    this.status = ReportMissingStudentsStatus.initial,
  });

  List<StudentEntity> get missingStudentsByEntity =>
      [...studentsMissingWithReason]
          .where((student) => student.reason == this.missingReason)
          .map((missingStudent) => missingStudents
              .firstWhere((student) => missingStudent.studentId == student.id))
          .toList();

  List<StudentEntity> get missingStudentsWithoutReason =>
      [...missingStudents].where((student) {
        return studentsMissingWithReason.indexWhere(
                (studentMissing) => studentMissing.studentId == student.id) ==
            -1;
      }).toList();

  ReportMissingStudentsState copyWith({
    StudentEntity? failedStudent,
    List<StudentEntity>? missingStudents,
    MissingReasonEntity? missingReason,
    List<StudentMissingEntity>? studentsMissingWithReason,
    List<MissingReasonEntity>? missingReasons,
    ReportMissingStudentsStatus? status,
  }) {
    return ReportMissingStudentsState(
        failedStudent: failedStudent ?? this.failedStudent,
        missingStudents: missingStudents ?? this.missingStudents,
        missingReason: missingReason ?? this.missingReason,
        studentsMissingWithReason:
            studentsMissingWithReason ?? this.studentsMissingWithReason,
        missingReasons: missingReasons ?? this.missingReasons,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        missingReason,
        missingReasons,
        missingStudents,
        studentsMissingWithReason,
        failedStudent,
        status,
      ];
}
