import 'package:equatable/equatable.dart';
import 'package:jedi/core/utils/format_date.dart';

import 'package:jedi/data/models/report_type.dart';

class StudentReport extends Equatable {
  final int? id;
  final int studentId;
  final ReportType reportType;
  final DateTime dateReported;

  StudentReport({
    this.id,
    required this.studentId,
    required this.reportType,
    required this.dateReported,
  });

  @override
  List<Object?> get props => [id, studentId, reportType, dateReported];

  Map<String, dynamic> toJson() {
    return {
      'student_report_id': id,
      'student_id': studentId,
      'report_type': reportType.toJson(),
      'date_reported': FormatDate.format(dateReported),
    };
  }

  factory StudentReport.fromJson(Map<String, dynamic> map) {
    return StudentReport(
      id: map['student_report_id'],
      studentId: map['student_id'],
      reportType: ReportType.fromJson(map['report_type']),
      dateReported: DateTime.parse(map['date_reported']),
    );
  }
}
