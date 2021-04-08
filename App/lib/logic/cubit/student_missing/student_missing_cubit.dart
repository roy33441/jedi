import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/student_missing_repository.dart';
import '../../entities/missing_reason.dart';
import '../../entities/student_missing.dart';

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
