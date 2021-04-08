import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jedi/core/failures/failures.dart';
import 'package:jedi/data/models/missing_reason.dart';

import '../../core/constants/rest_routes.dart';
import '../../core/utils/format_date.dart';
import '../models/student_missing.dart';
import 'remote_data_provider.dart';

class StudentMissingRemoteDataProvider extends RemoteDataProvider {
  StudentMissingRemoteDataProvider({required Dio client})
      : super(client: client);

  Future<List<StudentMissing>> readStudentsMissingToday() async {
    final response = await client.get<List>(
      RestRoutes.missingStudentsByDate(
        FormatDate.format(DateTime.now()),
      ),
    );

    return List<StudentMissing>.from(response.data!.map(
        (studentMissingJson) => StudentMissing.fromJson(studentMissingJson)));
  }

  Future<Either<StudentMissingReasonReportFailure, StudentMissing>>
      reportStudentMissingReasonToday(
    int studentId,
    MissingReason reason,
  ) async {
    try {
      final response = await client.put<Map<String, dynamic>>(
        RestRoutes.repostMissingStudentByDate(
          studentId,
          FormatDate.format(DateTime.now()),
        ),
        data: reason.toJson(),
      );
      return Right(StudentMissing.fromJson(response.data!));
    } catch (_) {
      return Left(StudentMissingReasonReportFailure());
    }
  }
}
