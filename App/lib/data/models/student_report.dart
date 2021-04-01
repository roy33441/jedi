import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:jedi/data/models/report_type.dart';
import 'package:intl/intl.dart';

class StudentReport extends Equatable {
  final int? studentReportId;
  final int studentId;
  final ReportType reportType;
  final DateTime dateReported;

  StudentReport({
    this.studentReportId,
    required this.studentId,
    required this.reportType,
    required this.dateReported,
  });

  @override
  List<Object?> get props =>
      [studentReportId, studentId, reportType, dateReported];

  Map<String, dynamic> toJson() {
    return {
      'student_report_id': studentReportId,
      'student_id': studentId,
      'report_type': reportType.toJson(),
      'date_reported': dateReported.millisecondsSinceEpoch,
    };
  }

  factory StudentReport.fromJson(Map<String, dynamic> map) {
    return StudentReport(
      studentReportId: map['student_report_id'],
      studentId: map['student_id'],
      reportType: ReportType.fromJson(map['report_type']),
      dateReported: DateFormat('y-M-d').parse(map['date_reported']),
    );
  }
}
