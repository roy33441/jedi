import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jedi/core/constants/rest_routes.dart';
import 'package:jedi/data/models/student.dart';

class StudentsRemoteDataProvider {
  final Dio client;

  StudentsRemoteDataProvider({required this.client});

  Future<List<Student>> readStudentsInCourse(int courseId) async {
    final response = await client.get<List>(RestRoutes.fetchStudentInCourse(1));
    return List<Student>.from(
      response.data!.map((studentMap) => Student.fromJson(studentMap)),
    );
  }

  Future<Student> studentArrived(
    int studentId,
  ) async {
    final response = await client.patch(RestRoutes.studentArrived(studentId));

    if (response.statusCode != 200) {
      // TODO add throw clause
      throw Exception();
    }

    return Student.fromJson(json.decode(response.data));
  }

  Future<Student> studentLeft(
    int studentId,
  ) async {
    final response = await client.patch(RestRoutes.studentLeft(studentId));

    if (response.statusCode != 200) {
      // TODO add throw clause
      throw Exception();
    }

    return Student.fromJson(json.decode(response.data));
  }
}
