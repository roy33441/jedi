import 'package:dio/dio.dart';
import 'package:jedi/core/constants/rest_routes.dart';
import 'package:jedi/data/data_providers/remote_data_provider.dart';
import 'package:jedi/data/models/course.dart';

class CoursesDataProvider extends RemoteDataProvider {
  CoursesDataProvider({required Dio client}) : super(client: client);

  Future<List<Course>> getOpenCourses() async {
    final response = await client.get<List>(RestRoutes.openCourses);
    return List<Course>.from(
      response.data!.map((course) => Course.fromJson(course)),
    );
  }
}
