import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:jedi/data/models/student_report.dart';
import 'package:jedi/logic/entities/report_type.dart';

class StudentReportEntity extends Equatable {
  final int studentId;
  final ReportTypeEntity reportType;
  final DateTime dateReported;

  StudentReportEntity({
    required this.studentId,
    required this.reportType,
    required this.dateReported,
  });

  @override
  List<Object?> get props => [studentId, reportType, dateReported];

  StudentReport toModel() => StudentReport(
        studentId: studentId,
        reportType: reportType.toModel(),
        dateReported: dateReported,
      );

  factory StudentReportEntity.fromModel(StudentReport studentModel) =>
      StudentReportEntity(
        studentId: studentModel.studentId,
        reportType: ReportTypeEntity.fromModel(studentModel.reportType),
        dateReported: studentModel.dateReported,
      );
}
