import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/constants/rest_routes.dart';
import '../../core/utils/format_date.dart';
import '../models/student_report.dart';
import 'remote_data_provider.dart';

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
