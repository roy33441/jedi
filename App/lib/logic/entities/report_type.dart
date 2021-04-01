import 'package:equatable/equatable.dart';
import 'package:jedi/data/models/report_type.dart';

class ReportTypeEntity extends Equatable {
  final int reportTypeId;
  final String name;

  ReportTypeEntity({required this.reportTypeId, required this.name});

  @override
  List<Object?> get props => [reportTypeId, name];

  ReportType toModel() => ReportType(reportTypeId: reportTypeId, name: name);

  factory ReportTypeEntity.fromModel(ReportType reportType) {
    return ReportTypeEntity(
        reportTypeId: reportType.reportTypeId, name: reportType.name);
  }
}
