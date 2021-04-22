import 'package:jedi/data/data_providers/courses_data_provider.dart';
import 'package:jedi/logic/entities/course_entity.dart';

class CoursesRepository {
  final CoursesDataProvider remoteDataProvider;

  CoursesRepository({required this.remoteDataProvider});

  Future<List<CourseEntity>> fetchOpenCourses() async {
    final rawOpenCourses = await remoteDataProvider.getOpenCourses();
    return rawOpenCourses
        .map((rawCourse) => CourseEntity.fromModel(rawCourse))
        .toList();
  }
}
