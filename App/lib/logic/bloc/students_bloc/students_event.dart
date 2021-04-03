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
  final int cardId;
  final int courseId;

  StudentLeft({required this.cardId, required this.courseId});

  @override
  List<Object> get props => [cardId, courseId];
}

class StudentArrived extends StudentsEvent {
  final int cardId;
  final int courseId;

  StudentArrived({required this.cardId, required this.courseId});

  @override
  List<Object> get props => [cardId, courseId];
}
