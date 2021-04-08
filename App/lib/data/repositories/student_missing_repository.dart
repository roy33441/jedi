import '../../logic/entities/student_missing.dart';
import '../data_providers/student_missing_provider.dart';

class StudentMissingRepository {
  final StudentMissingRemoteDataProvider remoteDataProvider;

  StudentMissingRepository({required this.remoteDataProvider});

  Future<List<StudentMissingEntity>> getMissingStudentsToday() async {
    final rawMissingStudents =
        await remoteDataProvider.readStudentsMissingToday();

    return List<StudentMissingEntity>.from(rawMissingStudents.map(
        (rawMissingStudent) =>
            StudentMissingEntity.fromModel(rawMissingStudent)));
  }
}
