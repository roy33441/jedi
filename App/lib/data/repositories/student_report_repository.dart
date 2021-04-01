import 'package:jedi/data/data_providers/student_report_provider.dart';
import 'package:jedi/logic/entities/student_report.dart';

class StudentReportRepository {
  final StudentReportRemoteDataProvider remoteDataProvider;

  StudentReportRepository({required this.remoteDataProvider});

  Future<List<StudentReportEntity>> getStudentReportsToday(
      int studentId) async {
    final rawStudentReports =
        await remoteDataProvider.readStudentReportsToday(studentId);

    return List<StudentReportEntity>.from(
      rawStudentReports.map((rawStudentReport) =>
          StudentReportEntity.fromModel(rawStudentReport)),
    );
  }

  Future<List<StudentReportEntity>> saveStudentReportsByDate(
    int studentId,
    List<StudentReportEntity> studentReports,
  ) async {
    final rawStudentReports = await remoteDataProvider.saveStudentReportsByDate(
      studentId,
      studentReports
          .map((studentReportEntity) => studentReportEntity.toModel())
          .toList(),
    );

    return List<StudentReportEntity>.from(
      rawStudentReports.map((rawStudentReport) =>
          StudentReportEntity.fromModel(rawStudentReport)),
    );
  }
}
