import 'package:dartz/dartz.dart';
import 'package:jedi/core/failures/failures.dart';
import 'package:jedi/data/models/missing_reason.dart';
import 'package:jedi/logic/entities/missing_reason.dart';

import '../../logic/entities/student_missing.dart';
import '../data_providers/student_missing_provider.dart';

class StudentMissingRepository {
  final StudentMissingRemoteDataProvider remoteDataProvider;

  StudentMissingRepository({required this.remoteDataProvider});

  Future<List<StudentMissingEntity>> getMissingStudentsToday(
    int courseId,
  ) async {
    final rawMissingStudents =
        await remoteDataProvider.readStudentsMissingToday(courseId);

    return List<StudentMissingEntity>.from(rawMissingStudents.map(
        (rawMissingStudent) =>
            StudentMissingEntity.fromModel(rawMissingStudent)));
  }

  Future<Either<StudentMissingReasonReportFailure, StudentMissingEntity>>
      reportStudentMissingReasonToday(
    int studentId,
    MissingReasonEntity reason,
  ) async {
    final rawStudentMissing =
        await remoteDataProvider.reportStudentMissingReasonToday(
      studentId,
      reason.toModel(),
    );

    return rawStudentMissing.fold(
      (failure) => Left(failure),
      (model) => Right(StudentMissingEntity.fromModel(model)),
    );
  }

  Future<Either<StudentMissingReasonReportFailure, StudentMissingEntity>>
      removeStudentMissingReasonToday(int studentId) async {
    final rawStudentMissing =
        await remoteDataProvider.removeStudentMissingReasonToday(studentId);

    return rawStudentMissing.fold(
      (failure) => Left(failure),
      (model) => Right(
        StudentMissingEntity.fromModel(model),
      ),
    );
  }
}
