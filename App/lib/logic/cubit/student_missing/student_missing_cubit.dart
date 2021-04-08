import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jedi/data/repositories/student_missing_repository.dart';
import 'package:jedi/logic/entities/missing_reason.dart';
import 'package:jedi/logic/entities/student_missing.dart';
import 'package:dartz/dartz.dart';
part 'student_missing_state.dart';

class StudentMissingCubit extends Cubit<StudentMissingState> {
  final StudentMissingRepository repository;

  StudentMissingCubit({required this.repository})
      : super(StudentMissingTodayFetchInProgress());

  Future<void> getMissingStudentsToday() async {
    emit(StudentMissingTodayFetchInProgress());
    final missingStudentsToday = await repository.getMissingStudentsToday();
    emit(
        StudentMissingTodayFetchSuccess(missingStudents: missingStudentsToday));
  }
}
