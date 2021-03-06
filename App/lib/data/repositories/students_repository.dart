import '../../logic/entities/student.dart';
import '../data_providers/students_data_provider.dart';

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

  Future<StudentEntity> studentArrived(int cardId, int courseId) async {
    return StudentEntity.fromModel(
      (await remoteDataProvider.studentArrived(cardId, courseId)),
    );
  }

  Future<StudentEntity> studentLeft(int cardId, int courseId) async {
    return StudentEntity.fromModel(
      (await remoteDataProvider.studentLeft(cardId, courseId)),
    );
  }
}
