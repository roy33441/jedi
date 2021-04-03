import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:jedi/core/constants/rest_routes.dart';
import 'package:jedi/core/utils/format_date.dart';
import 'package:jedi/data/data_providers/remote_data_provider.dart';
import 'package:jedi/data/models/student_missing.dart';

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
