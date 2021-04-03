import 'package:equatable/equatable.dart';
import 'package:jedi/core/utils/format_date.dart';

class Student extends Equatable {
  final int id;
  final int certificateNumber;
  final String fullName;
  final int studentNumber;
  final int courseId;
  final bool isPresent;

  Student({
    required this.id,
    required this.certificateNumber,
    required this.fullName,
    required this.studentNumber,
    required this.courseId,
    required this.isPresent,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'certificate_number': certificateNumber,
      'full_name': fullName,
      'student_number': studentNumber,
      'course_id': courseId,
      'is_present': isPresent,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      certificateNumber: json['certificate_number'],
      fullName: json['full_name'],
      studentNumber: json['student_number'],
      courseId: json['course_id'],
      isPresent: json['is_present'],
    );
  }

  @override
  List<Object> get props => [
        id,
        certificateNumber,
        fullName,
        studentNumber,
        courseId,
        isPresent,
      ];
}
