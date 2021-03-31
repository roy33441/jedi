part of 'students_bloc.dart';

@immutable
abstract class StudentsState {}

class StudentFetchSuccess extends StudentsState {
  final List<StudentEntity> students;

  StudentFetchSuccess({
    required this.students,
  });

  int get missingStudents =>
      [...students].where((student) => !student.isPresent).length;

  int get arrivedStudents =>
      [...students].where((student) => student.isPresent).length;
}

class StudentArrivedSuccess extends StudentFetchSuccess {
  final StudentEntity arrivedStudent;

  StudentArrivedSuccess(
      {required this.arrivedStudent, required List<StudentEntity> students})
      : super(students: students);
}

class StudentFetchInProgress extends StudentsState {}
