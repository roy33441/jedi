import 'package:equatable/equatable.dart';
import 'package:jedi/data/models/report_type.dart';

class ReportTypeEntity extends Equatable {
  final int id;
  final String name;

  ReportTypeEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  ReportType toModel() => ReportType(id: id, name: name);

  factory ReportTypeEntity.fromModel(ReportType reportType) {
    return ReportTypeEntity(id: reportType.id, name: reportType.name);
  }
}
