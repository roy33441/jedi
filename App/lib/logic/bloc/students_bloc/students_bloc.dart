import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/students_repository.dart';
import '../../entities/student.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc({required this.repository}) : super(StudentFetchInProgress());

  StudentsRepository repository;

  @override
  Stream<StudentsState> mapEventToState(
    StudentsEvent event,
  ) async* {
    if (event is StudentsFetch) {
      yield* _studentFetch(event.courseId);
    } else if (event is StudentArrived) {
      yield* _studentArrived(event.cardId, event.courseId);
    } else if (event is StudentLeft) {
      yield* _studentLeft(event.cardId, event.courseId);
    }
  }

  Stream<StudentsState> _studentFetch(int courseId) async* {
    List<StudentEntity> students =
        await repository.getStudentsInCourse(courseId);

    yield StudentFetchSuccess(students: students);
  }

  Stream<StudentsState> _studentLeft(int cardId, int courseId) async* {
    StudentEntity student = await repository.studentLeft(cardId, courseId);
    yield StudentFetchSuccess(students: _replaceStudentInState(student));
  }

  Stream<StudentsState> _studentArrived(int cardId, int courseId) async* {
    StudentEntity student = await repository.studentArrived(cardId, courseId);
    yield StudentArrivedSuccess(
      arrivedStudent: student,
      students: _replaceStudentInState(student),
    );
  }

  List<StudentEntity> _replaceStudentInState(StudentEntity studentEntity) {
    final currState = state;
    if (currState is StudentFetchSuccess) {
      final List<StudentEntity> students = List.of(currState.students);
      students[students.indexWhere(
          (student) => student.id == studentEntity.id)] = studentEntity;
      return students;
    }
    // TODO throw exception clause
    throw Exception();
  }
}
