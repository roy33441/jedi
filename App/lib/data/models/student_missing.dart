import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:jedi/data/models/missing_reason.dart';

class StudentMissing extends Equatable {
  final int? id;
  final int studentId;
  final MissingReason reason;
  final DateTime missingOn;

  StudentMissing({
    this.id,
    required this.studentId,
    required this.reason,
    required this.missingOn,
  });

  @override
  List<Object?> get props => [id, studentId, reason, missingOn];

  Map<String, dynamic> toJson() {
    return {
      'missing_student_id': id,
      'student_id': studentId,
      'reason': reason.toJson(),
      'missing_on': DateFormat('y-M-d').format(missingOn),
    };
  }

  factory StudentMissing.fromJson(Map<String, dynamic> map) {
    return StudentMissing(
      id: map['missing_student_id'],
      studentId: map['student_id'],
      reason: MissingReason.fromJson(map['reason']),
      missingOn: DateFormat('y-M-d').parse(map['missing_on']),
    );
  }
}
