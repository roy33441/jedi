import 'package:equatable/equatable.dart';
import 'package:jedi/core/utils/format_date.dart';

class Course extends Equatable {
  final int id;
  final String name;
  final String colorTheme;
  final DateTime dateEnding;

  Course({
    required this.id,
    required this.name,
    required this.colorTheme,
    required this.dateEnding,
  });

  @override
  List<Object?> get props => [id, name, colorTheme, dateEnding];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'colorTheme': colorTheme,
      'dateEnding': FormatDate.format(dateEnding),
    };
  }

  factory Course.fromJson(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      name: map['name'],
      colorTheme: map['colorTheme'],
      dateEnding: FormatDate.parse(map['dateEnding']),
    );
  }
}
