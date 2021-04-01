import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReportType extends Equatable {
  final int reportTypeId;
  final String name;

  ReportType({required this.reportTypeId, required this.name});
  @override
  List<Object?> get props => [reportTypeId, name];

  Map<String, dynamic> toMap() {
    return {
      'reportTypeId': reportTypeId,
      'name': name,
    };
  }

  factory ReportType.fromJson(Map<String, dynamic> map) {
    return ReportType(
      reportTypeId: map['report_type_id'],
      name: map['report_type_name'],
    );
  }

  String toJson() => json.encode(toMap());
}
