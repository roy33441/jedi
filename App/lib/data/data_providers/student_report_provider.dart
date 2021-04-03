import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:jedi/core/constants/rest_routes.dart';
import 'package:jedi/core/utils/format_date.dart';
import 'package:jedi/data/data_providers/remote_data_provider.dart';
import 'package:jedi/data/models/student_report.dart';

class StudentReportRemoteDataProvider extends RemoteDataProvider {
  StudentReportRemoteDataProvider({required Dio client})
      : super(client: client);

  Future<List<StudentReport>> readStudentReportsToday(int studentId) async {
    final response = await client.get<List>(
      RestRoutes.studentReportsByDate(
        studentId,
        FormatDate.format(DateTime.now()),
      ),
    );

    return List<StudentReport>.from(
      response.data!
          .map((studentReportMap) => StudentReport.fromJson(studentReportMap)),
    );
  }

  Future<List<StudentReport>> saveStudentReportsByDate(
      int studentId, List<StudentReport> studentReports) async {
    final path = RestRoutes.studentReportsByDate(
      studentId,
      FormatDate.format(DateTime.now()),
    );

    final response = await client.put<List>(
      path,
      data: json.encode(
        studentReports
            .map((studentReport) => studentReport.reportType.id)
            .toList(),
      ),
    );

    return List<StudentReport>.from(
      response.data!
          .map((studentReportMap) => StudentReport.fromJson(studentReportMap)),
    );
  }
}
