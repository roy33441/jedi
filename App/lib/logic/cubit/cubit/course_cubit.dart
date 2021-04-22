import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jedi/data/models/course.dart';
import 'package:jedi/data/repositories/courses_repository.dart';
import 'package:jedi/logic/entities/course_entity.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> with HydratedMixin {
  final CoursesRepository repository;

  CourseCubit({required this.repository}) : super(CourseInitial());

  Future<void> fetchOpenCourses() async {
    emit(CourseFetchInProgress());
    final openCourses = await repository.fetchOpenCourses();
    emit(CourseFetchSuccess(courses: openCourses));
  }

  @override
  CourseState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      return CourseSelected(
        selectedCourse: CourseEntity.fromModel(
          Course.fromJson(json),
        ),
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(CourseState state) {
    return state.toJson();
  }
}
