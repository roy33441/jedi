import 'package:equatable/equatable.dart';
import 'package:jedi/core/utils/format_date.dart';
import 'package:jedi/data/models/course.dart';

class CourseEntity extends Equatable {
  final int id;
  final String name;
  final String colorTheme;
  final DateTime dateEnding;

  CourseEntity({
    required this.id,
    required this.name,
    required this.colorTheme,
    required this.dateEnding,
  });

  @override
  List<Object?> get props => [id, name, colorTheme, dateEnding];

  Course toModel() {
    return Course(
      id: id,
      name: name,
      colorTheme: colorTheme,
      dateEnding: dateEnding,
    );
  }

  factory CourseEntity.fromModel(Course model) {
    return CourseEntity(
      id: model.id,
      name: model.name,
      colorTheme: model.colorTheme,
      dateEnding: model.dateEnding,
    );
  }
}
