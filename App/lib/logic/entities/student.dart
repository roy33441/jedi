import 'package:equatable/equatable.dart';

import 'package:jedi/data/models/student.dart';

class StudentEntity extends Equatable {
  final int studentId;
  final int certificateNumber;
  final String fullName;
  final int studentNumber;
  final int courseId;
  final bool isPresent;

  StudentEntity(
      {required this.studentId,
      required this.certificateNumber,
      required this.fullName,
      required this.studentNumber,
      required this.courseId,
      required this.isPresent});

  @override
  List<Object> get props => [
        studentId,
        certificateNumber,
        fullName,
        studentNumber,
        courseId,
        isPresent,
      ];

  factory StudentEntity.fromModel(Student student) {
    return StudentEntity(
        studentId: student.studentId,
        certificateNumber: student.certificateNumber,
        fullName: student.fullName,
        studentNumber: student.studentNumber,
        courseId: student.courseId,
        isPresent: student.isPresent);
  }

  Student toModel() {
    return Student(
        studentId: studentId,
        certificateNumber: certificateNumber,
        fullName: fullName,
        studentNumber: studentNumber,
        courseId: courseId,
        isPresent: isPresent);
  }

  StudentEntity copyWith({
    int? studentId,
    int? certificateNumber,
    String? fullName,
    int? studentNumber,
    int? courseId,
    bool? isPresent,
  }) {
    return StudentEntity(
      studentId: studentId ?? this.studentId,
      certificateNumber: certificateNumber ?? this.certificateNumber,
      fullName: fullName ?? this.fullName,
      studentNumber: studentNumber ?? this.studentNumber,
      courseId: courseId ?? this.courseId,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
