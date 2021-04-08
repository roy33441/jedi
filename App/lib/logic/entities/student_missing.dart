import 'package:equatable/equatable.dart';
import 'package:jedi/data/models/student_missing.dart';
import 'package:jedi/logic/entities/missing_reason.dart';

class StudentMissingEntity extends Equatable {
  final int studentId;
  final MissingReasonEntity reason;
  final DateTime missingOn;

  StudentMissingEntity({
    required this.studentId,
    required this.reason,
    required this.missingOn,
  });

  @override
  List<Object?> get props => [studentId, reason, missingOn];

  StudentMissing toModel() => StudentMissing(
        studentId: studentId,
        reason: reason.toModel(),
        missingOn: missingOn,
      );

  factory StudentMissingEntity.fromModel(StudentMissing studentMissingModel) {
    return StudentMissingEntity(
      studentId: studentMissingModel.studentId,
      reason: MissingReasonEntity.fromModel(studentMissingModel.reason),
      missingOn: studentMissingModel.missingOn,
    );
  }
}
