import 'package:dio/dio.dart';

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
}
