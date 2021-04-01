part of 'students_bloc.dart';

@immutable
abstract class StudentsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StudentsFetch extends StudentsEvent {
  final int courseId;

  StudentsFetch({required this.courseId});

  @override
  List<Object> get props => [courseId];
}

class StudentLeft extends StudentsEvent {
  final int studentId;

  StudentLeft({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

class StudentArrived extends StudentsEvent {
  final int studentId;

  StudentArrived({required this.studentId});

  @override
  List<Object> get props => [studentId];
}
