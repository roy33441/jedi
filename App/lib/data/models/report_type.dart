import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReportType extends Equatable {
  final int id;
  final String name;

  ReportType({required this.id, required this.name});
  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toJson() {
    return {
      'report_type_id': id,
      'report_type_name': name,
    };
  }

  factory ReportType.fromJson(Map<String, dynamic> map) {
    return ReportType(
      id: map['report_type_id'],
      name: map['report_type_name'],
    );
  }
}
