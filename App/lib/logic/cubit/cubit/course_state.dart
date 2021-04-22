part of 'course_cubit.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];

  Map<String, dynamic> toJson() {
    return {};
  }
}

class CourseInitial extends CourseState {}

class CourseFetchInProgress extends CourseState {}

class CourseFetchSuccess extends CourseState {
  final List<CourseEntity> courses;

  CourseFetchSuccess({required this.courses});
}

class CourseSelected extends CourseState {
  final CourseEntity selectedCourse;

  CourseSelected({required this.selectedCourse});

  @override
  Map<String, dynamic> toJson() {
    return selectedCourse.toModel().toJson();
  }
}
