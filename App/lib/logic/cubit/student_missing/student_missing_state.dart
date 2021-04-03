part of 'student_missing_cubit.dart';

abstract class StudentMissingState extends Equatable {
  const StudentMissingState();

  @override
  List<Object> get props => [];
}

class StudentMissingTodayFetchInProgress extends StudentMissingState {}

class StudentMissingTodayFetchSuccess extends StudentMissingState {
  final List<StudentMissingEntity> missingStudents;

  StudentMissingTodayFetchSuccess({required this.missingStudents});

  @override
  List<Object> get props => [missingStudents];

  Either<NoReasonReported, MissingReasonEntity> getStudentMissingReason(
      {required int studentId}) {
    try {
      return Right(missingStudents
          .firstWhere((missngStudent) => missngStudent.studentId == studentId)
          .reason);
    } on StateError {
      return Left(NoReasonReported());
    }
  }
}
