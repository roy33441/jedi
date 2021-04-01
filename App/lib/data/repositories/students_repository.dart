import 'package:jedi/data/data_providers/students_data_provider.dart';
import 'package:jedi/logic/entities/student.dart';

class StudentsRepository {
  final StudentsRemoteDataProvider remoteDataProvider;

  StudentsRepository({required this.remoteDataProvider});

  Future<List<StudentEntity>> getStudentsInCourse(int courseId) async {
    final studentsModels =
        await this.remoteDataProvider.readStudentsInCourse(courseId);

    return studentsModels
        .map((student) => StudentEntity.fromModel(student))
        .toList();
  }

  Future<StudentEntity> studentArrived(int studentId) async {
    return StudentEntity.fromModel(
        (await remoteDataProvider.studentArrived(studentId)));
  }

  Future<StudentEntity> studentLeft(int studentId) async {
    return StudentEntity.fromModel(
        (await remoteDataProvider.studentLeft(studentId)));
  }
}
