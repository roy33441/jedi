
import 'package:dio/dio.dart';

import '../../core/constants/rest_routes.dart';
import '../models/student.dart';
import 'remote_data_provider.dart';

class StudentsRemoteDataProvider extends RemoteDataProvider {
  StudentsRemoteDataProvider({required Dio client}) : super(client: client);

  Future<List<Student>> readStudentsInCourse(int courseId) async {
    final response =
        await client.get<List>(RestRoutes.fetchStudentInCourse(courseId));
    return List<Student>.from(
      response.data!.map((studentMap) => Student.fromJson(studentMap)),
    );
  }

  Future<Student> studentArrived(int cardId, int courseId) async {
    final response =
        await client.patch(RestRoutes.studentArrived(cardId, courseId));

    if (response.statusCode != 200) {
      // TODO add throw clause
      throw Exception();
    }

    return Student.fromJson(response.data);
  }

  Future<Student> studentLeft(int cardId, int courseId) async {
    final response =
        await client.patch(RestRoutes.studentLeft(cardId, courseId));

    if (response.statusCode != 200) {
      // TODO add throw clause
      throw Exception();
    }

    return Student.fromJson(response.data);
  }
}
